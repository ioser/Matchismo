//
//  Card.h
//  Matchismo
//
//  Created by Richard E Millet on 3/24/13.
//  Copyright (c) 2013 Richard Millet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic)NSString *contents;
@property (nonatomic, getter = isFaceUp)BOOL faceUp;
@property (nonatomic, getter = isUnplayable)BOOL unplayable;
@property (nonatomic, getter = isMatchTarget)BOOL isMatchTarget;

- (int)match:(NSArray *)otherCards;

@end
