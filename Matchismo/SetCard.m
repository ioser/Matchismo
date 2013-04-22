//
//  SetCard.m
//  Matchismo
//
//  Created by Richard E Millet on 4/16/13.
//  Copyright (c) 2013 Richard Millet. All rights reserved.
//

#import "SetCard.h"

@interface SetCard ()

@end

@implementation SetCard

+ (NSArray *)getColorArray {
	return @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor]];
}

+ (NSArray *)getFillTypeArray {
	return @[@0, @1, @2];
}

// @Override
+ (NSArray *)getRankSymbolList {
	return @[@"1", @"2", @"3"];
}

// @Override
+ (NSArray *)getSuitSymbolList {
	return @[@"☐", @"△", @"◯"];
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
