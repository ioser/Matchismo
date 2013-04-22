//
//  SuitAndRankCard.m
//  Matchismo
//
//  Created by Richard E Millet on 4/16/13.
//  Copyright (c) 2013 Richard Millet. All rights reserved.
//

#import "SuitAndRankCard.h"

/*
 * An abstract class
 */
@implementation SuitAndRankCard

NSArray *rankSymbolList;
NSArray *suitSymbolList;

@synthesize suit = _suit;

+ (NSArray *)getRankSymbolList {
	return rankSymbolList;
}

+ (NSArray *)getSuitSymbolList {
	return suitSymbolList;
}


+ (NSUInteger)maxRank {
	NSUInteger result = 0;
	
	NSArray *symbolList = [self getRankSymbolList];
	result = symbolList.count - 1;
	
	return result;
}

- (NSString *)suit {
	NSString *result = _suit;
	
	if (result == nil) {
		result = @"?";
	}
	
	return result;
}

- (void)setSuit:(NSString *)suit {
	if ([[[self class] getSuitSymbolList] containsObject:suit]) {
		_suit = suit;
	}
}

- (NSString *)getRankSymbol {
	return [[self class] getRankSymbolList][self.rank];
}

- (void)setRank:(NSUInteger)rank {
	if (rank <= [[self class] maxRank]) { // using [self.class maxRank] to invoke method would be better OOP
		_rank = rank;
	}
}

@end
