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
		// With a cache policy of kPFCachePolicyCacheThenNetwork, the callback
		// is called twice, first with results from cache, second with fresh
		// results. When there are no cached results, the API returns an error,
		// with code kPFErrorCacheMiss. For these purposes, it's not an error
		// that should end subscription, so it is squelched.
		//
		// This may be true of the other methods within this cateogry.
		__block NSUInteger callbackNumber = 0;
		[self findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
			if (self.cachePolicy == kPFCachePolicyCacheThenNetwork && ++callbackNumber == 1) {
				if (error.code == kPFErrorCacheMiss && [error.domain isEqualToString:@"Parse"]) return;
			}

			PFRACObjectCallback(subscriber)(objects, error);
		}];

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
