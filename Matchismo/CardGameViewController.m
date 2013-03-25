//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Richard E Millet on 3/20/13.
//  Copyright (c) 2013 Richard Millet. All rights reserved.
//

#import "CardGameViewController.h"

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (nonatomic) int flipCount;

@end

@implementation CardGameViewController

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
