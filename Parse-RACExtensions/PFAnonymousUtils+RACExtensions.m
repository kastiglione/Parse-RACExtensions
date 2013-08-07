//
//  PFAnonymousUtils+RACExtensions.m
//  Parse-RACExtensions
//
//  Created by Dave Lee on 2013-06-29.
//  Copyright (c) 2013 Dave Lee. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "PFAnonymousUtils+RACExtensions.h"
#import "PFRACCallbacks.h"

@implementation PFAnonymousUtils (RACExtensions)

+ (RACSignal *)rac_logIn {
	return [[RACSignal createSignal:^RACDisposable * (id<RACSubscriber> subscriber) {
		[self logInWithBlock:PFRACObjectCallback(subscriber)];
		return nil;
	}]
	setNameWithFormat:@"+rac_logIn"];
}

@end
