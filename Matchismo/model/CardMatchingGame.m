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

@synthesize flipCost;

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
		   cardsToMatch:(NSUInteger)cardsToMatch;
{
	self = [super init];
	
	if (self != nil) {
		self.cardsToMatchMode = cardsToMatch;
		for (int i = 0; i < cardCount; i++) {
			Card *card = [deck drawRandomCard];
			if (card != nil)
				self.cardList[i] = card;
			else
				return nil; // We failed to initialize properly
		}
	}
	
	for (Card *card in self.cardList) {
		NSLog(@"Cards in play: %@ at %d in list.", card, [self.cardList indexOfObject:card]);
	}
	
	return self;
}

- (id)initWithCardCount:(NSUInteger)cardCount
			  usingDeck:(Deck *)deck {
	return [self initWithCardCount:cardCount usingDeck:deck cardsToMatch:1];
}

- (Card *)cardAtIndex:(NSUInteger)index
{
	Card *result = nil;
	
	if (index < self.cardList.count) {
		result = self.cardList[index];
	}
	
	return result;
}

- (void)markCardsUnplayable:(NSArray *)cardList {
	for (Card *card in cardList) {
		card.unplayable = YES;
	}
}

- (void)turnCardsFaceDown:(NSArray *)cardList {
	for (Card *card in cardList) {
		card.faceUp = NO;
	}
}

- (NSArray *)getFaceUpCards {
 	NSMutableArray *result = [[NSMutableArray alloc] init];
	
	for (Card *card in self.cardList) {
		if (card.isFaceUp && !card.isUnplayable && !card.isMatchTarget) {
			[result addObject:card];
		}
	}
	
	return result;
}

- (NSUInteger)numberOfCardsFaceUp {
	NSUInteger result = 0;
	for (Card *card in self.cardList) {
		if (card.isFaceUp && !card.isUnplayable) {
			result++;
		}
	}
	return result;
}

- (void)flipCardAtIndex:(NSUInteger)index
{
	Card *card = [self cardAtIndex:index];
	if (card.isUnplayable == NO) {
		if (card.isFaceUp == NO) {
			card.faceUp = YES;
			NSString *message = [NSString stringWithFormat:@"%@ flipped face up.", card.contents];
			NSMutableAttributedString *mat = [[NSMutableAttributedString alloc] initWithString:message];
			[message rangeOfString:card.contents
			[mat replaceCharactersInRange:<#(NSRange)#> withAttributedString:<#(NSAttributedString *)#>]
			self.consoleMessage = [self appendAttributedString:[card attributedContents] toString:@" flipped face up."];
			if (self.matchTarget != nil) {
				int matchScore = [self getMatchScore:card];
				self.score += matchScore - self.flipCost;
			} else {
				card.isMatchTarget = YES;
				self.matchTarget = card;
				self.score -= self.flipCost;
			}
			self.flipCount++;
		} else {
			card.faceUp = NO;
//			self.consoleMessage = [NSString stringWithFormat:@"%@ flipped face down.", card.attributedContents];
			self.consoleMessage = [self appendAttributedString:card.attributedContents toString:@" flipped face down."];
			if (card.isMatchTarget == YES) {
				card.isMatchTarget = NO;
				self.matchTarget = nil;
				[self turnCardsFaceDown:[self getFaceUpCards]];
			}
		}
	}
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
			NSString *message = [NSString stringWithFormat:@"%@ matched %@! %d points awarded!",
								   targetCard.contents, [faceUpCardList componentsJoinedByString:@","], result];
			self.consoleMessage = [[NSAttributedString alloc] initWithString:message];
			
		} else {
			[self turnCardsFaceDown:faceUpCardList];
			result = MISMATCH_PENALTY;
			NSString *message = [NSString stringWithFormat:@"%@ did not match %@! %d points subtracted!",
								   targetCard.contents, [faceUpCardList componentsJoinedByString:@","], result];
			self.consoleMessage = [[NSAttributedString alloc] initWithString:message];
		}
	}
	
	if (result == 0) {
		// Since there were no (or not enough) cards faceup, we only turned the card face up.
		NSString *message = [NSString stringWithFormat:@"%@ flipped face up.", card.contents];
		self.consoleMessage = [[NSAttributedString alloc] initWithString:message];
	}
	
	return result;
}

@end
