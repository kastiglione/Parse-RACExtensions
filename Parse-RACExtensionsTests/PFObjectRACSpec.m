//
//  PFObjectRACSpec.m
//  Parse-RACExtensions
//
//  Created by Dave Lee on 2013-10-08.
//  Copyright (c) 2013 Dave Lee. All rights reserved.
//

#import "PFObject+RACExtensions.h"

#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"

SpecBegin(PFObjectRACSpec)

it(@"should work", ^{
	PFObject *object = [PFObject objectWithClassName:@"TestRig"];
	expect(object).notTo.beNil();
	expect([object respondsToSelector:@selector(rac_save)]).to.beTruthy();
});

SpecEnd
