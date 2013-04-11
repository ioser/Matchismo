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

+ (NSArray *)allGameResults {
	return [self allGameResultsSortedBySelector:@selector(compareByDate:)]; // By default, order by date.
}

+ (NSArray *)allGameResultsSortedBySelector:(SEL)comparator {
	NSMutableArray *newResultList = [[NSMutableArray alloc] init];
	NSDictionary *oldResultsList = [[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY];
	for (id propertyList in [oldResultsList allValues]) {
		GameResult *gameResult = [[GameResult alloc] initWithPropertyList:propertyList];
		if (gameResult != nil) {
			[newResultList addObject:gameResult];
		}
	}
	
	return [newResultList sortedArrayUsingSelector:comparator];
}

- (NSComparisonResult)compareByScore:(GameResult *)otherGameResult {
	NSInteger result = NSOrderedAscending;
	if (self.score < otherGameResult.score) {
		result = NSOrderedDescending;
	}
	return result;
}

- (NSComparisonResult)compareByDate:(GameResult *)otherGameResult {
	return [self.start compare:otherGameResult.start];
}

- (NSComparisonResult)compareByDuration:(GameResult *)otherGameResult {
	NSInteger result = NSOrderedAscending;
	if (self.duration < otherGameResult.duration) {
		result = NSOrderedDescending;
	}
	return result;
}

- (NSString *)description {
	return [NSString stringWithFormat:@"Score: %d Start: %@ Time: %f",
			self.score, self.start, self.duration];
}

- (id)initWithPropertyList:(id)propertyList {
	self = [self init];
	if (self != nil) {
		if ([propertyList isKindOfClass:[NSDictionary class]]) {
			NSDictionary *resultsDict = (NSDictionary *)propertyList;
			_start = resultsDict[START_KEY];
			_end = resultsDict[END_KEY];
			_score = [resultsDict[SCORE_KEY] intValue];
			if (_start == nil || _end == nil) {
				self = nil;
			}
		}
	}
	return self;
}

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
