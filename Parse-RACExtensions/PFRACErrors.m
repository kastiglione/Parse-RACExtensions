//
//  PFRACErrors.m
//  Parse-RACExtensions
//
//  Created by Dave Lee on 2013-07-05.
//  Copyright (c) 2013 Dave Lee. All rights reserved.
//

#import "PFRACErrors.h"
#import <ReactiveCocoa/RACSignal+Operations.h>

NSString * const PFRACErrorDomain = @"PFRACErrorDomain";
const NSUInteger PFRACUnknownError = 0;

@implementation RACSignal (PFRACErrorHandling)

static NSError * PFRACDescribeGenericError(NSError *error, NSString *localizedDescription) {
	if ([error.domain isEqualToString:PFRACErrorDomain] && error.userInfo[NSLocalizedDescriptionKey] == nil) {
		NSMutableDictionary *userInfo = [(error.userInfo ?: @{}) mutableCopy];
		userInfo[NSLocalizedDescriptionKey] = localizedDescription;
		return [NSError errorWithDomain:error.domain code:error.code userInfo:userInfo];
	}

	return error;
}

- (RACSignal *)pfrac_useDefaultErrorDescription:(NSString *)localizedDescription {
	return [self catch:^(NSError *error) {
		return [RACSignal error:PFRACDescribeGenericError(error, localizedDescription)];
	}];
}

@end
