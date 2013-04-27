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
#import "SetCard.h"

@interface SetGameViewController ()

@end

@implementation SetGameViewController

- (NSAttributedString *)getAttributedContents:(SetCard *)card
								  usingButton:(UIButton *)cardButton {
	//
	// First, get the button's existing font so we can use it
	//
	NSAttributedString *attributedString = [cardButton attributedTitleForState:UIControlStateNormal];
	NSMutableDictionary *attributes = [[attributedString attributesAtIndex:0 effectiveRange:NULL] mutableCopy];
	UIFont *existingFont = attributes[NSFontAttributeName];
	//
	// Create the attributed string with the button's font and add color and fill attributes
	//
	if (card.fillType == FILL_TYPE_NONE) {
		attributes[NSStrokeWidthAttributeName] = @(3);
	} else if (card.fillType == FILL_TYPE_SHADED)
		
	NSAttributedString *newAttributeString = [[NSAttributedString alloc] initWithString:card.contents attributes:attributes];
	return newAttributeString;
}

- (void)updateUI {
	for (UIButton *cardButton in self.cardButtonList) {
		Card *card = [self.game cardAtIndex:[self.cardButtonList indexOfObject:cardButton]];
		cardButton.selected = card.isFaceUp;
		[cardButton setSelected:card.isFaceUp];
		
//		[cardButton setAttributedTitle:card.attributedContents forState:UIControlStateNormal];
//		[cardButton setAttributedTitle:card.attributedContents forState:UIControlStateSelected];
//		[cardButton setAttributedTitle:card.attributedContents forState:UIControlStateSelected | UIControlStateDisabled];
		
		NSLog(@"Updating UI button id %@ to [%@:%@] with card ID %d", cardButton.restorationIdentifier, [card.attributedContents string], card.contents, card.id);
		
		cardButton.enabled = !card.isUnplayable;
		cardButton.alpha = cardButton.enabled ? 1.0 : 0.3; // Dim the button if it is not enabled
		
		if (card == self.game.matchTarget) {
			cardButton.backgroundColor = [UIColor lightGrayColor];
		} else {
			cardButton.backgroundColor = [UIColor clearColor];
		}
	}
	self.consoleLabel.text = self.game.consoleMessage;
	self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
	self.flipLabel.text = [NSString stringWithFormat:@"Flips: %d", self.game.flipCount];
}

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
- (void)initCardButtonList {	
	for (UIButton *cardButton in self.cardButtonList) {
		Card *card = [self.game cardAtIndex:[self.cardButtonList indexOfObject:cardButton]];
		NSAttributedString *attributedContents = card.attributedContents;
		if (attributedContents == nil) {
			attributedContents = [self getAttributedContents:card usingButton:cardButton];
			card.attributedContents = attributedContents;
		}
		[cardButton setAttributedTitle:attributedContents forState:UIControlStateSelected];
		[cardButton setAttributedTitle:attributedContents forState:UIControlStateNormal];
		[cardButton setAttributedTitle:attributedContents forState:UIControlStateSelected | UIControlStateDisabled];
		
		NSLog(@"Setting button ID = %@ to [%@ : %@] with card ID %d", cardButton.restorationIdentifier, [attributedContents string], card.contents, card.id);
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
