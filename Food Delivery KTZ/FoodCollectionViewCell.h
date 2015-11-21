//
//  FoodCollectionViewCell.h
//  Food Delivery KTZ
//
//  Created by Almas Kairatuly on 11/20/15.
//  Copyright © 2015 Almas Kairatuly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameTextField;
@property (weak, nonatomic) IBOutlet UILabel *priceTextField;
- (IBAction)addButtonPressed:(id)sender;

@property (copy, nonatomic) void (^didTapButtonBlock)(id sender);
- (void)setDidTapButtonBlock:(void (^)(id sender))didTapButtonBlock;

@end
