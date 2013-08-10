//
//  PFRACErrors.h
//  Parse-RACExtensions
//
//  Created by Dave Lee on 2013-07-05.
//  Copyright (c) 2013 Dave Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/RACSignal.h>

extern NSString * const PFRACErrorDomain;
extern const NSUInteger PFRACUnknownError;

@interface RACSignal (PFRACErrorHandling)

- (RACSignal *)pfrac_useDefaultErrorDescription:(NSString *)localizedDescription;

@end
