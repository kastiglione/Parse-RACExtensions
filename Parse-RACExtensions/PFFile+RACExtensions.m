//
//  PFFile+RACExtensions.m
//  Parse-RACExtensions
//
//  Created by Dave Lee on 2013-08-01.
//  Copyright (c) 2013 Dave Lee. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "PFFile+RACExtensions.h"
#import "PFRACCallbacks.h"

@implementation PFFile (RACExtensions)

- (RACSignal *)rac_save {
	return [RACSignal createSignal:^(id<RACSubscriber> subscriber) {
		[self saveInBackgroundWithBlock:PFRACBooleanCallback(subscriber) progressBlock:^(int percentDone) {
			[subscriber sendNext:@(percentDone)];
		}];

		return [RACDisposable disposableWithBlock:^{
			[self cancel];
		}];
	}];
}

- (RACSignal *)rac_getData {
	return [RACSignal createSignal:^(id<RACSubscriber> subscriber) {
		[self getDataInBackgroundWithBlock:PFRACObjectCallback(subscriber) progressBlock:^(int percentDone) {
			[subscriber sendNext:@(percentDone)];
		}];

		return [RACDisposable disposableWithBlock:^{
			[self cancel];
		}];
	}];
}

- (RACSignal *)rac_getDataStream {
	return [RACSignal createSignal:^(id<RACSubscriber> subscriber) {
		[self getDataStreamInBackgroundWithBlock:PFRACObjectCallback(subscriber) progressBlock:^(int percentDone) {
			[subscriber sendNext:@(percentDone)];
		}];

		return [RACDisposable disposableWithBlock:^{
			[self cancel];
		}];
	}];
}

@end
