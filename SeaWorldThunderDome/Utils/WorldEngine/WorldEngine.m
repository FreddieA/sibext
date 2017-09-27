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

@interface WorldEngine()

@property (nonatomic, strong) NSArray *creatures;
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
        
        int orcasCount = (int)((itemsCount * 5) / 100);
        int penguinsCount = (int)((itemsCount - orcasCount) * 30 / 100);
        
        _creatures = [[Orca objectsWithCount:orcasCount] arrayByAddingObjectsFromArray:[Penguin objectsWithCount:penguinsCount]];
        
        for (Creature *creature in _creatures) {
            NSArray *emptySpaces = [_spaces filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"creature == nil"]];
            int randomIndex = arc4random_uniform((uint32_t)emptySpaces.count);
            [creature moveToSpace:_spaces[randomIndex]];
        }
    }
    return self;
}

- (void)runCycleWithCompletion:(dispatch_block_t)completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        for (Creature *creature in _creatures) {
            if ([self surroundingAreaForSpace:creature.space].count) {
                NSArray *area = [self surroundingAreaForSpace:creature.space];
                [creature moveToSpace:area[arc4random_uniform((uint32_t)area.count)]];
            }
        }
        _creatures = [[_spaces filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"creature != nil"]] valueForKey:@"creature"];
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
    
    return [array filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"creature == nil"]];
}

@end
