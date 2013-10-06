//
//  PFCloud+RACExtensions.m
//  Parse-RACExtensions
//
//  Created by Dave Lee on 2013-08-05.
//  Copyright (c) 2013 Dave Lee. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "PFCloud+RACExtensions.h"
#import "PFRACCallbacks.h"

@implementation PFCloud (RACExtensions)

+ (RACSignal *)rac_callFunction:(NSString *)function withParameters:(NSDictionary *)parameters {
	return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		[self callFunctionInBackground:function withParameters:parameters block:PFRACObjectCallback(subscriber)];
		return nil;
	}]
	setNameWithFormat:@"PFCloud +rac_callFunction: %@ withParameters: %@", function, parameters];
}

@end
