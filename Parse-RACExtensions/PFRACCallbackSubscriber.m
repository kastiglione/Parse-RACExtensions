//
//  PFRACCallbackSubscriber.m
//  Parse-RACExtensions
//
//  Created by Dave Lee on 2013-07-02.
//  Copyright (c) 2013 Dave Lee. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "PFRACCallbackSubscriber.h"

PFBooleanResultBlock PFRACBooleanCallback(id<RACSubscriber> subscriber) {
	return ^(BOOL succeeded, NSError *error) {
		if (error == nil) {
			[subscriber sendNext:@(succeeded)];
			[subscriber sendCompleted];
		} else {
			[subscriber sendError:error];
		}
	}
}

PFObjectResultBlock PFRACObjectCallback(id<RACSubscriber> subscriber) {
	return ^(id result, NSError *error) {
		if (error == nil) {
			[subscriber sendNext:result];
			[subscriber sendCompleted];
		} else {
			[subscriber sendError:error];
		}
	}
}
