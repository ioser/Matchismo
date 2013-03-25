//
//  Card.m
//  Matchismo
//
//  Created by Richard E Millet on 3/24/13.
//  Copyright (c) 2013 Richard Millet. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards {
	int result = 0;
	
	for (Card *card in otherCards) {
		if ([card.contents isEqualToString:self.contents]) {
			result = 1;
		}
		
	}
		 
	return result;
}

@end
