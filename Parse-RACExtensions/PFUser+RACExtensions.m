//
//  PFUser+RACExtensions.m
//  Parse-RACExtensions
//
//  Created by Dave Lee on 2013-06-28.
//  Copyright (c) 2013 Dave Lee. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "PFUser+RACExtensions.h"
#import "PFRACCallbacks.h"
#import "PFRACErrors.h"

@implementation PFUser (RACExtensions)

+ (RACSignal *)rac_logInWithUsername:(NSString *)username password:(NSString *)password {
	return [[[RACSignal
		createSignal:^RACDisposable * (id<RACSubscriber> subscriber) {
			[self logInWithUsernameInBackground:username password:password block:PFRACObjectCallback(subscriber)];
			return nil;
		}]
		pfrac_useDefaultErrorDescription:NSLocalizedString(@"log in failed", nil)]
		setNameWithFormat:@"+rac_logInWithUsername: %@ password: %@", username, password]; // Debug builds only
}

+ (RACSignal *)rac_requestPasswordResetForEmail:(NSString *)email {
	return [[[RACSignal
		createSignal:^RACDisposable * (id<RACSubscriber> subscriber) {
			[self requestPasswordResetForEmailInBackground:email block:PFRACBooleanCallback(subscriber)];
			return nil;
		}]
		pfrac_useDefaultErrorDescription:NSLocalizedString(@"request password reset failed", nil)]
		setNameWithFormat:@"+rac_requestPasswordResetForEmail: %@", email];
}

- (RACSignal *)rac_signUp {
	return [[[RACSignal
		createSignal:^RACDisposable * (id<RACSubscriber> subscriber) {
			[self signUpInBackgroundWithBlock:PFRACBooleanCallback(subscriber)];
			return nil;
		}]
		pfrac_useDefaultErrorDescription:NSLocalizedString(@"sign up failed", nil)]
		setNameWithFormat:@"%@ -rac_signUp", self];
}

@end
