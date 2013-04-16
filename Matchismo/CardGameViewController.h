//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Richard E Millet on 3/20/13.
//  Copyright (c) 2013 Richard Millet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardGameViewControllerProtocol.h"
#import "CardMatchingGame.h"
#import "Deck.h"

#define IMAGE_INSET 5

@interface CardGameViewController : UIViewController <CardGameViewControllerProtocol>
{
	CardMatchingGame *_game;
	Deck *_deck;
	NSArray *_cardButtonList;
	UIImage *_cardBackImage;
}

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtonList;
@property (strong, nonatomic) Deck *deck;
@property (nonatomic) NSUInteger numberOfCardsToMatch;
@property (strong, nonatomic)UIImage *cardBackImage;


@end
