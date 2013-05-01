//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Richard E Millet on 4/12/13.
//  Copyright (c) 2013 Richard Millet. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardMatchingGame.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@end

@implementation PlayingCardGameViewController

- (NSUInteger)numberOfCardsToMatch {
	NSUInteger result = [self.segmentedControl selectedSegmentIndex] + 1;
	if (result < 1) {
		result = 1;
	}
	return result;
}

- (void)updateUI {
	for (UIButton *cardButton in self.cardButtonList) {
		Card *card = [self.game cardAtIndex:[self.cardButtonList indexOfObject:cardButton]];
		cardButton.selected = card.isFaceUp;
//		[cardButton setSelected:card.isFaceUp];
		
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
	self.consoleLabel.attributedText = self.game.consoleMessage;
	self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
	self.flipLabel.text = [NSString stringWithFormat:@"Flips: %d", self.game.flipCount];
}

- (void)restartGame {
	self.segmentedControl.enabled = YES;
	[super restartGame];
}

- (IBAction)showCardFace:(UIButton *)button {
	self.segmentedControl.enabled = NO;
	[super showCardFace:button];
}

- (void)pickNumberOfCardsToMatch:(UISegmentedControl *)sender forEvent:(UIEvent *)event {
	NSInteger index = [sender selectedSegmentIndex];
	NSLog(@"Segment %d selected.", index);
	[self restartGame];
}

- (CardMatchingGame *)game {
	if (_game == nil) {
		_game = [[PlayingCardMatchingGame alloc] initWithCardCount:self.cardButtonList.count
												  usingDeck:self.deck
											   cardsToMatch:self.numberOfCardsToMatch];
		_game.flipCost = 1;
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
	[super setCardButtonList:cardButtonList];
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
	[self.segmentedControl addTarget:self action:@selector(pickNumberOfCardsToMatch:forEvent:) forControlEvents:UIControlEventValueChanged];

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
