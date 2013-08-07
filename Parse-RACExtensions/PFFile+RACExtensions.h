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

/// Saves the file.
///
/// @see -saveInBackgroundWithBlock:progressBlock:
///
/// @return A signal that "periodically" sends percent progress. The signal will
/// send 100 percent before completing.
- (RACSignal *)rac_save;

/// Gets the data, either from cache if available, or, fetches its contents from
/// the Parse servers.
///
/// @see -getDataInBackgroundWithBlock:progressBlock:
///
/// @return A signal of two signals. The first signal "periodically" sends the
/// progress of the data fetch as an integer percentage. The second signal sends
/// the NSData on successful completion.
- (RACSignal *)rac_getData;

/// This method is like -rac_getData but avoids ever holding the entire contents
/// of the PFFile in memory at once. This can help apps with many large PFFiles
/// avoid memory warnings.
///
/// @see -getDataStreamInBackgroundWithBlock:progressBlock:
///
/// @return A signal of two signals. The first signal "periodically" sends the
/// progress of the data fetch as an integer percentage. The second signal sends
/// the NSInputStream on successful completion.
- (RACSignal *)rac_getDataStream;

@end
