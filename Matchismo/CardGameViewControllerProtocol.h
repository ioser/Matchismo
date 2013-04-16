//
//  CardGameViewControllerProtocol.h
//  Matchismo
//
//  Created by Richard E Millet on 4/16/13.
//  Copyright (c) 2013 Richard Millet. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CardGameViewControllerProtocol <NSObject>

- (void)restartGame;

- (void)setCardButtonList:(NSArray *)cardButtonList;

- (IBAction)showCardFace:(UIButton *)button;

@end
