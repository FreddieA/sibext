//
//  Creature.m
//  SeaWorldThunderDome
//
//  Created by mkirillov on 25/09/2017.
//  Copyright © 2017 freddie-ink. All rights reserved.
//

#import "Creature.h"
#import "Space.h"

@interface Creature()

@property (nonatomic, weak) Space *space;
@property (nonatomic) BOOL movedThisTurn;

@property (nonatomic) int reproduceCounter;

@end

@implementation Creature

- (void)moveToSpace:(Space *)space {
    if (space && !_movedThisTurn) {
        Space *oldSpace = _space;
        _space = space;
        space.creature = self;
        oldSpace.creature = nil;
        
        _movedThisTurn = YES;
        _reproduceCounter++;
    }
}

- (BOOL)dead {
    return NO;
}

- (void)refreshAP {
    _movedThisTurn = NO;
}

+ (int)turnsNeededToReproduce {
    return -1;
}

- (BOOL)tryToReproduceInArea:(NSArray *)spaces {
    if (_reproduceCounter == [self.class turnsNeededToReproduce]) {
        _reproduceCounter = 0;
        NSArray *array = [spaces filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"creature == nil"]];
        if (array.count) {
            Space *space = array[arc4random_uniform((int32_t)array.count)];
            space.creature = [self.class new];
            return YES;
        }
    }
    return NO;
}

+ (Space *)preferredSpaceFromSpaces:(NSArray *)spaces {
    if (spaces.count) {
        return spaces[arc4random_uniform((uint32_t)spaces.count)];
    }
    return nil;
}

- (Space *)space {
    return _space;
}

- (NSString *)imageName {
    return nil;
}

@end
