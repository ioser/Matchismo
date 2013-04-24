//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Richard on 4/19/13.
//  Copyright (c) 2013 Richard Millet. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetMatchingGame.h"
#import "SetDeck.h"

@interface SetGameViewController ()

@end

@implementation SetGameViewController

- (void)restartGame {
	[super restartGame];
}

- (IBAction)showCardFace:(UIButton *)button {
	[super showCardFace:button];
}

- (CardMatchingGame *)game {
	if (_game == nil) {
		_game = [[SetMatchingGame alloc] initWithCardCount:self.cardButtonList.count
														 usingDeck:self.deck
													  cardsToMatch:self.numberOfCardsToMatch];
		_game.flipCost = 1;
	}
	return _game;
}

/*
 * Gets called by the bootstrap/startup framework as the storyboard gets loaded.
 */
- (void)setCardButtonList:(NSArray *)cardButtonList {
	[super setCardButtonList:cardButtonList];
	self.cardBackImage = [UIImage imageNamed:@"cardback.png"];
	UIEdgeInsets insets = UIEdgeInsetsMake(IMAGE_INSET, IMAGE_INSET, IMAGE_INSET, IMAGE_INSET);
	for (UIButton *button in _cardButtonList) {
		[button setImage:self.cardBackImage	forState:UIControlStateNormal];
		[button setImageEdgeInsets:insets];
	}
}

- (Deck *)deck {
	if (_deck == nil) {
		_deck = [[SetDeck alloc] init];
	}
	return _deck;
}

//
//
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
	[self.deck description];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
