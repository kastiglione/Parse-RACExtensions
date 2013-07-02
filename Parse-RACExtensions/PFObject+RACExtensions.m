//
//  PFObject+RACExtensions.m
//  Parse-RACExtensions
//
//  Created by Dave Lee on 2013-06-28.
//  Copyright (c) 2013 Dave Lee. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "PFObject+RACExtensions.h"
#import "PFRACCallbackSubscriber.h"

@implementation PFObject (RACExtensions)

+ (RACSignal *)rac_saveAll:(NSArray *)objects {
	return [RACSignal createSignal:^RACDisposable * (id<RACSubscriber> subscriber) {
		[self saveAllInBackground:objects block:PFRACBooleanCallback(subscriber)];

		return nil;
	}];
}

+ (RACSignal *)rac_fetchAll:(NSArray *)objects {
	return [RACSignal createSignal:^RACDisposable * (id<RACSubscriber> subscriber) {
		[self fetchAllInBackground:objects block:PFRACObjectCallback(subscriber)];

		return nil;
	}];
}

+ (RACSignal *)rac_fetchAllIfNeeded:(NSArray *)objects {
	return [RACSignal createSignal:^RACDisposable * (id<RACSubscriber> subscriber) {
		[self fetchAllIfNeededInBackground:objects block:PFRACObjectCallback(subscriber)];

		return nil;
	}];
}

- (RACSignal *)rac_save {
	return [RACSignal createSignal:^RACDisposable * (id<RACSubscriber> subscriber) {
		[self saveInBackgroundWithBlock:PFRACBooleanCallback(subscriber)];

		return nil;
	}];
}

- (RACSignal *)rac_saveEventually {
	return [RACSignal createSignal:^RACDisposable * (id<RACSubscriber> subscriber) {
		[self saveEventually:PFRACBooleanCallback(subscriber)];

		return nil;
	}];
}

- (RACSignal *)rac_refresh {
	return [RACSignal createSignal:^RACDisposable * (id<RACSubscriber> subscriber) {
		[self refreshInBackgroundWithBlock:PFRACObjectCallback(subscriber)];

		return nil;
	}];
}

- (RACSignal *)rac_fetch {
	return [RACSignal createSignal:^RACDisposable * (id<RACSubscriber> subscriber) {
		[self fetchInBackgroundWithBlock:PFRACObjectCallback(subscriber)];

		return nil;
	}];
}

- (RACSignal *)rac_fetchIfNeeded {
	return [RACSignal createSignal:^RACDisposable * (id<RACSubscriber> subscriber) {
		[self fetchIfNeededInBackgroundWithBlock:PFRACObjectCallback(subscriber)];

		return nil;
	}];
}

- (RACSignal *)rac_delete {
	return [RACSignal createSignal:^RACDisposable * (id<RACSubscriber> subscriber) {
		[self deleteInBackgroundWithBlock:PFRACBooleanCallback(subscriber)];

		return nil;
	}];
}

@end
