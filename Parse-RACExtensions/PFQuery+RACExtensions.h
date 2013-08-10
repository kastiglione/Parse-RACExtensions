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

/// Gets a PFObject with the given id.
///
/// Disposing subscription will also cancel the query.
///
/// @warning This mutates the PFQuery.
///
/// @see -getObjectInBackgroundWithId:block:
///
/// @return A signal that sends the identified PFObject.
- (RACSignal *)rac_getObjectWithId:(NSString *)objectId;

/// Finds objects based on the constructed query.
///
/// Disposing subscription will also cancel the query.
///
/// @see -findObjectsInBackgroundWithBlock:
///
/// @return A signal that sends the NSArray of matching PFObjects.
- (RACSignal *)rac_findObjects;

/// Gets an object based on the constructed query.
///
/// Disposing subscription will also cancel the query.
///
/// @warning This mutates the PFQuery.
///
/// @see -getFirstObjectInBackgroundWithBlock:
///
/// @return A signal that sends the first matching PFObject.
- (RACSignal *)rac_getFirstObject;

/// Counts objects based on the constructed query.
///
/// Disposing subscription will also cancel the query.
///
/// @see -countObjectsInBackgroundWithBlock:
///
/// @return A signal that sends the integer count of matching PFObjects
- (RACSignal *)rac_countObjects;

@end
