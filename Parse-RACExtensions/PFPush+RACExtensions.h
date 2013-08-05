//
//  PFPush+RACExtensions.h
//  Parse-RACExtensions
//
//  Created by Dave Lee on 2013-08-01.
//  Copyright (c) 2013 Dave Lee. All rights reserved.
//

#import <Parse/PFPush.h>

@class PFQuery;
@class RACSignal;

@interface PFPush (RACExtensions)

+ (RACSignal *)rac_sendPushMessageToChannel:(NSString *)channel withMessage:(NSString *)message;
+ (RACSignal *)rac_sendPushMessageToQuery:(PFQuery *)query withMessage:(NSString *)message;
+ (RACSignal *)rac_sendPushDataToChannel:(NSString *)channel withData:(NSDictionary *)data;
+ (RACSignal *)rac_sendPushDataToQuery:(PFQuery *)query withData:(NSDictionary *)data;
+ (RACSignal *)rac_getSubscribedChannels;
+ (RACSignal *)rac_subscribeToChannel:(NSString *)channel;
+ (RACSignal *)rac_unsubscribeFromChannel:(NSString *)channel;

- (RACSignal *)rac_sendPush;


@end
