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
#include "REMLogger.h"

#define SHADE_LEVEL 0.25
#define SOLID_LEVEL 1.0

@interface SetGameViewController ()

@end

@implementation SetGameViewController

- (NSUInteger)numberOfCardsToMatch {
	return 2; // two other cards must match the match-target card in the game of Set
}

- (NSAttributedString *)getAttributedContentsByAdding:(NSDictionary *)dict forCard:(SetCard *)card {
	NSAttributedString *result = nil;
	
	NSMutableDictionary *attributes = [[card.attributedContents attributesAtIndex:0 effectiveRange:NULL] mutableCopy];
	[attributes addEntriesFromDictionary:dict];
	result = [[NSAttributedString alloc] initWithString:card.contents attributes:attributes];
	
	return result;
}

/*
 * Returns the results of adding an attribute to the current attributed contents of a card.  Does not
 * change the attributed contents of the card.
 */
- (NSAttributedString *)getAttributedContentsByAdding:(NSObject *)attribute forKey:(NSString *)key forCard:(SetCard *)card {
	NSAttributedString *result = nil;
	
	NSMutableDictionary *attributes = [[card.attributedContents attributesAtIndex:0 effectiveRange:NULL] mutableCopy];
	[attributes setObject:attribute forKey:key];
	result = [[NSAttributedString alloc] initWithString:card.contents attributes:attributes];
	
	return result;
}

- (NSAttributedString *)getAttributedContents:(SetCard *)card
								  usingButton:(UIButton *)cardButton {
	//
	// First, get the button's existing attributes so we can use them
	//
	NSAttributedString *attributedString = [cardButton attributedTitleForState:UIControlStateNormal];
	NSMutableDictionary *attributes = [[attributedString attributesAtIndex:0 effectiveRange:NULL] mutableCopy];
	//
	// Create the attributed string with the button's font and add color and fill attributes
	//
	[attributes setObject:card.color forKey:NSForegroundColorAttributeName];
	//
	// Reset the stroke width, and alpha level to the defaults
	//
	[attributes setObject:@(0) forKey:NSStrokeWidthAttributeName];
	[attributes setObject:[card.color colorWithAlphaComponent:SOLID_LEVEL] forKey:NSForegroundColorAttributeName];
	//
	// Now set the attributes based on the card that the button's title will represent
	//
	if (card.fillType == FILL_TYPE_NONE) {
		[attributes setObject:@(3) forKey:NSStrokeWidthAttributeName];
	} else if (card.fillType == FILL_TYPE_SHADED) {
		[attributes setObject:[card.color colorWithAlphaComponent:SHADE_LEVEL] forKey:NSForegroundColorAttributeName];
	} else if (card.fillType == FILL_TYPE_SOLID) {
		// Do nothing since the color has already been set
	} else {
		NSLog(@"ERROR: Unknown fill type %d for card %@", card.fillType, card);
	}
		
	NSAttributedString *newAttributeString = [[NSAttributedString alloc] initWithString:card.contents attributes:attributes];
	return newAttributeString;
}

- (void)showCardSelected:(SetCard *)card {
	
}

