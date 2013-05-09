//
//  REMLogger.h
//  Matchismo
//
//  Created by Richard on 5/8/13.
//  Copyright (c) 2013 Richard Millet. All rights reserved.
//

#ifndef Matchismo_REMLogger_h
#define Matchismo_REMLogger_h

// Define global variable
extern BOOL myDebugEnabled;
#define DLog(fmt, ...) if (myDebugEnabled) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

#endif
