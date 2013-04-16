//
//  CardMatchingGameProtocol.h
//  Matchismo
//
//  Created by Richard E Millet on 4/15/13.
//  Copyright (c) 2013 Richard Millet. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CardMatchingGameProtocol <NSObject>

@property (nonatomic) int flipCost;

- (int)getMatchScore:(Card *)card;

- (void)flipCardAtIndex:(NSUInteger)index;

- (NSArray *)getFaceUpCards;

- (void)turnCardsFaceDown:(NSArray *)cardList;

- (void)markCardsUnplayable:(NSArray *)cardList;

@end
