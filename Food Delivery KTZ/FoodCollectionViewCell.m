//
//  FoodCollectionViewCell.m
//  Food Delivery KTZ
//
//  Created by Almas Kairatuly on 11/20/15.
//  Copyright © 2015 Almas Kairatuly. All rights reserved.
//

#import "FoodCollectionViewCell.h"


@implementation FoodCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (IBAction)addButtonPressed:(id)sender {
    NSLog(@"hello I am here in button pressed");
    self.didTapButtonBlock(sender);
}

@end
