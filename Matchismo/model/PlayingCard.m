//
//  PlayingCard.m
//  Matchismo
//
//  Created by Richard E Millet on 3/24/13.
//  Copyright (c) 2013 Richard Millet. All rights reserved.
//

#import "PlayingCard.h"

NSArray *rankSymbolList = nil; // static member
NSArray *suitSymbolList = nil; // static member

@implementation PlayingCard

@synthesize suit = _suit;

+ (NSArray *)getRankSymbolList {
	if (rankSymbolList == nil) {
		rankSymbolList = @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8",
					 @"9", @"10", @"J", @"Q", @"K",];
	}
	return rankSymbolList;
}

+ (NSArray *)getSuitSymbolList {
	if (suitSymbolList == nil) {
		suitSymbolList = @[@"♥", @"♦", @"♠", @"♣"];
	}
	return suitSymbolList;
}

+ (NSUInteger)maxRank {
	NSUInteger result = 0;
	
	NSArray *symbolList = [PlayingCard getRankSymbolList];
	result = symbolList.count - 1;
	
	return result;
}

- (NSString *)description {
	return self.contents;
}

- (void)setRank:(NSUInteger)rank {
	if (rank <= [PlayingCard maxRank]) { // using [self.class maxRank] to invoke method would be better OOP
		_rank = rank;
	}
}

- (NSString *)getRankSymbol {
	return [PlayingCard getRankSymbolList][self.rank];
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

- (void)setSuit:(NSString *)suit {
	if ([[PlayingCard getSuitSymbolList] containsObject:suit]) {
		_suit = suit;
	}
}

- (int)match:(NSArray *)otherCards {
	int result = 0;
	
	for (Card *card in otherCards) {
		if ([card isKindOfClass:[PlayingCard class]] == YES) {
			PlayingCard *playingCard = (PlayingCard *)card;
			if ([playingCard.contents isEqualToString:self.contents]) {
				result += 8;
			} else if (playingCard.rank == self.rank) {
				result += 4;
			} else if ([playingCard.suit isEqualToString:self.suit]) {
				result += 1;
			} else {
				// We found a mismatched card, so we will reset the result to 0 and exit the loop.
				result = 0;
				break;
			}
		} else {
			NSLog(@"WARNING: Found a non 'PlayingCard' card instance.");
		}
	}
	
	return result;
}

@end
