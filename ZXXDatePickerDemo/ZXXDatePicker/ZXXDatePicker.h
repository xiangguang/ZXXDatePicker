//
//  ZXXDatePicker.h
//  ZXXDatePickerDemo
//
//  Created by zhaoxiangguang on 2017/6/20.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZXXDatePickerMode) {
    ZXXDatePickerModeYearAndMonth,  //Displays year and month (e.g. 2017 | 06)
    ZXXDatePickerModeMonthAndDay,   //Displays month and day (e.g. 06 | 20)
    ZXXDatePickerModeYear,          //Displays year (e.g. 2017)
    ZXXDatePickerModeMonth,         //Displays month (e.g. 6)
    ZXXDatePickerModeWeek,          //Displays month (e.g. Monday)
    ZXXDatePickerModeQuarter,       //Displays month (e.g. Monday)
};

@interface ZXXDateModel : NSObject

@property (nonatomic, copy) NSString *year;
@property (nonatomic, copy) NSString *month;
@property (nonatomic, copy) NSString *day;
@property (nonatomic, copy) NSString *week;

@end

@class ZXXDatePicker;
@protocol ZXXDatePickerDelegate <NSObject>

- (void)zxxDatePicker:(ZXXDatePicker *)datePicker valueChanged:(ZXXDateModel *)dateModel;

@end

@interface ZXXDatePicker : UIView

@property (nonatomic, weak) id<ZXXDatePickerDelegate> delegate;
@property (nonatomic, strong, readonly) UIPickerView *datePicker;


@property (nonatomic, strong) NSCalendar *currentCalendar;//Default is [NSCalendar currentCalendar]
@property (nonatomic, assign) int minimumYear;

- (instancetype)initWithFrame:(CGRect)frame
               datePickerMode:(ZXXDatePickerMode)datePickerMode;
@end
