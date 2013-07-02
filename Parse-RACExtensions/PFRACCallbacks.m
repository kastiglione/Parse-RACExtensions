//
//  PFRACCallbacks.m
//  Parse-RACExtensions
//
//  Created by Dave Lee on 2013-07-02.
//  Copyright (c) 2013 Dave Lee. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "PFRACCallbacks.h"

/*
 * Parse errors include only a generic "error" key. This function ensures that
 * generic error gets assigned under NSLocalizedFailureReasonErrorKey.
 */
static NSError *PFRACNormalizeError(NSError *error) {
	if (error.userInfo[@"error"] == nil) return error;

	NSMutableDictionary *userInfo = [error.userInfo mutableCopy];
	userInfo[NSLocalizedFailureReasonErrorKey] = userInfo[@"error"];
	return [NSError errorWithDomain:error.domain code:error.code userInfo:userInfo];
}

PFBooleanResultBlock PFRACBooleanCallback(id<RACSubscriber> subscriber) {
	return ^(BOOL succeeded, NSError *error) {
		if (error == nil) {
			[subscriber sendNext:@(succeeded)];
			[subscriber sendCompleted];
		} else {
			[subscriber sendError:PFRACNormalizeError(error)];
		}
	};
}

PFIdResultBlock PFRACObjectCallback(id<RACSubscriber> subscriber) {
	return ^(id result, NSError *error) {
		if (error == nil) {
			[subscriber sendNext:result];
			[subscriber sendCompleted];
		} else {
			[subscriber sendError:PFRACNormalizeError(error)];
		}
	};
}

PFIntegerResultBlock PFRACIntegerCallback(id<RACSubscriber> subscriber) {
	return ^(int number, NSError *error) {
		if (error == nil) {
			[subscriber sendNext:@(number)];
			[subscriber sendCompleted];
		} else {
			[subscriber sendError:PFRACNormalizeError(error)];
		}
	};
}
