//
//  PFGeoPoint+RACExtensions.m
//  Parse-RACExtensions
//
//  Created by Dave Lee on 2013-06-28.
//  Copyright (c) 2013 Dave Lee. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "PFGeoPoint+RACExtensions.h"

@implementation PFGeoPoint (RACExtensions)

+ (RACSignal *)rac_geoPointForCurrentLocation {
	return [RACSignal createSignal:^RACDisposable * (id<RACSubscriber> subscriber) {
		[self geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
			if (error == nil) {
				[subscriber sendNext:geoPoint];
				[subscriber sendCompleted];
			} else {
				[subscriber sendError:error];
			}
		}];

		return nil;
	}];
}

@end
