//
//  SetDeck.m
//  Matchismo
//
//  Created by Richard on 4/18/13.
//  Copyright (c) 2013 Richard Millet. All rights reserved.
//

#import "SetDeck.h"
#import "SetCard.h"

@implementation SetDeck

- (id)init {
	self = [super init];
	int id = 0;
	if (self != nil) {
		for (UIColor *color in [SetCard getColorArray]) {
			for (NSNumber *fillType in [SetCard getFillTypeArray]) {
				for (NSString *suit in [SetCard getSuitSymbolList]) {
					for (int i = 0; i <= [SetCard maxRank]; i++) {
						SetCard *card = [[SetCard alloc] init];
						card.id = id++;
						card.rank = i;
						card.suit = suit;
						card.color = color;
						card.fillType = [fillType intValue];
						[self addCard:card atTop:YES];
					}
				}
			}
		}
	}
	
	//[self description];
	
	return self;
}

- (NSString *)description {
	for (Card *card in self.cards) {
		NSLog(@"Card %@ is in the deck at index %d", card, [self.cards indexOfObject:card]);
		
	}
	
	return @"A deck of Set cards.";
}

@end
