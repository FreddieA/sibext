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
#import <UIKit/NSIndexPath+UIKitAdditions.h>

const float kOrcasPercent = 5.0;
const float kPenguinsPercent = 50.0;

@interface WorldEngine()

@property (nonatomic, strong) NSMutableArray<Creature *> *creatures;
@property (nonatomic, strong) NSMutableArray<NSIndexPath *> *spacesToUpdate;
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
        
        int orcasCount = (int)((itemsCount * kOrcasPercent) / 100.0);
        int penguinsCount = (int)((itemsCount * kPenguinsPercent) / 100.0);
        
        self.creatures = [[Orca objectsWithCount:orcasCount] arrayByAddingObjectsFromArray:[Penguin objectsWithCount:penguinsCount]].mutableCopy;
        
        for (Creature *creature in self.creatures) {
            [creature moveToSpace:[creature.class preferredSpaceFromSpaces:self.spaces]];
        }
    }
    return self;
}

- (void)runCycleWithCompletion:(dispatch_block_t)completion {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        weakSelf.spacesToUpdate = [NSMutableArray new];
        NSArray *oldSpacesState = [[NSArray alloc] initWithArray:weakSelf.spaces copyItems:YES];
        
        for (Space *space in self.spaces) {
            if (!space.creature.isDead) {
                NSArray *area = [weakSelf surroundingAreaForSpace:space];
                if (![space.creature canReproduceInArea:area]) {
                    [space.creature moveToSpace:[space.creature.class preferredSpaceFromSpaces:area]];
                }
            }
        }
        for (int i = 0; i < self.spaces.count; i++) {
            Space *space = self.spaces[i];
            [space refresh];
            if (space.creature != [oldSpacesState[i] creature]) {
                [weakSelf.spacesToUpdate addObject:[NSIndexPath indexPathForItem:i inSection:0]];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if(completion) {
                completion();
            }
        });
    });
}

- (NSArray *)updatedIndexes {
    return self.spacesToUpdate;
}

- (NSArray *)surroundingAreaForSpace:(Space *)space {
    NSMutableArray *array = [NSMutableArray new];
    // TODO: learn C++ to write this better
    [_spaces enumerateObjectsUsingBlock:^(Space *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        BOOL leftAndRight = obj.yIndex == space.yIndex - 1 || obj.yIndex == space.yIndex + 1;
        BOOL topAndBottom = obj.xIndex == space.xIndex + 1 || obj.xIndex == space.xIndex - 1;
        BOOL yAxisSides = obj.yIndex == space.yIndex && (obj.xIndex == space.xIndex + 1 || obj.xIndex == space.xIndex - 1);
        BOOL xAxisSides = obj.xIndex == space.xIndex && (obj.yIndex == space.yIndex + 1 || obj.yIndex == space.yIndex - 1);
        
        if ((leftAndRight && topAndBottom) || yAxisSides || xAxisSides) {
            [array addObject:obj];
        }
    }];
    return array;
}

@end
