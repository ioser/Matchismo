//
//  SetGameViewController.h
//  Matchismo
//
//  Created by Richard on 4/19/13.
//  Copyright (c) 2013 Richard Millet. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardGameViewControllerProtocol.h"

@interface SetGameViewController : CardGameViewController <CardGameViewControllerProtocol>

@property (nonatomic, strong) NSArray *cardsFormingASet;

@end
