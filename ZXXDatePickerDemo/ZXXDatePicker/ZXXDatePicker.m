//
//  ZXXDatePicker.m
//  ZXXDatePickerDemo
//
//  Created by zhaoxiangguang on 2017/6/20.
//
//

#import "ZXXDatePicker.h"

@implementation ZXXDateModel

- (NSString *)description
{
    NSString *desc = [NSString stringWithFormat:@"%ld-%ld-%ld week:%ld quarter:%ld",self.year,self.month,self.day,self.week,self.quarter];
    
    return desc;
}

@end

//default value
#define kZXXDatePickerItemHeight 35

@interface ZXXDatePicker ()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    ZXXDatePickerMode _datePickerMode;
    
    NSInteger _currentYear;
    NSInteger _currentMonth;
    NSInteger _currentDay;
    NSInteger _currentWeek;
    NSInteger _currentQuarter;
    
    ZXXDateModel *_dateModel;
    
    UIView *bgView;
}

@property (nonatomic, strong) UIPickerView *datePicker;
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) NSCalendar *currentCalendar;
@property (nonatomic, strong) NSMutableArray *yearArray;
@property (nonatomic, strong) NSArray *monthArray;
@property (nonatomic, strong) NSMutableArray *dayArray;

@end

@implementation ZXXDatePicker

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame datePickerMode:(ZXXDatePickerMode)datePickerMode
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _dateModel = [[ZXXDateModel alloc] init];
        _currentDate = [NSDate date];
        _currentCalendar = [NSCalendar currentCalendar];
        
        _datePickerMode = datePickerMode;
        _minimumYear = 1900;

        [self updateMaximumYear];
        
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews
{
    [self initDataArray];
    
    [self addSubview:self.datePicker];
}

- (void)initDataArray
{
    switch (_datePickerMode) {
        case ZXXDatePickerModeYear:
            self.dataArray = @[self.yearArray];
            break;
        case ZXXDatePickerModeMonth:
            self.dataArray = @[self.monthArray];
            break;
        case ZXXDatePickerModeMonthAndDay:
            self.dataArray = @[self.monthArray,self.dayArray.firstObject];
            break;
        case ZXXDatePickerModeYearAndMonth:
            self.dataArray = @[self.yearArray,self.monthArray];
            break;
        case ZXXDatePickerModeWeek:
            self.dataArray = @[self.currentCalendar.weekdaySymbols];
            break;
        case ZXXDatePickerModeQuarter:
            self.dataArray = @[self.currentCalendar.quarterSymbols];
            break;
    }
}

- (void)updateMaximumYear
{
    NSDateComponents *dateComponents = [self.currentCalendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitQuarter fromDate:self.currentDate];
    _currentYear = dateComponents.year;
    _currentMonth = dateComponents.month;
    _currentDay = dateComponents.day;
    _currentWeek = dateComponents.weekday;
    _currentQuarter = dateComponents.quarter;
    
    _maximumYear = _currentYear;
    
    _dateModel.year = _currentYear;
    _dateModel.month = _currentMonth;
    _dateModel.day = _currentDay;
    _dateModel.week = _currentWeek;
    _dateModel.quarter = _currentQuarter;
}

- (void)setCurrentCalendar:(NSCalendar *)currentCalendar
{
    _currentCalendar = currentCalendar;
    
    [self updateMaximumYear];
    [self initDataArray];
    
    [self.datePicker reloadAllComponents];
}

#pragma mark - UIPickerView

- (UIPickerView *)datePicker
{
    if (!_datePicker) {
        _datePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        _datePicker.dataSource = self;
        _datePicker.delegate = self;
        _datePicker.showsSelectionIndicator = YES;
    }
    return _datePicker;
}

#pragma mark - Array

- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[];
    }
    return _dataArray;
}