- (void)updateUI {
	NSLog(@"Update UI called.");
	for (UIButton *cardButton in self.cardButtonList) {
		Card *card = [self.game cardAtIndex:[self.cardButtonList indexOfObject:cardButton]];
		cardButton.selected = card.isFaceUp;
		
		DLog(@"Updating UI button id %@ to [%@:%@] with card ID %d", cardButton.restorationIdentifier, [card.attributedContents string], card, card.id);
		
		cardButton.enabled = !card.isUnplayable;
		cardButton.alpha = cardButton.enabled ? 1.0 : 0.2; // Dim the button if it is not enabled
		
		if (card == self.game.matchTarget) {
			cardButton.backgroundColor = [UIColor lightGrayColor];
		} else {
			cardButton.backgroundColor = [UIColor clearColor];
		}
	}
	self.consoleLabel.attributedText = self.game.consoleMessage;
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

- (NSArray *)findCardsFormingASet {
	NSArray *result = nil;
	
	for (UIButton *cardButton in self.cardButtonList) {
		SetCard *A = (SetCard *)[self.game cardAtIndex:[self.cardButtonList indexOfObject:cardButton]];
		for (UIButton *cardButton in self.cardButtonList) {
			SetCard *B = (SetCard *)[self.game cardAtIndex:[self.cardButtonList indexOfObject:cardButton]];
			for (UIButton *cardButton in self.cardButtonList) {
				SetCard *C = (SetCard *)[self.game cardAtIndex:[self.cardButtonList indexOfObject:cardButton]];
				if (A != B && A != C && B != C) {
					if ([A match:@[B, C]] > 0) {
						result = @[A, B, C];
						return result;
					}
				}
			}
		}
	}
	
	return result;
}

/*
 * Gets called by the bootstrap/startup framework as the storyboard gets loaded.
 */
- (void)initCardButtonList {	
	for (UIButton *cardButton in self.cardButtonList) {
		SetCard *card = (SetCard *)[self.game cardAtIndex:[self.cardButtonList indexOfObject:cardButton]];
		if (card != nil) {
			NSAttributedString *attributedContents = card.attributedContents;
			if (attributedContents == nil) {
				attributedContents = [self getAttributedContents:(SetCard *)card usingButton:cardButton];
				card.attributedContents = attributedContents;
			}
			[cardButton setAttributedTitle:attributedContents forState:UIControlStateNormal];
			
			//
			// If the button is selected, we want the string underlined
			//
			attributedContents = [self getAttributedContentsByAdding:@(NSUnderlineStyleSingle) forKey:NSUnderlineStyleAttributeName forCard:card];
			[cardButton setAttributedTitle:attributedContents forState:UIControlStateSelected];
			
			//
			// If the button is both selected and disabled then we want the string empty/invisable
			//
			attributedContents = [[NSAttributedString alloc] initWithString:@""];
			[cardButton setAttributedTitle:attributedContents forState:UIControlStateSelected | UIControlStateDisabled];
			
			NSLog(@"Setting button ID = %@ to [%@ : %@] with card ID %d", cardButton.restorationIdentifier, [attributedContents string], card, card.id);
		} else {
			//
			// We don't have a card for this button, so show it as blank.
			//
			NSAttributedString *attributedContents = [[NSAttributedString alloc] initWithString:@""];
			[cardButton setAttributedTitle:attributedContents forState:UIControlStateNormal];
			[cardButton setAttributedTitle:attributedContents forState:UIControlStateSelected];
			[cardButton setAttributedTitle:attributedContents forState:UIControlStateSelected | UIControlStateDisabled];
		}
	}
	//
	// Keep calling ourself until we're showing a group of buttons that contain at least one
	// valid set for the user to find.
	//
	NSArray *cardsFormingASet = [self findCardsFormingASet];
	if (cardsFormingASet == nil && [self.deck countOfCards] > 0) {
		self.game = nil;
		[self initCardButtonList];
	} else {
		self.cardsFormingASet = cardsFormingASet;
	}
	
	NSLog(@"Cards left in deck %d.", [self.deck countOfCards]);
	NSLog(@"Cards in set are %@, %@, %@", self.cardsFormingASet[0], self.cardsFormingASet[1], self.cardsFormingASet[2]);
}

- (Deck *)deck {
	if (_deck == nil) {
		_deck = [[SetDeck alloc] init];
	}
	return _deck;
}

//
// If we found a match, put the non-matching cards back into the deck, reshuffle, and deal a new set
// of cards.
//
- (void)handleMatch {
	if ([self.game lastMatchScore] > 0) {
		self.game.lastMatchScore = 0;
		[self.game shuffleAndRedeal:[self.game cardCount] usingDeck:self.deck];
		[self initCardButtonList];
	}
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
