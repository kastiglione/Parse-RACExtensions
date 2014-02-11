//
//  PFFileRACSpec.m
//  Parse-RACExtensions
//
//  Created by Matt Hupman on 2/5/14.
//  Copyright (c) 2014 Dave Lee. All rights reserved.
//

#import "PFFile+RACExtensions.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <Parse/Parse.h>

#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"

SpecBegin(PFFileRACSpec)

beforeAll(^{
	[Parse setApplicationId:@(getenv("ParseApplicationId")) clientKey:@(getenv("ParseClientKey"))];
});

__block PFObject* profile;
__block PFFile* file;

static NSString *kContents = @"Hello world!";

describe(@"uploading", ^{
	
	beforeEach(^{
		file = [PFFile fileWithName:@"hello.txt" data:[kContents dataUsingEncoding:NSUTF8StringEncoding]];
	});
	
	it(@"should upload", ^AsyncBlock {
		[[file rac_save] subscribeCompleted:^{
			expect(file.url).notTo.beNil();
			expect(file.isDirty).to.beFalsy();
			done();
		}];
	});
	
	it(@"should upload", ^AsyncBlock {
		__block NSNumber *progress;
		
		[[file rac_save] subscribeNext:^(NSNumber *p) {
			progress = p;
		} completed:^{
			expect(progress).to.equal(@100);
			done();
		}];
	});
});

describe(@"downloading", ^{
	
	beforeEach(^{
		PFQuery *profileQuery = [PFQuery queryWithClassName:@"Profile"];
		profile = [profileQuery getFirstObject];
		expect(profile).toNot.beNil();
		
		file = (PFFile *)[profile objectForKey:@"signature"];
		expect(file).toNot.beNil();
		
		// Ensure that the PFFile isn't already cached on disk.
		expect(file.isDataAvailable).to.beFalsy();
	});
	
	afterEach(^{
		// Required to ensure that we don't get this PFObject again.  It's file will already be cached
		// by the Parse SDK, so subsequent requests would be served synchronously off disk.
		[profile delete];
	});
	
	it(@"should provide a download proxy object", ^AsyncBlock {
		[[file rac_getData] subscribeNext:^(PFFileDownload *pfd) {
			expect(pfd).toNot.beNil();
			done();
		}];
	});
	
	it(@"should provide a download object with progress that reaches 100 when requesting data", ^AsyncBlock {
		
		__block NSNumber *progress;
		
		[[[file rac_getData] flattenMap:^RACStream *(PFFileDownload *pfdownload) {
			return RACObserve(pfdownload, progress);
		}] subscribeNext:^(NSNumber *p) {
			progress = p;
		} completed:^{
			expect(progress).to.equal(@100);
			done();
		}];
	});
	
	it(@"should provide a download object that provides data when requesting data", ^AsyncBlock {
		
		__block NSData *data;
		
		[[[file rac_getData] flattenMap:^RACStream *(PFFileDownload *pfdownload) {
			return RACObserve(pfdownload, data);
		}] subscribeNext:^(NSData *d) {
			data = d;
		} completed:^{
			expect(data).to.notTo.beNil();
			expect(data).to.beKindOf([NSData class]);
			done();
		}];
	});
	
	it(@"should provide a download object with progress that reaches 100 when requesting a stream", ^AsyncBlock {
		
		__block NSNumber *progress;
		
		[[[file rac_getDataStream] flattenMap:^RACStream *(PFFileDownload *pfdownload) {
			return RACObserve(pfdownload, progress);
		}] subscribeNext:^(NSNumber *p) {
			progress = p;
		} completed:^{
			expect(progress).to.equal(@100);
			done();
		}];
	});
	
	it(@"should provide a download object that provides a data stream when requesting a stream", ^AsyncBlock {
		
		__block NSInputStream *stream;
		
		[[[file rac_getDataStream] flattenMap:^RACStream *(PFFileDownload *pfdownload) {
			return RACObserve(pfdownload, stream);
		}] subscribeNext:^(NSInputStream *s) {
			stream = s;
		} completed:^{
			expect(stream).to.notTo.beNil();
			expect(stream).to.beKindOf([NSInputStream class]);
			done();
		}];
	});
});

SpecEnd