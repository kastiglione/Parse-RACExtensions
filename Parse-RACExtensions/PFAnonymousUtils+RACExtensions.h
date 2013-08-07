//
//  PFAnonymousUtils+RACExtensions.h
//  Parse-RACExtensions
//
//  Created by Dave Lee on 2013-06-29.
//  Copyright (c) 2013 Dave Lee. All rights reserved.
//

#import <Parse/PFAnonymousUtils.h>

@class RACSignal;

@interface PFAnonymousUtils (RACExtensions)

/// Creates an anonymous user.
///
/// @see +logInWithBlock:
///
/// @return A signal that sends the anonymous PFUser on successful login.
+ (RACSignal *)rac_logIn;

@end
