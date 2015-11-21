//
//  DataHolder.h
//  Food Delivery KTZ
//
//  Created by Almas Kairatuly on 11/20/15.
//  Copyright © 2015 Almas Kairatuly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface DataHolder : NSObject

+(void) setOrder: (PFObject *) order;
+(PFObject *) getOrder;

@end
