//
//  PFObjectRACSpec.m
//  Parse-RACExtensions
//
//  Created by Dave Lee on 2013-10-08.
//  Copyright (c) 2013 Dave Lee. All rights reserved.
//

#import "PFObject+RACExtensions.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <Parse/Parse.h>

#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"

SpecBegin(PFObjectRACSpec)

beforeAll(^{
	[Parse setApplicationId:@(getenv("ParseApplicationId")) clientKey:@(getenv("ParseClientKey"))];
});

afterAll(^{
	NSArray *testObjects = [[PFQuery queryWithClassName:@"TestObject"] findObjects];
	[PFObject deleteAll:testObjects];
});

it(@"should save", ^AsyncBlock {
	PFObject *object = [PFObject objectWithClassName:@"TestObject"];
	expect(object).notTo.beNil();

	[[object rac_save] subscribeCompleted:^{
		expect(object.objectId).notTo.beNil();
		expect(object.createdAt.timeIntervalSinceReferenceDate).to.beCloseToWithin(NSDate.date.timeIntervalSinceReferenceDate, 100);
		expect(object.updatedAt).to.equal(object.createdAt);

		done();
	}];
});

it(@"should delete", ^AsyncBlock {
	PFObject *object = [PFObject objectWithClassName:@"TestObject"];
	expect(object).notTo.beNil();

	BOOL saved = [object save];

	expect(saved).to.beTruthy();
	expect(object.objectId).notTo.beNil();

	[[object rac_delete] subscribeCompleted:^{
		expect(object.objectId).notTo.beNil();

		PFQuery *query = [PFQuery queryWithClassName:@"TestObject"];
		[query whereKey:@"objectId" equalTo:object.objectId];
		expect([query countObjects]).to.equal(0);

		done();
	}];
});

SpecEnd
