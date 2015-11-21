//
//  DataHolder.m
//  Food Delivery KTZ
//
//  Created by Almas Kairatuly on 11/20/15.
//  Copyright © 2015 Almas Kairatuly. All rights reserved.
//

#import "DataHolder.h"

@implementation DataHolder

static PFObject *orderObject;

+(void)setOrder:(PFObject *)order
{
    orderObject = order;
}

+(PFObject *)getOrder
{
    return orderObject;
}

@end
