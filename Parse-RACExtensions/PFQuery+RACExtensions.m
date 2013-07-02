//
//  PFQuery+RACExtensions.m
//  Parse-RACExtensions
//
//  Created by Dave Lee on 2013-06-28.
//  Copyright (c) 2013 Dave Lee. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/EXTScope.h>

#import "PFQuery+RACExtensions.h"
#import "PFRACCallbacks.h"

@implementation PFQuery (RACExtensions)

- (RACSignal *)rac_getObjectWithId:(NSString *)objectId {
	@weakify(self);
	return [RACSignal createSignal:^(id<RACSubscriber> subscriber) {
		[self getObjectInBackgroundWithId:objectId block:PFRACObjectCallback(subscriber)];

		return [RACDisposable disposableWithBlock:^{
			@strongify(self);
			[self cancel];
		}];
	}];
}

- (RACSignal *)rac_findObjects {
	@weakify(self);
	return [RACSignal createSignal:^(id<RACSubscriber> subscriber) {
		[self findObjectsInBackgroundWithBlock:PFRACObjectCallback(subscriber)];

		return [RACDisposable disposableWithBlock:^{
			@strongify(self);
			[self cancel];
		}];
	}];
}

- (RACSignal *)rac_getFirstObject {
	@weakify(self);
	return [RACSignal createSignal:^(id<RACSubscriber> subscriber) {
		[self getFirstObjectInBackgroundWithBlock:PFRACObjectCallback(subscriber)];

		return [RACDisposable disposableWithBlock:^{
			@strongify(self);
			[self cancel];
		}];
	}];
}

- (RACSignal *)rac_countObjects {
	@weakify(self);
	return [RACSignal createSignal:^(id<RACSubscriber> subscriber) {
		[self countObjectsInBackgroundWithBlock:PFRACIntegerCallback(subscriber)];

		return [RACDisposable disposableWithBlock:^{
			@strongify(self);
			[self cancel];
		}];
	}];
}

@end
