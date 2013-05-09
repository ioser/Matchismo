//
//  SetCard.m
//  Matchismo
//
//  Created by Richard E Millet on 4/16/13.
//  Copyright (c) 2013 Richard Millet. All rights reserved.
//

#import "REMLogger.h"
#import "SetCard.h"

@interface SetCard ()

@end

@implementation SetCard

@synthesize attributedContents = _attributedContents;

+ (NSArray *)getColorArray {
	return @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor]];
}

+ (NSArray *)getFillTypeArray {
	return @[@0, @1, @2];
}

// @Override
+ (NSArray *)getRankSymbolList {
	return @[@"1", @"2", @"3"];
}

// @Override
+ (NSArray *)getSuitSymbolList {
	return @[@"■", @"▲", @"●"];
}

- (NSAttributedString *)attributedContents {
	return _attributedContents;
}

- (void)setAttributedContents:(NSAttributedString *)attributedContents {
	_attributedContents = attributedContents;
}

/*
 * Forms a set if all the cards either have the same color or they all have different colors
 */
- (BOOL)formsColorSetWithCardList:(NSArray *)cardList {
	BOOL result = NO;
	
	SetCard *card1 = self;
	SetCard *card2 = cardList[0];
	SetCard *card3 = cardList[1];
	
	if (([card1.color isEqual:card2.color] && [card2.color isEqual:card3.color]) ||
		(![card1.color isEqual:card2.color] && ![card2.color isEqual:card3.color] && ![card1.color isEqual:card3.color])) {
		result = YES;
	}
	
	return result;
}

- (BOOL)formsFillSetWithCardList:(NSArray *)cardList {
	BOOL result = NO;
	
	SetCard *card1 = self;
	SetCard *card2 = cardList[0];
	SetCard *card3 = cardList[1];
	
	if ((card1.fillType == card2.fillType && card2.fillType == card3.fillType) ||
		(card1.fillType != card2.fillType && card2.fillType != card3.fillType && card1.fillType != card3.fillType)) {
		result = YES;
	}
	
	return result;
}

- (BOOL)formsRankSetWithCardList:(NSArray *)cardList {
	BOOL result = NO;
	
	SetCard *card1 = self;
	SetCard *card2 = cardList[0];
	SetCard *card3 = cardList[1];
	
	if ((card1.rank == card2.rank && card2.rank == card3.rank) ||
		(card1.rank != card2.rank && card2.rank != card3.rank && card1.rank != card3.rank)) {
		result = YES;
	}
	
	return result;
}

- (BOOL)formsSuitSetWithCardList:(NSArray *)cardList {
	BOOL result = NO;
	
	SetCard *card1 = self;
	SetCard *card2 = cardList[0];
	SetCard *card3 = cardList[1];
	
	if (([card1.suit isEqual:card2.suit] && [card2.suit isEqual:card3.suit]) ||
		(![card1.suit isEqual:card2.suit] && ![card2.suit isEqual:card3.suit] && ![card1.suit isEqual:card3.suit])) {
		result = YES;
	}
	
	return result;
}

- (BOOL) isInAllSets:(NSArray *)cardList {
	BOOL result = YES;
	
	if ([self formsColorSetWithCardList:cardList] == NO) {
		result = NO;
		DLog(@"Color set test failed.");
	} else if ([self formsFillSetWithCardList:cardList] == NO) {
		result = NO;
		DLog(@"Fill set test failed.");
	} else if ([self formsRankSetWithCardList:cardList] == NO) {
		result = NO;
		DLog(@"Rank set test failed.");
	} else if ([self formsSuitSetWithCardList:cardList] == NO) {
		result = NO;
		DLog(@"Suit set test failed.");
	}
	
	return result;
}

- (int)match:(NSArray *)otherCards {
	int result = 0;
	
	if (otherCards.count == 2) {
		if ([self isInAllSets:otherCards] == YES) {
			result = 10;
		}
	} else {
		[NSException raise:@"Not the correct number of objects for a Set." format:@"otherCards array size needs to be 2 but was %d.", otherCards.count];
	}
	
	return result;
}

- (NSString *)getColorName:(UIColor *)color {
	NSString *result = nil;
	
	if (color == [UIColor redColor]) {
		result = @"red";
	} else if (color == [UIColor greenColor]) {
		result = @"green";
	} else if (color == [UIColor blueColor]) {
		result = @"blue";
	}
	
	return result;
}

- (NSString *)getFillName:(int)fillType {
	NSString *result = nil;
	
	if (fillType == FILL_TYPE_NONE) {
		result = @"clear";
	} else if (fillType == FILL_TYPE_SHADED) {
		result = @"shaded";
	} else if (fillType == FILL_TYPE_SOLID) {
		result = @"solid";
	}
	
	return result;
}

// @Override
- (NSString *)getRankSymbol {
	NSString *result = @"";
	
	for (int i = 0; i <= self.rank; i++) {
		result = [result stringByAppendingString: self.suit];
	}
	
	return result;
}

- (NSString *)description {
	NSString *result = [NSString stringWithFormat:@"%@", [self getRankSymbol]];
	result = [NSString stringWithFormat:@"%@-%@-%@", result, [self getColorName:[self color]], [self getFillName:[self fillType]]];
	return result;
}

- (NSString *)contents {
	NSString *result = @"";
	
	result = [self getRankSymbol];
	
	return result;
}

@end
