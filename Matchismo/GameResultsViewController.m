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

@end

@implementation GameResultsViewController

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

- (void)viewWillAppear:(BOOL)animated {
	NSLog(@"GameResultsViewController's viewWillAppear method called.");
	NSArray *gameResultsList = [GameResult allGameResults];
	NSString *displayText = @"";
	for (GameResult *gameResult in gameResultsList) {
		displayText = [displayText stringByAppendingString:[gameResult description]];
		displayText = [displayText stringByAppendingFormat:@"\n"];
	}
	self.display.text = displayText;
}

@end
