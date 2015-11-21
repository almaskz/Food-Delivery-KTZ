//
//  UserDetailsViewController.m
//  Food Delivery KTZ
//
//  Created by Almas Kairatuly on 11/20/15.
//  Copyright © 2015 Almas Kairatuly. All rights reserved.
//

#import "UserDetailsViewController.h"
#import <Parse/Parse.h>
#import "DataHolder.h"

@interface UserDetailsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *trainTextField;

@end

@implementation UserDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)confirmButtonPressed:(id)sender {
    
    
    PFObject *orderObject = [DataHolder getOrder];
    orderObject[@"name"] = self.nameTextField.text;
    orderObject[@"phone"] = self.phoneTextField.text;
    orderObject[@"email"] = self.emailTextField.text;
    orderObject[@"wagon"] = self.trainTextField.text;
    
    [orderObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (!error) {
            [self.navigationController popViewControllerAnimated:YES];
            PFPush *push = [[PFPush alloc] init];
            [push setChannel:@"manager"];
            [push setMessage: [NSString stringWithFormat:@"Новый заказ от %@", self.nameTextField.text]];
            [push sendPushInBackground];
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
