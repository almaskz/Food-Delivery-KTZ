//
//  EntranceViewController.m
//  Food Delivery KTZ
//
//  Created by Almas Kairatuly on 11/20/15.
//  Copyright © 2015 Almas Kairatuly. All rights reserved.
//

#import "EntranceViewController.h"
#import <Parse/Parse.h>
#import "DataHolder.h"

@interface EntranceViewController () <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *trainTextField;
@property (weak, nonatomic) IBOutlet UITextField *stationTextField;

@property (strong, nonatomic) NSArray *arrayOfTrains;
@property (strong, nonatomic) NSArray *arrayOfStations;

@property (strong, nonatomic) UIPickerView *trainPicker;
@property (strong, nonatomic) UIPickerView *stationPicker;

@end

@implementation EntranceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.trainTextField.delegate = self;
    self.stationTextField.delegate = self;
    
    
    self.arrayOfTrains = @[@"623Т", @"086Ц", @"807А", @"071Ц", @"803А", @"803Г", @"037Х", @"047Ц", @"656Т"];
    self.arrayOfStations = @[@"АЛМАТЫ 2", @"ПЕТРОПАВЛ", @"САРЫ-АГАЧ", @"КОКШЕТАУ 1", @"МОСКВА КАЗ", @"АТБАСАР", @"АТБАСАР", @"МАНГЫШЛАК", @"АСТАНА"];
    
    self.trainPicker = [[UIPickerView alloc]
                            initWithFrame:CGRectZero];
    self.trainPicker.delegate = self;
    self.trainPicker.dataSource = self;
    
    self.stationPicker = [[UIPickerView alloc]
                        initWithFrame:CGRectZero];
    self.stationPicker.delegate = self;
    self.stationPicker.dataSource = self;
    
    self.trainTextField.inputView = self.trainPicker;
    self.stationTextField.inputView = self.stationPicker;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.trainPicker) {
        return self.arrayOfTrains.count;
    } else {
        return self.arrayOfStations.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == self.trainPicker) {
        return self.arrayOfTrains[row];
    }
    return self.arrayOfStations[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == self.trainPicker) {
        self.trainTextField.text = self.arrayOfTrains[row];
    } else {
        self.stationTextField.text = self.arrayOfStations[row];
    }
}

- (IBAction)nextButtonPressed:(UIButton *)sender {
    
    
    PFObject *orderObject = [PFObject objectWithClassName:@"Order"];
    orderObject[@"train"] = self.trainTextField.text;
    orderObject[@"station"] = self.stationTextField.text;
    
    [orderObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (!error) {
            [DataHolder setOrder:orderObject];
            [self performSegueWithIdentifier:@"toCategoryVC" sender:nil];
        }
    }];
    
}

@end
