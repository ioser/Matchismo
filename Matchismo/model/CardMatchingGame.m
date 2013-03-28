//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Richard E Millet on 3/27/13.
//  Copyright (c) 2013 Richard Millet. All rights reserved.
//

#import "CardMatchingGame.h"
#import "PlayingCard.h"

@interface CardMatchingGame ()

@property (nonatomic, strong) NSMutableArray *cardList;
@property (nonatomic) int score; // Redeclared from header file to be non-readonly (i.e., mutable)

@end

@implementation CardMatchingGame

- (NSMutableArray *)cardList
{
	if (_cardList == nil) {
		_cardList = [[NSMutableArray alloc] init];
	}
	return _cardList;
}

/*
 * The designated (default) initializer
 */
- (id)initWithCardCount:(NSUInteger)cardCount
			  usingDeck:(Deck *)deck
{
	self = [super init];
	
	if (self != nil) {
		for (int i = 0; i < cardCount; i++) {
			Card *card = [deck drawRandomCard];
			if (card != nil)
				self.cardList[i] = card;
			else
				return nil; // We failed to initialize properly
		}
	}
	
	return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
	Card *result = nil;
	
	if (index < self.cardList.count) {
		result = self.cardList[index];
	}
	
	return result;
}

#define FLIP_COST 1
#define MISMATCH_PENALTY -2
#define MATCH_BONUS 4

- (int)getMatchScore:(Card *)targetCard
{
	int result = 0;
	
	for (Card *card in self.cardList) {
		if (card.isFaceUp && !card.isUnplayable) {
			result = [targetCard match:@[card]]; // We need to pass an array
			if (result > 0) {
				card.unplayable = YES;
				targetCard.unplayable = YES;
				result *= MATCH_BONUS;
				self.consoleMessage = [NSString stringWithFormat:@"%@ and %@ matched! %d points awarded!",
								  targetCard.contents, card.contents, result];
				
			} else {
				card.faceUp = NO; // Flip the old card back over since it didn't match
				result = MISMATCH_PENALTY;
				self.consoleMessage = [NSString stringWithFormat:@"%@ and %@ did not match! %d points subtracted!",
								  targetCard.contents, card.contents, result];
			}
			break;
		}
	}
	
	if (result == 0) {
		self.consoleMessage = [NSString stringWithFormat:@"%@ flipped face up.", targetCard.contents];
	}
	
	return result;
}

- (void)flipCardAtIndex:(NSUInteger)index
{
	Card *card = [self cardAtIndex:index];
	if (card.isUnplayable == NO) {
		if (card.isFaceUp == NO) {
			int matchScore = [self getMatchScore:card];
			self.score += matchScore - FLIP_COST;
			self.flipCount++;
		} else {
			self.consoleMessage = [NSString stringWithFormat:@"%@ flipped face down.", card.contents];
		}
		card.faceUp = !card.isFaceUp;
	}
}

@end
