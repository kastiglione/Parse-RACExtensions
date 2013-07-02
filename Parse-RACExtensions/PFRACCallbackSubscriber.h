//
//  PFRACCallbackSubscriber.h
//  Parse-RACExtensions
//
//  Created by Dave Lee on 2013-07-02.
//  Copyright (c) 2013 Dave Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/PFConstants.h>

@protocol RACSubscriber;

PFBooleanResultBlock PFRACBooleanCallback(id<RACSubscriber> subscriber);