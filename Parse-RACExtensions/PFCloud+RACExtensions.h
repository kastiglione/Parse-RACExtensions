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

+ (RACSignal *)rac_callFunction:(NSString *)function withParameters:(NSDictionary *)parameters;

@end
