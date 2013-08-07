//
//  PFQuery+RACExtensions.m
//  Parse-RACExtensions
//
//  Created by Dave Lee on 2013-06-28.
//  Copyright (c) 2013 Dave Lee. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "PFQuery+RACExtensions.h"
#import "PFRACCallbacks.h"

@implementation PFQuery (RACExtensions)

- (RACSignal *)rac_getObjectWithId:(NSString *)objectId {
	return [[RACSignal createSignal:^(id<RACSubscriber> subscriber) {
		[self getObjectInBackgroundWithId:objectId block:PFRACObjectCallback(subscriber)];

		return [RACDisposable disposableWithBlock:^{
			[self cancel];
		}];
	}]
	setNameWithFormat:@"%@ -rac_getObjectWithId", self];
}

- (RACSignal *)rac_findObjects {
	return [[RACSignal createSignal:^(id<RACSubscriber> subscriber) {
		[self findObjectsInBackgroundWithBlock:PFRACObjectCallback(subscriber)];

		return [RACDisposable disposableWithBlock:^{
			[self cancel];
		}];
	}]
	setNameWithFormat:@"%@ -rac_findObjects", self];
}

- (RACSignal *)rac_getFirstObject {
	return [[RACSignal createSignal:^(id<RACSubscriber> subscriber) {
		[self getFirstObjectInBackgroundWithBlock:PFRACObjectCallback(subscriber)];

		return [RACDisposable disposableWithBlock:^{
			[self cancel];
		}];
	}]
	setNameWithFormat:@"%@ -rac_getFirstObject", self];
}

- (RACSignal *)rac_countObjects {
	return [[RACSignal createSignal:^(id<RACSubscriber> subscriber) {
		[self countObjectsInBackgroundWithBlock:PFRACIntegerCallback(subscriber)];

		return [RACDisposable disposableWithBlock:^{
			[self cancel];
		}];
	}]
	setNameWithFormat:@"%@ -rac_countObjects", self];
}

@end
