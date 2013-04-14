//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Richard E Millet on 4/12/13.
//  Copyright (c) 2013 Richard Millet. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (CardMatchingGame *)game {
	if (_game == nil) {
		_game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtonList.count
												  usingDeck:self.deck
											   cardsToMatch:self.numberOfCardsToMatch];
	}
	return _game;
}

- (Deck *)deck {
	if (_deck == nil) {
		_deck = [[PlayingCardDeck alloc] init];
	}
	return _deck;
}

/*
 * Gets called by the bootstrap/startup framework as the storyboard gets loaded.
 */
- (void)setCardButtonList:(NSArray *)cardButtonList {
	_cardButtonList = cardButtonList;
	self.cardBackImage = [UIImage imageNamed:@"cardback.png"];
	UIEdgeInsets insets = UIEdgeInsetsMake(IMAGE_INSET, IMAGE_INSET, IMAGE_INSET, IMAGE_INSET);
	for (UIButton *button in _cardButtonList) {
		[button setImage:self.cardBackImage	forState:UIControlStateNormal];
		[button setImageEdgeInsets:insets];
	}
}

//
// Provided by XCode IDE
//
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	NSLog(@"PlayingCardGameViewController's viewWillAppear method called.");
}

@end
