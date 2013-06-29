//
//  PFObject+RACExtensions.m
//  Parse-RACExtensions
//
//  Created by Dave Lee on 2013-06-28.
//  Copyright (c) 2013 Dave Lee. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "PFObject+RACExtensions.h"

@implementation PFObject (RACExtensions)

+ (RACSignal *)rac_saveAll:(NSArray *)objects {
	return [RACSignal createSignal:^RACDisposable * (id<RACSubscriber> subscriber) {
		[self saveAllInBackground:objects block:^(BOOL succeeded, NSError *error) {
			if (error == nil) {
				[subscriber sendNext:@(succeeded)];
				[subscriber sendCompleted];
			} else {
				[subscriber sendError:error];
			}
		}];

		return nil;
	}];
}

+ (RACSignal *)rac_fetchAll:(NSArray *)objects {
	return [RACSignal createSignal:^RACDisposable * (id<RACSubscriber> subscriber) {
		[self fetchAllInBackground:objects block:^(NSArray *objects, NSError *error) {
			if (error == nil) {
				[subscriber sendNext:objects];
				[subscriber sendCompleted];
			} else {
				[subscriber sendError:error];
			}
		}];

		return nil;
	}];
}

+ (RACSignal *)rac_fetchAllIfNeeded:(NSArray *)objects {
	return [RACSignal createSignal:^RACDisposable * (id<RACSubscriber> subscriber) {
		[self fetchAllIfNeededInBackground:objects block:^(NSArray *objects, NSError *error) {
			if (error == nil) {
				[subscriber sendNext:objects];
				[subscriber sendCompleted];
			} else {
				[subscriber sendError:error];
			}
		}];

		return nil;
	}];
}

- (RACSignal *)rac_save {
	return [RACSignal createSignal:^RACDisposable * (id<RACSubscriber> subscriber) {
		[self saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
			if (error == nil) {
				[subscriber sendNext:@(succeeded)];
				[subscriber sendCompleted];
			} else {
				[subscriber sendError:error];
			}
		}];

		return nil;
	}];
}

- (RACSignal *)rac_saveEventually {
	return [RACSignal createSignal:^RACDisposable * (id<RACSubscriber> subscriber) {
		[self saveEventually:^(BOOL succeeded, NSError *error) {
			if (error == nil) {
				[subscriber sendNext:@(succeeded)];
				[subscriber sendCompleted];
			} else {
				[subscriber sendError:error];
			}
		}];

		return nil;
	}];
}

- (RACSignal *)rac_refresh {
	return [RACSignal createSignal:^RACDisposable * (id<RACSubscriber> subscriber) {
		[self refreshInBackgroundWithBlock:^(PFObject *object, NSError *error) {
			if (error == nil) {
				[subscriber sendNext:object];
				[subscriber sendCompleted];
			} else {
				[subscriber sendError:error];
			}
		}];

		return nil;
	}];
}

- (RACSignal *)rac_fetch {
	return [RACSignal createSignal:^RACDisposable * (id<RACSubscriber> subscriber) {
		[self fetchInBackgroundWithBlock:^(PFObject *object, NSError *error) {
			if (error == nil) {
				[subscriber sendNext:object];
				[subscriber sendCompleted];
			} else {
				[subscriber sendError:error];
			}
		}];

		return nil;
	}];
}

- (RACSignal *)rac_fetchIfNeeded {
	return [RACSignal createSignal:^RACDisposable * (id<RACSubscriber> subscriber) {
		[self fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
			if (error == nil) {
				[subscriber sendNext:object];
				[subscriber sendCompleted];
			} else {
				[subscriber sendError:error];
			}
		}];

		return nil;
	}];
}

- (RACSignal *)rac_delete {
	return [RACSignal createSignal:^RACDisposable * (id<RACSubscriber> subscriber) {
		[self deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
			if (error == nil) {
				[subscriber sendNext:@(succeeded)];
				[subscriber sendCompleted];
			} else {
				[subscriber sendError:error];
			}
		}];

		return nil;
	}];
}

@end
