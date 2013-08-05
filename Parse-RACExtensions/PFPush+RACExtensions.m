//
//  PFPush+RACExtensions.m
//  Parse-RACExtensions
//
//  Created by Dave Lee on 2013-08-01.
//  Copyright (c) 2013 Dave Lee. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "PFPush+RACExtensions.h"
#import "PFRACCallbacks.h"

@implementation PFPush (RACExtensions)

+ (RACSignal *)rac_sendPushMessageToChannel:(NSString *)channel withMessage:(NSString *)message {
	return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		[self sendPushMessageToChannelInBackground:channel withMessage:message block:PFRACBooleanCallback(subscriber)];
		return nil;
	}];
}

+ (RACSignal *)rac_sendPushMessageToQuery:(PFQuery *)query withMessage:(NSString *)message {
	return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		[self sendPushMessageToQueryInBackground:query withMessage:message block:PFRACBooleanCallback(subscriber)];
		return nil;
	}];
}

+ (RACSignal *)rac_sendPushDataToChannel:(NSString *)channel withData:(NSDictionary *)data {
	return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		[self sendPushDataToChannelInBackground:channel withData:data block:PFRACBooleanCallback(subscriber)];
		return nil;
	}];
}

+ (RACSignal *)rac_sendPushDataToQuery:(PFQuery *)query withData:(NSDictionary *)data {
	return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		[self sendPushDataToQueryInBackground:query withData:data block:PFRACBooleanCallback(subscriber)];
		return nil;
	}];
}

+ (RACSignal *)rac_getSubscribedChannels {
	return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		[self getSubscribedChannelsInBackgroundWithBlock:PFRACObjectCallback(subscriber)];
		return nil;
	}];
}

+ (RACSignal *)rac_subscribeToChannel:(NSString *)channel {
	return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		[self subscribeToChannelInBackground:channel block:PFRACBooleanCallback(subscriber)];
		return nil;
	}];
}

+ (RACSignal *)rac_unsubscribeFromChannel:(NSString *)channel {
	return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		[self unsubscribeFromChannelInBackground:channel block:PFRACBooleanCallback(subscriber)];
		return nil;
	}];
}

- (RACSignal *)rac_sendPush {
	return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		[self sendPushInBackgroundWithBlock:PFRACBooleanCallback(subscriber)];
		return nil;
	}];
}

@end
