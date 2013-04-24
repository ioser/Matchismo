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
#import "GameResult.h"

#define SHOW_CARD_FACE_DELAY 1

@interface CardGameViewController ()

@property (nonatomic)BOOL disableInput;
@property (nonatomic)BOOL gameInPlay;
@property (nonatomic, strong)GameResult *gameResult;

- (void)restartGame;

@end

@implementation CardGameViewController

- (Card *)cardForButton:(UIButton *)button {
	Card *card = [self.game cardAtIndex:[self.cardButtonList indexOfObject:button]];
	return card;
}

- (void)disableCardButtons {
	for (UIButton *button in self.cardButtonList) {
		button.enabled = NO;
	}
}

- (void)updateUI {
	for (UIButton *cardButton in self.cardButtonList) {
		Card *card = [self.game cardAtIndex:[self.cardButtonList indexOfObject:cardButton]];
		cardButton.selected = card.isFaceUp;
		[cardButton setSelected:card.isFaceUp];
		
		//
		// Only set the card back image if the card is *not* selected.
		//
		UIImage *cardBackImage = self.cardBackImage;
		if (cardButton.selected == YES) {
			cardBackImage = nil;
		}
		[cardButton setImage:cardBackImage forState:UIControlStateNormal];
		[cardButton setTitle:card.contents forState:UIControlStateSelected];
		[cardButton setTitle:card.contents forState:UIControlStateSelected | UIControlStateDisabled];
		
		NSLog(@"Card at index %d is %@", [self.cardButtonList indexOfObject:cardButton], card);
		
		cardButton.enabled = !card.isUnplayable;
		cardButton.alpha = cardButton.enabled ? 1.0 : 0.3; // Dim the button if it is not enabled
				
		if (card == self.game.matchTarget) {
			cardButton.backgroundColor = [UIColor redColor];
		} else {
			cardButton.backgroundColor = [UIColor clearColor];
		}
	}
	self.consoleLabel.text = self.game.consoleMessage;
	self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
	self.flipLabel.text = [NSString stringWithFormat:@"Flips: %d", self.game.flipCount];
}

//
// Restart the game with a new set of cards
//
- (void)restartGame {
	if (self.gameResult != nil) {
		self.gameResult.score = self.game.score;
	}
	self.gameResult = [[GameResult alloc] init];
	self.game = nil;
	self.deck = nil;
	self.gameInPlay = NO;
	[self updateUI];
}


- (IBAction)deal:(UIButton *)sender {
	[self restartGame];
}

- (void)toggleFaceState:(UIButton *)button
{
	Card *card = [self.game cardAtIndex:[self.cardButtonList indexOfObject:button]];
	card.faceUp = !card.isFaceUp;
}

/*
 * Shows the face of the final candidate match card for 1 second.  If the match target is not set yet then there will be no delay flipping over the card.
 */
- (IBAction)showCardFace:(UIButton *)button
{
	if (self.gameInPlay == NO) {
		self.gameInPlay = YES;
	}
	
	if (self.disableInput == YES) {
		return;
	}
	
	float delay = 0;
	Card *card = [self.game cardAtIndex:[self.cardButtonList indexOfObject:button]];
	if (card.isFaceUp == NO && self.game.matchTarget != nil &&
			self.game.numberOfCardsFaceUp == self.game.cardsToMatchMode) {
		card.faceUp = YES;
		[self updateUI];
		card.faceUp = NO;
		self.disableInput = YES;
		delay = SHOW_CARD_FACE_DELAY;
	}
	[NSTimer scheduledTimerWithTimeInterval:delay target:self selector:@selector(flipCard:) userInfo:button repeats:NO];

}

- (void)flipCard:(NSTimer *)timer {
	self.disableInput = NO;
	UIButton *button = (UIButton *)timer.userInfo;
	NSUInteger index = [self.cardButtonList indexOfObject:button];
	[self.game flipCardAtIndex:index];
	[self updateUI];
}

- (void)setCardButtonList:(NSArray *)cardButtonList {
	_cardButtonList = cardButtonList;
}

//
// Created by XCode template
//

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.numberOfCardsToMatch = 1;
	[self restartGame];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	NSLog(@"CardGameViewController's viewWillAppear method called.");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
