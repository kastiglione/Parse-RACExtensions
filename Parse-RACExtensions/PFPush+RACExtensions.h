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

/*! @name Sending Push Notifications */

/// Sends a push message to a channel.
///
/// @see +sendPushMessageToChannelInBackground:withMessage:block:
///
/// @param channel The channel to send to. The channel name must start with a
/// letter and contain only letters, numbers, dashes, and underscores.
/// @param message The message to send.
/// @return A signal that completes on successfully message delivery.
+ (RACSignal *)rac_sendPushMessageToChannel:(NSString *)channel withMessage:(NSString *)message;

/// Sends a push message to a query.
///
/// @see +sendPushMessageToChannelInBackground:withMessage:block:
///
/// @param query The query to send to. The query must be a PFInstallation query
/// created with [PFInstallation query].
/// @param message The message to send.
/// @return A signal that completes on successfully message delivery.
+ (RACSignal *)rac_sendPushMessageToQuery:(PFQuery *)query withMessage:(NSString *)message;

/// Send a push message with arbitrary data to a channel.
///
/// See the guide for information about the dictionary structure.
///
/// @see +sendPushDataToChannelInBackground:withData:block:
///
/// @param channel The channel to send to. The channel name must start with a
/// letter and contain only letters, numbers, dashes, and underscores.
/// @param data The data to send.
/// @return A signal that completes on successfully message delivery.
+ (RACSignal *)rac_sendPushDataToChannel:(NSString *)channel withData:(NSDictionary *)data;

/// Send a push message with arbitrary data to a query.
///
/// See the guide for information about the dictionary structure.
///
/// @see +sendPushDataToChannelInBackground:withData:block:
///
/// @param query The query to send to. The query must be a PFInstallation query
/// created with [PFInstallation query].
/// @param data The data to send.
/// @return A signal that completes on successfully message delivery.
+ (RACSignal *)rac_sendPushDataToQuery:(PFQuery *)query withData:(NSDictionary *)data;

/// Send this push message.
///
/// @see -sendPushInBackgroundWithBlock:
///
/// @return A signal that completes on successful message delivery.
- (RACSignal *)rac_sendPush;

/*! @name Managing Channel Subscriptions */

/// Get all the channels that this device is subscribed to.
///
/// @see +getSubscribedChannelsInBackgroundWithBlock:
///
/// @return A signal that sends the NSSet of subscribed channel names.
+ (RACSignal *)rac_getSubscribedChannels;

/// Subscribes the device to a channel of push notifications.
///
/// @see +subscribeToChannelInBackground:block:
///
/// @param channel The channel to send to. The channel name must start with a
/// letter and contain only letters, numbers, dashes, and underscores.
/// @return A signal that completes on successful subscription.
+ (RACSignal *)rac_subscribeToChannel:(NSString *)channel;

/// Unsubscribes the device from a channel of push notifications.
///
/// @see +unsubscribeFromChannelInBackground:block:
///
/// @param channel The channel to send to. The channel name must start with a
/// letter and contain only letters, numbers, dashes, and underscores.
/// @return A signal that completes on successful unsubscription.
+ (RACSignal *)rac_unsubscribeFromChannel:(NSString *)channel;

@end
