//
//  PFObject+RACExtensions.h
//  Parse-RACExtensions
//
//  Created by Dave Lee on 2013-06-28.
//  Copyright (c) 2013 Dave Lee. All rights reserved.
//

#import <Parse/PFObject.h>

@class RACSignal;

@interface PFObject (RACExtensions)

+ (RACSignal *)rac_saveAll:(NSArray *)objects;
+ (RACSignal *)rac_fetchAll:(NSArray *)objects;
+ (RACSignal *)rac_fetchAllIfNeeded:(NSArray *)objects;

- (RACSignal *)rac_save;
- (RACSignal *)rac_saveEventually;
- (RACSignal *)rac_refresh;
- (RACSignal *)rac_fetch;
- (RACSignal *)rac_fetchIfNeeded;
- (RACSignal *)rac_delete;

@end
