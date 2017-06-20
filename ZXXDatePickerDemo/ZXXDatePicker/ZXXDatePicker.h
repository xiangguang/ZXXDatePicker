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
    ZXXDatePickerModeMonth,         //Displays month (e.g. 06)
};

@class ZXXDatePicker;
@protocol ZXXDatePickerDelegate <NSObject>

- (void)zxxDatePicker:(ZXXDatePicker *)datePicker valueChanged:(NSString *)date;

@end

@interface ZXXDatePicker : UIView

@property (nonatomic, weak) id<ZXXDatePickerDelegate> delegate;
@property (nonatomic, strong, readonly) UIPickerView *datePicker;

@property (nonatomic, assign) int minimumYear;

- (instancetype)initWithFrame:(CGRect)frame
               datePickerMode:(ZXXDatePickerMode)datePickerMode;
@end
