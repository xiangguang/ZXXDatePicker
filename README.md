# ZXXDatePicker
Customer DateTime Picker,Support type:
ZXXDatePickerModeYearAndMonth,
ZXXDatePickerModeMonthAndDay,
ZXXDatePickerModeYear,
ZXXDatePickerModeMonth,
ZXXDatePickerModeWeek,
ZXXDatePickerModeQuarter,

# How to use

    ZXXDatePicker *datePicker = [[ZXXDatePicker alloc] initWithFrame:CGRectMake(0, 150, self.view.frame.size.width, 200) datePickerMode:ZXXDatePickerModeQuarter];
    datePicker.delegate = self;
    [self.view addSubview:datePicker];
    
    or
    
    ZXXDatePicker *datePicker = [[ZXXDatePicker alloc] initWithFrame:CGRectMake(0, 150, self.view.frame.size.width, 200) datePickerMode:ZXXDatePickerModeQuarter];
    datePicker.delegate = self;
    [datePicker showPickerInView:self.view];

# Delegate 

-- (void)zxxDatePicker:(ZXXDatePicker *)datePicker valueChanged:(ZXXDateModel *)dateModel;
