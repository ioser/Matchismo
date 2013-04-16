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
	self.numberOfCardsToMatch = index + 1;
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
