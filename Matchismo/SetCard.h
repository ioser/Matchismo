//
//  SetCard.h
//  Matchismo
//
//  Created by Richard E Millet on 4/16/13.
//  Copyright (c) 2013 Richard Millet. All rights reserved.
//

#import "SuitAndRankCard.h"

#define FILL_TYPE_NONE 0
#define FILL_TYPE_SHADED 1
#define FILL_TYPE_SOLID 2

@interface SetCard : SuitAndRankCard

@property (strong, nonatomic, readonly) NSArray *colorArray;
@property (strong, nonatomic, readonly) NSArray *fillTypeArray;
@property (strong, nonatomic) UIColor *color;
@property (nonatomic) int fillType;

+ (NSArray *)getColorArray;
+ (NSArray *)getFillTypeArray;

@end
