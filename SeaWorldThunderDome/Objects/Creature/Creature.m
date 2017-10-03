//
//  Creature.m
//  SeaWorldThunderDome
//
//  Created by mkirillov on 25/09/2017.
//  Copyright © 2017 freddie-ink. All rights reserved.
//

#import "NSArray+Random.h"
#import "Creature.h"
#import "Space.h"

@interface Creature()

@property (nonatomic, weak) Space *space;
@property (nonatomic) BOOL movedThisTurn;

@property (nonatomic) int reproduceCount;

@end

@implementation Creature

- (void)moveToSpace:(Space *)space {
    if (space && !self.movedThisTurn) {
        Space *oldSpace = self.space;
        self.space = space;
        space.creature = self;
        oldSpace.creature = nil;
        
        self.movedThisTurn = YES;
        self.reproduceCount++;
    }
}

- (BOOL)isDead {
    return NO;
}

- (void)refresh {
    self.movedThisTurn = NO;
}

+ (int)turnsNeededToReproduce {
    return -1;
}

- (BOOL)canReproduceInArea:(NSArray *)spaces {
    if (self.reproduceCount == [self.class turnsNeededToReproduce]) {
        self.reproduceCount = 0;
        NSArray *array = [spaces filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"creature == nil"]];
        if (array.count) {
            Space *space = array.randomObject;
            space.creature = [self.class new];
            return YES;
        }
    }
    return NO;
}

+ (Space *)preferredSpaceFromSpaces:(NSArray *)spaces {
    NSArray *emtyTiles = [spaces filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"creature == nil"]];
    if (emtyTiles.count) {
        return emtyTiles.randomObject;
    }
    return nil;
}

- (Space *)space {
    return _space;
}

- (NSString *)imageName {
    return nil;
}

- (id)copyWithZone:(NSZone *)zone {
    Creature *creature = [Creature new];
    creature.reproduceCount = self.reproduceCount;
    creature.movedThisTurn = self.movedThisTurn;
    return creature;
}

@end
