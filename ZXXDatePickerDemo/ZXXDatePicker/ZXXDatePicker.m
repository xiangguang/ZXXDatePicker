//
//  ZXXDatePicker.m
//  ZXXDatePickerDemo
//
//  Created by zhaoxiangguang on 2017/6/20.
//
//

#import "ZXXDatePicker.h"

//Default values
#define kZXXDatePickerItemHeight 35
#define kZXXDatePickerMonthArray @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"]

@interface ZXXDatePicker ()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    ZXXDatePickerMode _datePickerMode;
}

@property (nonatomic, strong) UIPickerView *datePicker;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ZXXDatePicker

- (instancetype)initWithFrame:(CGRect)frame datePickerMode:(ZXXDatePickerMode)datePickerMode
{
    self = [super initWithFrame:frame];
    if (self) {
        _datePickerMode = datePickerMode;
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
            
            break;
        case ZXXDatePickerModeMonth:
            
            break;
        case ZXXDatePickerModeMonthAndDay:
            
            break;
        case ZXXDatePickerModeYearAndMonth:
            
            break;
        default:
            break;
    }

    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    
    self.dataArray = @[@[@"2010",@"2011",@"2012",@"2013",@"2014",@"2015",@"2016",@"2017"],calendar.shortStandaloneMonthSymbols];
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
