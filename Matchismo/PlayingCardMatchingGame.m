//
//  PlayingCardMatchingGame.m
//  Matchismo
//
//  Created by Richard E Millet on 4/15/13.
//  Copyright (c) 2013 Richard Millet. All rights reserved.
//

#import "PlayingCardMatchingGame.h"

@interface PlayingCardMatchingGame ()


@end

@implementation PlayingCardMatchingGame

#define FLIP_COST 1
#define MISMATCH_PENALTY -2
#define MATCH_BONUS 4

- (int)flipCost {
	return FLIP_COST;
}

- (int)getMatchScore:(Card *)card
{
	int result = 0;
	
	NSArray *faceUpCardList = [self getFaceUpCards];
	Card *targetCard = self.matchTarget;
	
	if (faceUpCardList.count >= self.cardsToMatchMode) {
		result = [self.matchTarget match:faceUpCardList]; // We need to pass an array
		if (result > 0) {
			[self markCardsUnplayable:faceUpCardList];
			targetCard.isMatchTarget = NO;
			targetCard.unplayable = YES;
			self.matchTarget = nil;
			result *= MATCH_BONUS;
			self.consoleMessage = [NSString stringWithFormat:@"%@ matched %@! %d points awarded!",
								   targetCard.contents, [faceUpCardList componentsJoinedByString:@","], result];
			
		} else {
			[self turnCardsFaceDown:faceUpCardList];
			result = MISMATCH_PENALTY;
			self.consoleMessage = [NSString stringWithFormat:@"%@ did not match %@! %d points subtracted!",
								   targetCard.contents, [faceUpCardList componentsJoinedByString:@","], result];
		}
	}
	
	if (result == 0) {
		// Since there were no (or not enough) cards faceup, we only turned the card face up.
		self.consoleMessage = [NSString stringWithFormat:@"%@ flipped face up.", card.contents];
	}
	
	return result;
}

@end