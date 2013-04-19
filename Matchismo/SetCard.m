//
//  SetCard.m
//  Matchismo
//
//  Created by Richard E Millet on 4/16/13.
//  Copyright (c) 2013 Richard Millet. All rights reserved.
//

#import "SetCard.h"

NSArray *colorArray;
NSArray *fillTypeArray;

@implementation SetCard

+ (NSArray *)getColorArray {
	if (colorArray == nil) {
		colorArray = @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor]];
	}
	return colorArray;
}

+ (NSArray *)getFillTypeArray {
	if (fillTypeArray == nil) {
		fillTypeArray = @[@0, @1, @2];
	}
	return fillTypeArray;
}

// @Override
+ (NSArray *)getRankSymbolList {
	if (rankSymbolList == nil) {
		rankSymbolList = @[@"1", @"2", @"3"];
	}
	return rankSymbolList;
}

// @Override
+ (NSArray *)getSuitSymbolList {
	if (suitSymbolList == nil) {
		suitSymbolList = @[@"☐", @"△", @"◯"];
	}
	return suitSymbolList;
}

// @Override
- (NSString *)getRankSymbol {
	NSString *result = @"";
	
	for (int i = 0; i < self.rank; i++) {
		result = [result stringByAppendingString: self.suit];
	}
	
	return result;
}

@end
