//
//  ViewController.m
//  ZXXDatePickerDemo
//
//  Created by zhaoxiangguang on 2017/6/20.
//
//

#import "ViewController.h"
#import "ZXXDatePicker/ZXXDatePicker.h"

@interface ViewController ()<ZXXDatePickerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    ZXXDatePicker *datePicker = [[ZXXDatePicker alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 200) datePickerMode:ZXXDatePickerModeQuarter];
    datePicker.delegate = self;
    [self.view addSubview:datePicker];
}

- (void)zxxDatePicker:(ZXXDatePicker *)datePicker valueChanged:(ZXXDateModel *)dateModel
{
    NSLog(@"%@",dateModel.description);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
