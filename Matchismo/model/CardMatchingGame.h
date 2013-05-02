//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Richard E Millet on 3/27/13.
//  Copyright (c) 2013 Richard Millet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "CardMatchingGameProtocol.h"

@interface CardMatchingGame : NSObject <CardMatchingGameProtocol>

@property (nonatomic, weak)Card *matchTarget;
@property (nonatomic) int cardsToMatchMode;
@property (nonatomic, readonly) int score;
@property (nonatomic, strong) NSAttributedString *consoleMessage;
@property (nonatomic) int flipCount;

#define FLIP_COST 1
#define MISMATCH_PENALTY -2
#define MATCH_BONUS 4

/*
 * The designated (default) initializer
 */
- (id)initWithCardCount:(NSUInteger)cardCount
			  usingDeck:(Deck *)deck
		   cardsToMatch:(NSUInteger)cardsToMatch;

- (id)initWithCardCount:(NSUInteger)cardCount
			  usingDeck:(Deck *)deck;

- (Card *)cardAtIndex:(NSUInteger)index;

- (NSUInteger)numberOfCardsFaceUp;

@end
