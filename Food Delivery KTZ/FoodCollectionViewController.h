//
//  FoodCollectionViewController.h
//  Food Delivery KTZ
//
//  Created by Almas Kairatuly on 11/20/15.
//  Copyright © 2015 Almas Kairatuly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface FoodCollectionViewController : UICollectionViewController

@property (strong, nonatomic) PFObject *category;

@end
