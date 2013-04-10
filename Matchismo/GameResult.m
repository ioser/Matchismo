//
//  GameResult.m
//  Matchismo
//
//  Created by Richard E Millet on 4/10/13.
//  Copyright (c) 2013 Richard Millet. All rights reserved.
//

#import "GameResult.h"

@interface GameResult ()

@property (readwrite, nonatomic)NSDate *start;
@property (readwrite, nonatomic)NSDate *end;

@end

@implementation GameResult

#define ALL_RESULTS_KEY @"ALL_RESULTS_KEY"
#define START_KEY @"START_KEY"
#define END_KEY @"END_KEY"
#define SCORE_KEY @"SCORE_KEY"

- (id)asPropertyList {
	return @{ START_KEY : self.start, END_KEY : self.end, SCORE_KEY : @(self.score)};
}

- (void)synchronize {
	NSMutableDictionary *gameResultsList = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] mutableCopy];
	if (gameResultsList == nil) {
		gameResultsList = [[NSMutableDictionary alloc] init];
	}
	gameResultsList[[self.start description]] = [self asPropertyList];
	[[NSUserDefaults standardUserDefaults] setObject:gameResultsList forKey:ALL_RESULTS_KEY];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

//
// Designated initializer
//
- (id)init {
	self = [super init];
	if (self != nil) {
		_start = [NSDate date];
		_end = _start;
	}
	return self;
}

- (NSTimeInterval)duration {
	return [self.end timeIntervalSinceDate:self.start];
}

- (void)setScore:(int)score {
	_score = score;
	self.end = [NSDate date];
	[self synchronize];
}

@end
