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

#define SHADE_LEVEL 0.25

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
	for (UIButton *cardButton in self.cardButtonList) {
		Card *card = [self.game cardAtIndex:[self.cardButtonList indexOfObject:cardButton]];
		cardButton.selected = card.isFaceUp;
		
		NSLog(@"Updating UI button id %@ to [%@:%@] with card ID %d", cardButton.restorationIdentifier, [card.attributedContents string], card.contents, card.id);
		
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

/*
 * Gets called by the bootstrap/startup framework as the storyboard gets loaded.
 */
- (void)initCardButtonList {	
	for (UIButton *cardButton in self.cardButtonList) {
		SetCard *card = (SetCard *)[self.game cardAtIndex:[self.cardButtonList indexOfObject:cardButton]];
		NSAttributedString *attributedContents = card.attributedContents;
		if (attributedContents == nil) {
			attributedContents = [self getAttributedContents:(SetCard *)card usingButton:cardButton];
			card.attributedContents = attributedContents;
		}
		[cardButton setAttributedTitle:attributedContents forState:UIControlStateNormal];
		
		
		[cardButton setAttributedTitle:attributedContents forState:UIControlStateSelected];
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
