//
//  PFCloud+RACExtensions.h
//  Parse-RACExtensions
//
//  Created by Dave Lee on 2013-08-05.
//  Copyright (c) 2013 Dave Lee. All rights reserved.
//

#import <Parse/PFCloud.h>

@class RACSignal;

@interface PFCloud (RACExtensions)

/// Calls the given cloud function with the parameters provided.
///
/// @see +callFunctionInBackground:withParameters:block:
///
/// @param function The function name to call.
/// @param parameters The parameters to send to the function.
/// @return A signal that sends the function's return value.
+ (RACSignal *)rac_callFunction:(NSString *)function withParameters:(NSDictionary *)parameters;

@end
