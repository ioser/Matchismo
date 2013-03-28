//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Richard E Millet on 3/20/13.
//  Copyright (c) 2013 Richard Millet. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "Card.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *consoleLabel;
@property (strong, nonatomic) PlayingCardDeck *playingCardDeck;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtonList;
@property (strong, nonatomic) CardMatchingGame *game;

@end

@implementation CardGameViewController

- (void)updateUI {
	for (UIButton *cardButton in self.cardButtonList) {
		Card *card = [self.game cardAtIndex:[self.cardButtonList indexOfObject:cardButton]];
		cardButton.selected = card.isFaceUp;
		[cardButton setTitle:card.contents forState:UIControlStateSelected];
		[cardButton setTitle:card.contents forState:UIControlStateSelected | UIControlStateDisabled];
		cardButton.enabled = !card.isUnplayable;
		cardButton.alpha = cardButton.enabled ? 1.0 : 0.3;
	}
	self.consoleLabel.text = self.game.consoleMessage;
	self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
	self.flipLabel.text = [NSString stringWithFormat:@"Flips: %d", self.game.flipCount];
}

- (CardMatchingGame *)game {
	if (_game == nil) {
		_game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtonList.count
												  usingDeck:self.playingCardDeck];
	}
	return _game;
}

- (void)setCardButtonList:(NSArray *)cardButtonList {
	_cardButtonList = cardButtonList;
}

- (Deck *)playingCardDeck {
	if (_playingCardDeck == nil) {
		_playingCardDeck = [[PlayingCardDeck alloc] init];
	}
	return _playingCardDeck;
}

//
// Restart the game with a new set of cards
//
- (IBAction)deal:(UIButton *)sender {
	self.game = nil;
	self.playingCardDeck = nil;
	[self updateUI];
}

- (IBAction)flipCard:(UIButton *)sender {
	[self.game flipCardAtIndex:[self.cardButtonList indexOfObject:sender]];
	[self updateUI];
}

//
// Created by XCode template
//

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
