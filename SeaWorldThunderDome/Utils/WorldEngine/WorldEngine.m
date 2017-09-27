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

@property (nonatomic, strong) NSMutableArray *creatures;
@property (nonatomic) int itemsPerRow;

@end

@implementation WorldEngine

- (instancetype)initWithItemsPerRow:(int)itemsPerRow itemsCount:(int)itemsCount {
    if (self = [super init]) {
        _itemsPerRow = itemsPerRow;
        _spaces = [Space objectsWithCount:itemsCount];
        
        int orcasCount = (int)((itemsCount * 5) / 100);
        int penguinsCount = (int)((itemsCount - orcasCount) * 30 / 100);
        
        _creatures = [[Orca objectsWithCount:orcasCount] arrayByAddingObjectsFromArray:[Penguin objectsWithCount:penguinsCount]].mutableCopy;
        
        for (Creature *creature in _creatures) {
            NSArray *emptySpaces = [_spaces filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"creature == nil"]];
            int randomIndex = arc4random_uniform((uint32_t)emptySpaces.count);
            [creature moveToSpace:_spaces[randomIndex]];
        }
    }
    return self;
}

- (void)runCycle {
    for (Creature *creature in _creatures) {
        if ([self surroundingAreaForSpace:creature.space].count) {
            NSArray *area = [self surroundingAreaForSpace:creature.space];
            [creature moveToSpace:area[arc4random_uniform((uint32_t)area.count)]];
        }
    }
    _creatures = [[_spaces filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"creature != nil"]] valueForKey:@"creature"];
}

- (NSArray *)surroundingAreaForSpace:(Space *)space {
    NSMutableArray *array = [NSMutableArray new];
    int index = (int)[_spaces indexOfObject:space];
    int rowsCount = (int)_spaces.count / _itemsPerRow;
    int row = floor(index / _itemsPerRow);
    if (index > 0) {
        int left = index - 1;
        [array addObject:_spaces[left]];
    }
    if (index < _spaces.count - 1) {
        int right = index + 1;
        [array addObject:_spaces[right]];
    }
    if (row > 0 && index - _itemsPerRow >= 0) {
        [array addObject:_spaces[index - _itemsPerRow]];
    }
    if (row < rowsCount && index + _itemsPerRow < _spaces.count) {
        [array addObject:_spaces[index + _itemsPerRow]];
    }
    return [array filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"creature == nil"]];
}

@end
