//
//  PKAssert.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/24/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PKLogBug PKLog

#define PKAssert(condition, desc, ...) \
  if (!(condition)) { \
    PKLogBug((desc), ##__VA_ARGS__); \
    NSAssert((condition), (desc), ##__VA_ARGS__); \
  }

#define PKAssertFail(desc, ...) PKAssert(NO, (desc), ##__VA_ARGS__)
