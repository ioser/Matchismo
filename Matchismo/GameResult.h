//
//  GameResult.h
//  Matchismo
//
//  Created by Richard Millet on 4/10/13.
//  Copyright (c) 2013 Richard Millet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject

@property (readonly, nonatomic)NSDate *start;
@property (readonly, nonatomic)NSDate *end;
@property (readonly, nonatomic)NSTimeInterval duration;
@property (nonatomic)int score;

+ (NSArray *)allGameResults;
+ (NSArray *)allGameResultsSortedBySelector:(SEL)comparator;
@end

