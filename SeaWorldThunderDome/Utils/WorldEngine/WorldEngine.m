//
//  WorldEngine.m
//  SeaWorldThunderDome
//
//  Created by mkirillov on 25/09/2017.
//  Copyright © 2017 freddie-ink. All rights reserved.
//

#import "WorldEngine.h"
#import "Creature.h"
#import "Space.h"
#import "NSObject+Count.h"
#import "Orca.h"
#import "Penguin.h"

const int kOrcasPercent = 5;
const int kPenguinsPercent = 50;

@interface WorldEngine()

@property (nonatomic, strong) NSMutableArray *creatures;
@property (nonatomic) int itemsPerRow;

@end

@implementation WorldEngine

- (instancetype)initWithItemsPerRow:(int)itemsPerRow itemsCount:(int)itemsCount {
    if (self = [super init]) {
        _itemsPerRow = itemsPerRow;
        _spaces = [Space objectsWithCount:itemsCount];
        
        for (Space *space in _spaces) {
            space.xIndex = [_spaces indexOfObject:space] % itemsPerRow;
            space.yIndex = (int)[_spaces indexOfObject:space] / _itemsPerRow;
        }
        
        int orcasCount = (int)((itemsCount * kOrcasPercent) / 100);
        int penguinsCount = (int)((itemsCount * kPenguinsPercent) / 100);
        
        _creatures = [[Orca objectsWithCount:orcasCount] arrayByAddingObjectsFromArray:[Penguin objectsWithCount:penguinsCount]].mutableCopy;
        
        for (Creature *creature in _creatures) {
            [creature moveToSpace:[creature.class preferredSpaceFromSpaces:_spaces]];
        }
    }
    return self;
}

- (void)runCycleWithCompletion:(dispatch_block_t)completion {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        for (Space *space in _spaces) {
            if (!space.creature.dead) {
                NSArray *area = [weakSelf surroundingAreaForSpace:space];
                if (![space.creature tryToReproduceInArea:area]) {
                    [space.creature moveToSpace:[space.creature.class preferredSpaceFromSpaces:area]];
                }
            }
        }
        [weakSelf.spaces makeObjectsPerformSelector:@selector(refresh)];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(completion) {
                completion();
            }
        });
    });
}

- (NSArray *)surroundingAreaForSpace:(Space *)space {
    NSMutableArray *array = [NSMutableArray new];
    
    [_spaces enumerateObjectsUsingBlock:^(Space *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (((obj.yIndex == space.yIndex - 1 || obj.yIndex == space.yIndex + 1) &&
             (obj.xIndex == space.xIndex + 1 || obj.xIndex == space.xIndex - 1)) ||
            ((obj.yIndex == space.yIndex && (obj.xIndex == space.xIndex + 1 || obj.xIndex == space.xIndex - 1)) ||
             (obj.xIndex == space.xIndex && (obj.yIndex == space.yIndex + 1 || obj.yIndex == space.yIndex - 1)))) {
                [array addObject:obj];
            }
    }];
    return array;
}

@end
