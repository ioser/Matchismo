//
//  GameResultsViewController.m
//  Matchismo
//
//  Created by Richard E Millet on 4/10/13.
//  Copyright (c) 2013 Richard Millet. All rights reserved.
//

#import "GameResultsViewController.h"
#import "GameResult.h"

@interface GameResultsViewController ()

@property (weak, nonatomic) IBOutlet UITextView *display;
@property (nonatomic) SEL sortComparator;

@end

@implementation GameResultsViewController

//@synthesize sortComparator = _sortComparator;

- (SEL)sortComparator {
	if (!_sortComparator) {
		_sortComparator = @selector(compareByDate:);
	}
	return _sortComparator;
}

- (void)setup {
	// init code that can't wait until the viewDidLoad method gets called
}

//
// Framework methods to override
//

- (void)awakeFromNib {
	[self setup];
	NSLog(@"GameResultsViewController's awakeFromNib() method called.");
}

/*
 * This method is not called on Storyboard created view controllers.
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	NSLog(@"GameResultsViewController's initWithNibName() called with %@ : %@", nibNameOrNil, nibBundleOrNil);
	
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	NSLog(@"GameResultsViewController loaded.");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
	NSLog(@"GameResultsViewController's viewWillLayoutSubviews method called.");
}

- (void)updateUI {
	NSArray *gameResultsList = [GameResult allGameResultsSortedBySelector:self.sortComparator];
	NSString *displayText = @"";
	for (GameResult *gameResult in gameResultsList) {
		displayText = [displayText stringByAppendingString:[gameResult description]];
		displayText = [displayText stringByAppendingFormat:@"\n"];
	}
	self.display.text = displayText;
}

- (void)viewWillAppear:(BOOL)animated {
	NSLog(@"GameResultsViewController's viewWillAppear method called.");
	[self updateUI];
}

- (IBAction)sortByScore {
	self.sortComparator = @selector(compareByScore:);
	[self updateUI];
}

- (IBAction)sortByDate {
	self.sortComparator = @selector(compareByDate:);
	[self updateUI];
}


@end
