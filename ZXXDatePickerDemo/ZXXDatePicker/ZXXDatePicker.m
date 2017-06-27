//
//  ZXXDatePicker.m
//  ZXXDatePickerDemo
//
//  Created by zhaoxiangguang on 2017/6/20.
//
//

#import "ZXXDatePicker.h"

//default value
#define kZXXDatePickerItemHeight 35

@interface ZXXDatePicker ()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    ZXXDatePickerMode _datePickerMode;
    
    NSInteger _currentYear;
    NSInteger _currentMonth;
    NSInteger _currentDay;
}

@property (nonatomic, strong) UIPickerView *datePicker;
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) NSCalendar *currentCalendar;
@property (nonatomic, strong) NSMutableArray *yearArray;
@property (nonatomic, strong) NSMutableArray *monthArray;
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
            self.dataArray = @[self.currentCalendar.veryShortMonthSymbols];
            break;
        case ZXXDatePickerModeMonthAndDay:
            self.dataArray = @[self.currentCalendar.veryShortMonthSymbols,self.dayArray];
            break;
        case ZXXDatePickerModeYearAndMonth:
            self.dataArray = @[self.yearArray,self.currentCalendar.veryShortMonthSymbols];
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
    NSDateComponents *dateComponents = [self.currentCalendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self.currentDate];
    _maximumYear = dateComponents.year;
}

- (void)setCurrentCalendar:(NSCalendar *)currentCalendar
{
    _currentCalendar = currentCalendar;
    
    [self updateMaximumYear];
    [self initDataArray];
}

#pragma mark - UIPickerView

- (UIPickerView *)datePicker
{
    if (!_datePicker) {
        _datePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        _datePicker.dataSource = self;
        _datePicker.delegate = self;
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
            
            [_dayArray addObject:[NSString stringWithFormat:@"%ld",numberOfDaysInMonth]];
        }
    }
    
    return _dayArray;
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
    if ([_delegate respondsToSelector:@selector(zxxDatePicker:valueChanged:)]) {
        [_delegate zxxDatePicker:self valueChanged:nil];
    }
}

@end
