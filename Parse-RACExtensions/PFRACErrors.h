//
//  PFRACErrors.h
//  Parse-RACExtensions
//
//  Created by Dave Lee on 2013-07-05.
//  Copyright (c) 2013 Dave Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const PFRACErrorDomain;
extern const NSUInteger PFRACUnknownError;

NSError * PFRACDescribeGenericError(NSError *error, NSString *localizedDescription);
