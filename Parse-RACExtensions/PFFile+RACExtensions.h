//
//  PFFile+RACExtensions.h
//  Parse-RACExtensions
//
//  Created by Matt Hupman on 2014-02-05.
//  Copyright (c) 2014 Matt Hupman. All rights reserved.
//

#import <Parse/PFFile.h>

@class RACSignal;

@interface PFFileDownload : NSObject

@property (nonatomic) NSNumber *progress;
@property (nonatomic) NSData *data;
@property (nonatomic) NSInputStream *stream;

@end

@interface PFFile (RACExtensions)

/// Saves the file.
///
/// Disposing subscription will also cancel the save.
///
/// @see -saveInBackgroundWithBlock:progressBlock:
///
/// @return A signal that periodically sends percent progress. The signal will
/// send 100 percent before completing.
- (RACSignal *)rac_save;

/// Gets the data, either from cache if available, or, fetches its contents from
/// the Parse servers.
///
/// Disposing subscription will also cancel the fetch.
///
/// @see -getDataInBackgroundWithBlock:progressBlock:
///
/// @return A signal that sends a PFFileDownload instance that provides access
/// the progress of the download and the data when complete.
- (RACSignal *)rac_getData;

/// This method is like -rac_getData but avoids ever holding the entire contents
/// of the PFFile in memory at once. This can help apps with many large PFFiles
/// avoid memory warnings.
///
/// Disposing subscription will also cancel the fetch.
///
/// @see -getDataStreamInBackgroundWithBlock:progressBlock:
///
/// @return A signal that sends a PFFileDownload instance that provides access
/// the progress of the download and a stream of the file's contents.
- (RACSignal *)rac_getDataStream;

@end