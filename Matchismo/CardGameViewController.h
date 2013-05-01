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
@property (nonatomic, readonly) NSUInteger numberOfCardsToMatch;
@property (strong, nonatomic)UIImage *cardBackImage;

//
// Should be protected properties
//
@property (weak, nonatomic) IBOutlet UILabel *consoleLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipLabel;


@end
