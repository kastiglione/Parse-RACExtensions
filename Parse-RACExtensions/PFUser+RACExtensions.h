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

+ (RACSignal *)rac_logInWithUsername:(NSString *)username password:(NSString *)password;
+ (RACSignal *)rac_requestPasswordResetForEmail:(NSString *)email;

- (RACSignal *)rac_signUp;

@end
