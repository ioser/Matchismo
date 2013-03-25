//
//  PlayingCard.m
//  Matchismo
//
//  Created by Richard E Millet on 3/24/13.
//  Copyright (c) 2013 Richard Millet. All rights reserved.
//

#import "PlayingCard.h"

NSArray *rankSymbols = nil;
NSArray *suitSymbols = nil;

@implementation PlayingCard

- (NSString *)getRankSymbol {
	if (rankSymbols == nil) {
		rankSymbols = @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8",
				  @"9", @"10", @"J", @"Q", @"K",];
	}
	return rankSymbols[self.rank];
}

- (NSArray *)getValidSuitSymbols {
	if (suitSymbols == nil) {
		suitSymbols = @[@"♥", @"♦", @"♠", @"♣"];
	}
	return suitSymbols;
}

// Override "contents" getter from Card class
- (NSString *)contents {
	NSString *result = [NSString stringWithFormat:@"%@%@", [self getRankSymbol], self.suit];
	return result;
}

- (NSString *)suit {
	NSString *result = _suit;
	
	if (result == nil) {
		result = @"?";
	}
	
	return result;
}

@end
