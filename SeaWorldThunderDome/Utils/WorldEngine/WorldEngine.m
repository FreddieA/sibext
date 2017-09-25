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

@interface WorldEngine()

@property (nonatomic, strong) NSArray *spaces;
@property (nonatomic, strong) NSArray *creatures;

@end

@implementation WorldEngine

- (void)runCycle {
    for (Creature *creature in _creatures) {
        if ([self surroundingAreaForSpace:creature.space].count) {
            [creature moveToSpace:[self surroundingAreaForSpace:creature.space].anyObject];
        }
    }
}

- (NSSet *)surroundingAreaForSpace:(Space *)space {
    return [NSSet set];
}

@end
