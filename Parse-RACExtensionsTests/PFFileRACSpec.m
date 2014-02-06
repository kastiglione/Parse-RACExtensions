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

__block PFFile* file;

static NSString *kContents = @"Hello world!";

beforeEach(^{
	file = [PFFile fileWithName:@"hello.txt" data:[kContents dataUsingEncoding:NSUTF8StringEncoding]];
});

describe(@"uploading", ^{
	it(@"should upload", ^AsyncBlock {
		[[file rac_save] subscribeCompleted:^{
			expect(file.url).notTo.beNil();
			expect(file.isDirty).to.beFalsy();
			done();
		}];
	});
});

SpecEnd