- (NSMutableArray *)dayArray
{
    if (!_dayArray) {
        _dayArray = [NSMutableArray arrayWithCapacity:0];
        NSDateComponents *components = [self.currentCalendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self.currentDate];
        for (int i =1; i<= 12; i++) {
            components.month = i;
            
            NSDate *date = [self.currentCalendar dateFromComponents:components];
            NSRange range = [self.currentCalendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
            NSUInteger numberOfDaysInMonth = range.length;
            
            NSMutableArray *daysArray = [NSMutableArray arrayWithCapacity:0];
            for (int dayIndex = 1; dayIndex<= numberOfDaysInMonth; dayIndex++) {
                [daysArray addObject:[NSString stringWithFormat:@"%d",dayIndex]];
            }
            [_dayArray addObject:daysArray];
        }
    }
    
    return _dayArray;
}

- (NSArray *)monthArray
{
    if (!_monthArray) {
        _monthArray = self.currentCalendar.veryShortMonthSymbols;
    }
    return _monthArray;
}

- (NSMutableArray *)yearArray
{
    if (!_yearArray) {
        _yearArray = [NSMutableArray arrayWithCapacity:0];
        for (NSInteger i=_minimumYear; i<=_maximumYear; i++) {
            [_yearArray addObject:[NSString stringWithFormat:@"%ld",i]];
        }
    }
    return _yearArray;
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.dataArray.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray *array = self.dataArray[component];
    
    return array.count;
}

#pragma mark - UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return CGRectGetWidth(self.frame) / self.dataArray.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return kZXXDatePickerItemHeight;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *array = self.dataArray[component];
    return array[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (_datePickerMode) {
        case ZXXDatePickerModeYear:
        {
            _dateModel.year = [self.yearArray[row] integerValue];
        }
            break;
        case ZXXDatePickerModeMonth:
        {
            _dateModel.month = [self.monthArray[row] integerValue];
        }
            break;
        case ZXXDatePickerModeMonthAndDay:
        {
            if (component == 0) {
                NSArray *array = self.dayArray[row];
                self.dataArray = @[self.monthArray,array];
                
                [self.datePicker reloadComponent:1];
                
                _dateModel.month = [self.monthArray[row] integerValue];
            }else{
                NSArray *componentDayArray = self.dayArray[component];
                _dateModel.month = [componentDayArray[row] integerValue];
            }
        }
            break;
        case ZXXDatePickerModeYearAndMonth:
        {
            if (component == 0) {
                _dateModel.year = [self.yearArray[row] integerValue];
            }else{
                _dateModel.month = [self.monthArray[row] integerValue];
            }
        }
            break;
        case ZXXDatePickerModeWeek:
        {
            _dateModel.week = row;
        }
            break;
        case ZXXDatePickerModeQuarter:
        {
            _dateModel.quarter = row;
        }
            break;
    }

    [self callback];
}

- (void)callback
{
    if ([_delegate respondsToSelector:@selector(zxxDatePicker:valueChanged:)]) {
        [_delegate zxxDatePicker:self valueChanged:_dateModel];
    }
}

#pragma mark - Show

#define kZXXDatePickerBgViewHeight 260
#define kZXXDatePickerToolBarHeight 40

- (void)showPickerInView:(UIView *)view
{
    if (bgView && !bgView.hidden) {
        return;
    }
    
    CGRect frame = self.frame;
    frame.origin.y = kZXXDatePickerToolBarHeight;
    frame.size.height = kZXXDatePickerBgViewHeight - kZXXDatePickerToolBarHeight;
    self.frame = frame;
    
    _datePicker.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    [_datePicker reloadAllComponents];
    
    CGFloat sw = CGRectGetWidth(view.frame);
    CGFloat sh = CGRectGetHeight(view.frame);
    
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, sh, sw, kZXXDatePickerBgViewHeight)];
    [bgView addSubview:self];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, sw, kZXXDatePickerToolBarHeight)];
    [bgView addSubview:toolBar];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelPickerView)];
    UIBarButtonItem *fixButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *okButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(okButtonClicked)];
    toolBar.items = @[cancelButton,fixButton,okButton];
    [view addSubview:bgView];
    
    
    [self showPicker];
}

- (void)showPicker
{
    self.hidden = NO;
    
    CGFloat sw = CGRectGetWidth(bgView.superview.frame);
    CGFloat sh = CGRectGetHeight(bgView.superview.frame);
    [UIView animateWithDuration:0.4 animations:^{
        bgView.frame = CGRectMake(0, sh-kZXXDatePickerBgViewHeight, sw , kZXXDatePickerBgViewHeight);
    }];
}

- (void)hiddenPicker
{
    CGFloat sw = CGRectGetWidth(bgView.frame);
    CGFloat sh = CGRectGetHeight(bgView.superview.frame);
    
    [UIView animateWithDuration:0.4 animations:^{
        bgView.frame = CGRectMake(0, sh, sw, kZXXDatePickerBgViewHeight);
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

- (void)cancelPickerView
{
    [self hiddenPicker];
}

- (void)okButtonClicked
{
    [self callback];
    
    [self hiddenPicker];
}


@end
