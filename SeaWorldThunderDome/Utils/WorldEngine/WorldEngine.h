//
//  WorldEngine.h
//  SeaWorldThunderDome
//
//  Created by mkirillov on 25/09/2017.
//  Copyright © 2017 freddie-ink. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    GameWonByNoone,
    GameWonByPenguins,
    GameWonByOrcas
} GameWonBy;

@class Space;

@interface WorldEngine : NSObject

- (instancetype)initWithItemsPerRow:(int)itemsPerRow itemsCount:(int)itemsCount;

- (void)runCycleWithCompletion:(void(^)(NSArray *changedSpaces))completion;

@property (readonly) NSArray<Space *> *spaces;
@property (nonatomic, strong) void (^endGameCallback)(GameWonBy winner);

@end
