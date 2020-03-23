//
//  ZXXDatePicker.h
//  ZXXDatePickerDemo
//
//  Created by zhaoxiangguang on 2017/6/20.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZXXDatePickerMode) {
    ZXXDatePickerModeYearAndMonth,  //Displays year and month (e.g. 2017 | 6)
    ZXXDatePickerModeMonthAndDay,   //Displays month and day (e.g. 06 | 20)
    ZXXDatePickerModeYear,          //Displays year (e.g. 2017)
    ZXXDatePickerModeMonth,         //Displays month (e.g. 6)
    ZXXDatePickerModeWeek,          //Displays month (e.g. Monday)
    ZXXDatePickerModeQuarter,       //Displays month (e.g. 1st quarter)
};

@interface ZXXDateModel : NSObject

@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) NSInteger week;
@property (nonatomic, assign) NSInteger quarter;

@end

@class ZXXDatePicker;
@protocol ZXXDatePickerDelegate <NSObject>

- (void)zxxDatePicker:(ZXXDatePicker *)datePicker
         valueChanged:(ZXXDateModel *)dateModel;

@end

@interface ZXXDatePicker : UIView

@property (nonatomic, weak) id<ZXXDatePickerDelegate> delegate;
@property (nonatomic, strong, readonly) UIPickerView *datePicker;

@property (nonatomic, strong) NSDate *currentDate;//Default is [NSDate date]
@property (nonatomic, assign) NSInteger minimumYear;//Default is 1900
@property (nonatomic, assign) NSInteger maximumYear;//Default is Now

- (instancetype)initWithFrame:(CGRect)frame
               datePickerMode:(ZXXDatePickerMode)datePickerMode;

/**
 Show Picker

 @param view The super view
 */
- (void)showPickerInView:(UIView *)view;

/**
 Dismiss the picker view
 */
- (void)hiddenPicker;
@end
