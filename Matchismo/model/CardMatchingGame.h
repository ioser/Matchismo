//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Richard E Millet on 3/27/13.
//  Copyright (c) 2013 Richard Millet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

@property (nonatomic, weak)Card *matchTarget;
@property (nonatomic) int cardsToMatchMode;
@property (nonatomic, readonly) int score;
@property (nonatomic, strong) NSString *consoleMessage;
@property (nonatomic) int flipCount;

/*
 * The designated (default) initializer
 */
- (id)initWithCardCount:(NSUInteger)cardCount
			  usingDeck:(Deck *)deck
		   cardsToMatch:(NSUInteger)cardsToMatch;

- (id)initWithCardCount:(NSUInteger)cardCount
			  usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

- (NSUInteger)numberOfCardsFaceUp;

@end
