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

@interface CardGameViewController ()

@property (strong, nonatomic) PlayingCardDeck *playingCardDeck;
@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtonList;

@end

@implementation CardGameViewController

- (void)setCardButtonList:(NSArray *)cardButtonList {
	_cardButtonList = cardButtonList;
	for (UIButton *cardButton in _cardButtonList) {
		Card *card = [self.playingCardDeck drawRandomCard];
		[cardButton setTitle:card.contents forState:UIControlStateSelected];
	}
}

- (Deck *)playingCardDeck {
	if (_playingCardDeck == nil) {
		_playingCardDeck = [[PlayingCardDeck alloc] init];
	}
	return _playingCardDeck;
}

- (IBAction)flipCard:(UIButton *)sender {
	sender.selected = !sender.selected;
	self.flipCount++;
}

- (void)setFlipCount:(int)flipCount {
	_flipCount++;
	self.flipLabel.text = [NSString stringWithFormat:@"Flips: %d", _flipCount];
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
