//
//  PlayingCard.h
//  Matchismo
//
//  Created by Richard E Millet on 3/24/13.
//  Copyright (c) 2013 Richard Millet. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic)NSString *suit;
@property (nonatomic)NSUInteger rank;

+ (NSUInteger)maxRank;
+ (NSArray *)getSuitSymbolList;
@end
