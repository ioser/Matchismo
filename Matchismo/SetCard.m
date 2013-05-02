//
//  SetCard.m
//  Matchismo
//
//  Created by Richard E Millet on 4/16/13.
//  Copyright (c) 2013 Richard Millet. All rights reserved.
//

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

- (int)match:(NSArray *)otherCards {
	int result = 0;
	
	for (Card *card in otherCards) {
		if ([card isKindOfClass:[SetCard class]] == YES) {
			SetCard *setCard = (SetCard *)card;
			if ([setCard.contents isEqualToString:self.contents]) {
				result += 8;
			} else if (setCard.rank == self.rank) {
				result += 4;
			} else if ([setCard.suit isEqualToString:self.suit]) {
				result += 1;
			} else {
				// We found a mismatched card, so we will reset the result to 0 and exit the loop.
				result = 0;
				break;
			}
		} else {
			NSLog(@"WARNING: Found a non 'PlayingCard' card instance.");
		}
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
