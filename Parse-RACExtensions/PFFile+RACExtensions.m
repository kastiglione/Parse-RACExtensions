//
//  PFFile+RACExtensions.m
//  Parse-RACExtensions
//
//  Created by Dave Lee on 2013-08-01.
//  Copyright (c) 2013 Dave Lee. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "PFFile+RACExtensions.h"
#import "PFRACCallbacks.h"

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
	return [[RACSignal createSignal:^(id<RACSubscriber> subscriber) {
		RACSubject *progressSubject = [RACReplaySubject replaySubjectWithCapacity:1];
		[subscriber sendNext:progressSubject];

		[self getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
			if (error == nil) {
				[subscriber sendNext:[RACSignal return:data]];

				// Since this data block is documented to be called after
				// progress reaches 100%, this is the end of the signal.
				[subscriber sendCompleted];
			} else {
				[subscriber sendError:error];
			}
		} progressBlock:^(int percentDone) {
			[progressSubject sendNext:@(percentDone)];
		}];

		return [RACDisposable disposableWithBlock:^{
			[self cancel];
		}];
	}]
	setNameWithFormat:@"%@ -rac_getData", self];
}

- (RACSignal *)rac_getDataStream {
	return [[RACSignal createSignal:^(id<RACSubscriber> subscriber) {
		RACSubject *progressSubject = [RACReplaySubject replaySubjectWithCapacity:1];
		[subscriber sendNext:progressSubject];

		[self getDataStreamInBackgroundWithBlock:^(NSInputStream *stream, NSError *error) {
			if (error == nil) {
				[subscriber sendNext:[RACSignal return:stream]];

				// Confession: I haven't confirmed this, but the signal is not
				// completed here because I presume this data stream block is
				// called prior to the progress reaching 100%.
			} else {
				[subscriber sendError:error];
			}
		} progressBlock:^(int percentDone) {
			[progressSubject sendNext:@(percentDone)];

			// This is presumably the last event. See above comments.
			if (percentDone == 100) [subscriber sendCompleted];
		}];

		return [RACDisposable disposableWithBlock:^{
			[self cancel];
		}];
	}]
	setNameWithFormat:@"%@ -rac_getDataStream", self];
}

@end
