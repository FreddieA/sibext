//
//  WorldEngine.h
//  SeaWorldThunderDome
//
//  Created by mkirillov on 25/09/2017.
//  Copyright © 2017 freddie-ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorldEngine : NSObject

- (instancetype)initWithItemsPerRow:(int)itemsPerRow itemsCount:(int)itemsCount;
- (void)runCycleWithCompletion:(dispatch_block_t)completion;

@property (readonly) NSArray *spaces;

@end
