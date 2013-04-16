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

// Must override in subclass
- (int)getMatchScore:(Card *)card
{
	int result = 0;
	
	[self doesNotRecognizeSelector:_cmd];
	
	return result;
}

- (void)flipCardAtIndex:(NSUInteger)index
{
	Card *card = [self cardAtIndex:index];
	if (card.isUnplayable == NO) {
		if (card.isFaceUp == NO) {
			card.faceUp = YES;
			self.consoleMessage = [NSString stringWithFormat:@"%@ flipped face up.", card.contents];			
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
			self.consoleMessage = [NSString stringWithFormat:@"%@ flipped face down.", card.contents];
			if (card.isMatchTarget == YES) {
				card.isMatchTarget = NO;
				self.matchTarget = nil;
				[self turnCardsFaceDown:[self getFaceUpCards]];
			}
		}
	}
}

@end
