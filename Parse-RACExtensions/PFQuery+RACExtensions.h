//
//  PFQuery+RACExtensions.h
//  Parse-RACExtensions
//
//  Created by Dave Lee on 2013-06-28.
//  Copyright (c) 2013 Dave Lee. All rights reserved.
//

#import <Parse/PFQuery.h>

@class RACSignal;

@interface PFQuery (RACExtensions)

- (RACSignal *)rac_getObjectWithId:(NSString *)objectId;
- (RACSignal *)rac_findObjects;
- (RACSignal *)rac_getFirstObject;
- (RACSignal *)rac_countObjects;

@end
