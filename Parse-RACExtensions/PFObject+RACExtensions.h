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

/*! @name Batch Operations */

/// Saves a collection of objects all at once.
///
/// @see +saveAllInBackground:block:
///
/// @param objects The list of objects to save.
/// @return A signal that completes on successful save.
+ (RACSignal *)rac_saveAll:(NSArray *)objects;

/// Fetches all of the current data from the server for all of the PFObjects.
///
/// @see +fetchAllInBackground:block:
///
/// @param objects The list of objects to fetch.
/// @return A signal that sends the fetched objects.
+ (RACSignal *)rac_fetchAll:(NSArray *)objects;

/// Fetches the current data from the server for the PFObjects whose
/// isDataAvailable is false.
///
/// @see +fetchAllIfNeededInBackground:block:
///
/// @param objects The list of objects to fetch.
/// @return A signal that sends the fetched objects.
+ (RACSignal *)rac_fetchAllIfNeeded:(NSArray *)objects;

/// Deletes a collection of objects all at once.
///
/// @see +deleteAllInBackground:block:
///
/// @param objects The array of objects to delete.
/// @return A signal that completes on successful deletion.
+ (RACSignal *)rac_deleteAll:(NSArray *)objects;

/*! Object Data Operations */

/// Saves the PFObject.
///
/// @see -saveInBackgroundWithBlock:
///
/// @return A signal that completes on successful save.
- (RACSignal *)rac_save;

/// Saves this object to the server at some unspecified time in the future, even
/// if Parse is currently inaccessible. Use this when you may not have a solid
/// network connection, and don't need to know when the save completes. If there
/// is some problem with the object such that it can't be saved, it will be
/// silently discarded. If the save completes successfully while the object is
/// still in memory, then callback will be called.
///
/// Objects saved with this method will be stored locally in an on-disk cache
/// until they can be delivered to Parse. They will be sent immediately if
/// possible. Otherwise, they will be sent the next time a network connection is
/// available. Objects saved this way will persist even after the app is closed,
/// in which case they will be sent the next time the app is opened.  If more
/// than 10MB of data is waiting to be sent, subsequent calls to saveEventually
/// will cause old saves to be silently discarded until the connection can be
/// re-established, and the queued objects can be saved.
///
/// @see -saveEventually:
- (RACSignal *)rac_saveEventually;

/// Fetches the PFObject.
///
/// @see -fetchInBackgroundWithBlock:
///
/// @return A signal that sends the fetched object.
- (RACSignal *)rac_fetch;

/// Fetches the PFObject if isDataAvailable is false.
///
/// @see -fetchIfNeededInBackgroundWithBlock:
///
/// @return A signal that sends the fetched object.
- (RACSignal *)rac_fetchIfNeeded;

/// Deletes the PFObject.
///
/// @see -deleteInBackgroundWithBlock:
///
/// @return A signal that completes on successful save.
- (RACSignal *)rac_delete;

@end

@interface PFObject (DeprecatedRACExtensions)

- (RACSignal *)rac_refresh __attribute__((deprecated("Underlying `-refreshInBackgroundWithBlock:` is deprecated")));

@end
