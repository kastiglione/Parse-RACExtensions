//
//  PFGeoPoint+RACExtensions.h
//  Parse-RACExtensions
//
//  Created by Dave Lee on 2013-06-28.
//  Copyright (c) 2013 Dave Lee. All rights reserved.
//

#import <Parse/PFGeoPoint.h>

@class RACSignal;

@interface PFGeoPoint (RACExtensions)

+ (RACSignal *)rac_geoPointForCurrentLocation;

@end
