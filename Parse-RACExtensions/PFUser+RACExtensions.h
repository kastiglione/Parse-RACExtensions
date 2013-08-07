//
//  PFUser+RACExtensions.h
//  Parse-RACExtensions
//
//  Created by Dave Lee on 2013-06-28.
//  Copyright (c) 2013 Dave Lee. All rights reserved.
//

#import <Parse/PFUser.h>

@class RACSignal;

@interface PFUser (RACExtensions)

/// Makes a request to log in a user with specified credentials.
///
/// This method will also cache the user locally so that calls to
/// userFromCurrentUser will use the latest logged in user.
///
/// @see +logInWithUsernameInBackground:password:
///
/// @param username The username of the user.
/// @param password The password of the user.
/// @return A signal that sends the successfully logged in PFUser.
+ (RACSignal *)rac_logInWithUsername:(NSString *)username password:(NSString *)password;

/// Send a password reset request for a specified email.
///
/// If a user account exists with that email, an email will be sent to that
/// address with instructions on how to reset their password.
///
/// @see +logInWithUsernameInBackground:password:
///
/// @param email Email of the account to send a reset password request.
/// @return A signal that completes on success.
+ (RACSignal *)rac_requestPasswordResetForEmail:(NSString *)email;

/// Signs up the user.
///
/// Make sure that password and username are set. This will also enforce that
/// the username isn't already taken.
///
/// @see +signUpInBackgroundWithBlock:
///
/// @return A signal that completes on successful sign-up.
- (RACSignal *)rac_signUp;

@end
