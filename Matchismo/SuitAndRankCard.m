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

@synthesize suit = _suit;

// @Abstract
- (NSArray *)getRankSymbolList {
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

// @Abstract
- (NSArray *)getSuitSymbolList {
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

// @Abstract
- (NSUInteger)maxRank {
	[self doesNotRecognizeSelector:_cmd];
	return 0;
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
