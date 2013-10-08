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

it(@"should save", ^{
	PFObject *object = [PFObject objectWithClassName:@"TestObject"];
	expect(object).notTo.beNil();

	__block BOOL saved = NO;
	[[object rac_save] subscribeCompleted:^{
		saved = YES;
	}];

	expect(saved).will.beTruthy();
	expect(object.objectId).willNot.beNil();
	expect(object.createdAt.timeIntervalSinceReferenceDate).will.beCloseToWithin(NSDate.date.timeIntervalSinceReferenceDate, 300);
	expect(object.updatedAt).will.equal(object.createdAt);
});

it(@"should delete", ^{
	PFObject *object = [PFObject objectWithClassName:@"TestObject"];
	expect(object).notTo.beNil();

	BOOL saved = [object save];

	expect(saved).to.beTruthy();
	expect(object.objectId).notTo.beNil();

	__block BOOL deleted = NO;
	[[object rac_delete] subscribeCompleted:^{
		deleted = YES;

		PFQuery *query = [PFQuery queryWithClassName:@"TestObject"];
		[query whereKey:@"objectId" equalTo:object.objectId];
		expect([query countObjects]).to.equal(0);
	}];

	expect(deleted).will.beTruthy();
	expect(object.objectId).willNot.beNil();
});

SpecEnd
