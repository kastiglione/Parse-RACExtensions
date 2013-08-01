//
//  PFFile+RACExtensions.h
//  Parse-RACExtensions
//
//  Created by Dave Lee on 2013-08-01.
//  Copyright (c) 2013 Dave Lee. All rights reserved.
//

#import <Parse/PFFile.h>

@class RACSignal;

@interface PFFile (RACExtensions)

- (RACSignal *)rac_save;
- (RACSignal *)rac_getData;
- (RACSignal *)rac_getDataStream;

@end
