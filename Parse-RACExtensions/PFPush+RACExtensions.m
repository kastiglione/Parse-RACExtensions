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
	return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		[self sendPushMessageToChannelInBackground:channel withMessage:message block:PFRACBooleanCallback(subscriber)];
		return nil;
	}]
	setNameWithFormat:@"PFPush +rac_sendPushMessageToChannel: %@ withMessage: %@", channel, message];
}

+ (RACSignal *)rac_sendPushMessageToQuery:(PFQuery *)query withMessage:(NSString *)message {
	return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		[self sendPushMessageToQueryInBackground:query withMessage:message block:PFRACBooleanCallback(subscriber)];
		return nil;
	}]
	setNameWithFormat:@"PFPush +rac_sendPushMessageToQuery: %@ withMessage: %@", query, message];
}

+ (RACSignal *)rac_sendPushDataToChannel:(NSString *)channel withData:(NSDictionary *)data {
	return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		[self sendPushDataToChannelInBackground:channel withData:data block:PFRACBooleanCallback(subscriber)];
		return nil;
	}]
	setNameWithFormat:@"PFPush +rac_sendPushDataToChannel: %@ withData: %@", channel, data];
}

+ (RACSignal *)rac_sendPushDataToQuery:(PFQuery *)query withData:(NSDictionary *)data {
	return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		[self sendPushDataToQueryInBackground:query withData:data block:PFRACBooleanCallback(subscriber)];
		return nil;
	}]
	setNameWithFormat:@"PFPush +rac_sendPushDataToQuery: %@ withData: %@", query, data];
}

+ (RACSignal *)rac_getSubscribedChannels {
	return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		[self getSubscribedChannelsInBackgroundWithBlock:PFRACObjectCallback(subscriber)];
		return nil;
	}]
	setNameWithFormat:@"PFPush +rac_getSubscribedChannels"];
}

+ (RACSignal *)rac_subscribeToChannel:(NSString *)channel {
	return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		[self subscribeToChannelInBackground:channel block:PFRACBooleanCallback(subscriber)];
		return nil;
	}]
	setNameWithFormat:@"PFPush +rac_subscribeToChannel: %@", channel];
}

+ (RACSignal *)rac_unsubscribeFromChannel:(NSString *)channel {
	return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		[self unsubscribeFromChannelInBackground:channel block:PFRACBooleanCallback(subscriber)];
		return nil;
	}]
	setNameWithFormat:@"PFPush +rac_unsubscribeFromChannel: %@", channel];
}

- (RACSignal *)rac_sendPush {
	return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		[self sendPushInBackgroundWithBlock:PFRACBooleanCallback(subscriber)];
		return nil;
	}]
	setNameWithFormat:@"%@ -rac_sendPush", self];
}

@end
