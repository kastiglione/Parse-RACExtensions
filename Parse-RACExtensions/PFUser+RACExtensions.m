//
//  PFUser+RACExtensions.m
//  Parse-RACExtensions
//
//  Created by Dave Lee on 2013-06-28.
//  Copyright (c) 2013 Dave Lee. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "PFUser+RACExtensions.h"

@implementation PFUser (RACExtensions)

+ (RACSignal *)rac_logInWithUsername:(NSString *)username password:(NSString *)password {
	return [RACSignal createSignal:^RACDisposable * (id<RACSubscriber> subscriber) {
		[self logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
			if (error == nil) {
				[subscriber sendNext:user];
				[subscriber sendCompleted];
			} else {
				[subscriber sendError:error];
			}
		}];

		return nil;
	}];
}

+ (RACSignal *)rac_requestPasswordResetForEmail:(NSString *)email {
	return [RACSignal createSignal:^RACDisposable * (id<RACSubscriber> subscriber) {
		[self requestPasswordResetForEmailInBackground:email block:^(BOOL succeeded, NSError *error) {
			if (error == nil) {
				[subscriber sendNext:@(succeeded)];
				[subscriber sendCompleted];
			} else {
				[subscriber sendError:error];
			}
		}];

		return nil;
	}];
}

- (RACSignal *)rac_signUp {
	return [RACSignal createSignal:^RACDisposable * (id<RACSubscriber> subscriber) {
		[self signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
			if (error == nil) {
				[subscriber sendNext:@(succeeded)];
				[subscriber sendCompleted];
			} else {
				[subscriber sendError:error];
			}
		}];

		return nil;
	}];
}

@end
