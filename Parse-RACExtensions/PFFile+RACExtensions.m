//
//  PFFile+RACExtensions.m
//  Parse-RACExtensions
//
//  Created by Matt Hupman on 2014-02-05.
//  Copyright (c) 2014 Matt Hupman. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "PFFile+RACExtensions.h"
#import "PFRACCallbacks.h"

@implementation PFFileDownload
@end

@implementation PFFile (RACExtensions)

- (RACSignal *)rac_save {
	return [[RACSignal createSignal:^(id<RACSubscriber> subscriber) {
		[self saveInBackgroundWithBlock:PFRACBooleanCallback(subscriber) progressBlock:^(int percentDone) {
			[subscriber sendNext:@(percentDone)];
		}];
		
		return [RACDisposable disposableWithBlock:^{
			[self cancel];
		}];
	}]
			setNameWithFormat:@"%@ -rac_save", self];
}

- (RACSignal *)rac_getData {
	
	return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		
		PFFileDownload *download = [[PFFileDownload alloc] init];
		
		[self getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
			if (error == nil) {
				// Since this data block is documented to be called after
				// progress reaches 100%, this is the end of the signal.
				download.data = data;
				[subscriber sendCompleted];
			} else {
				[subscriber sendError:error];
			}
		} progressBlock:^(int percentDone) {
			download.progress = @(percentDone);
		}];
		
		[subscriber sendNext:download];
		
		return [RACDisposable disposableWithBlock:^{
			[self cancel];
		}];
	}]
			setNameWithFormat:@"%@ -rac_getData", self];
}

- (RACSignal *)rac_getDataStream {
	
	return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		
		PFFileDownload *download = [[PFFileDownload alloc] init];
		
		[self getDataStreamInBackgroundWithBlock:^(NSInputStream *stream, NSError *error) {
			if (error == nil) {
				// Since this data block is documented to be called after
				// progress reaches 100%, this is the end of the signal.
				download.stream = stream;
				[subscriber sendCompleted];
			} else {
				[subscriber sendError:error];
			}
		} progressBlock:^(int percentDone) {
			download.progress = @(percentDone);
		}];
		
		[subscriber sendNext:download];
		
		return [RACDisposable disposableWithBlock:^{
			[self cancel];
		}];
	}]
			setNameWithFormat:@"%@ -rac_getDataStream", self];
}

@end