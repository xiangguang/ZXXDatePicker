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
}

@property (nonatomic, strong) UIPickerView *datePicker;
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) NSCalendar *currentCalendar;

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
        
        self.currentDate = [NSDate date];
        self.currentCalendar = [NSCalendar currentCalendar];
        
        _datePickerMode = datePickerMode;
        _minimumYear = 1900;

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
        {
            NSMutableArray *yearArray = [NSMutableArray arrayWithCapacity:0];
            for (NSInteger i=_minimumYear; i<=_maximumYear; i++) {
                [yearArray addObject:[NSString stringWithFormat:@"%ld",i]];
            }
            self.dataArray = yearArray;
        }
            break;
        case ZXXDatePickerModeMonth:
            self.dataArray = @[self.currentCalendar.veryShortMonthSymbols];
            break;
        case ZXXDatePickerModeMonthAndDay:
            
            break;
        case ZXXDatePickerModeYearAndMonth:
            
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
    NSDateComponents *dateComponents = [self.currentCalendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    _maximumYear = dateComponents.year;
}

- (void)setCurrentCalendar:(NSCalendar *)currentCalendar
{
    _currentCalendar = currentCalendar;
    
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

- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[];
    }
    return _dataArray;
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
    
}

@end
