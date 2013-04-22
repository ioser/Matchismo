//
//  SuitAndRankCard.h
//  Matchismo
//
//  Created by Richard E Millet on 4/16/13.
//  Copyright (c) 2013 Richard Millet. All rights reserved.
//

#import "Card.h"

@interface SuitAndRankCard : Card

extern NSArray *rankSymbolList;
extern NSArray *suitSymbolList;

@property (strong, nonatomic)NSString *suit;
@property (nonatomic)NSUInteger rank;

+ (NSUInteger)maxRank;
+ (NSArray *)getRankSymbolList;
+ (NSArray *)getSuitSymbolList;
- (NSString *)getRankSymbol;

@end
