//
//  Space.m
//  SeaWorldThunderDome
//
//  Created by mkirillov on 25/09/2017.
//  Copyright © 2017 freddie-ink. All rights reserved.
//

#import "Space.h"
#import "Creature.h"

@implementation Space

- (NSString *)imageName {
    if (self.creature) {
        return self.creature.imageName;
    }
    return @"wave";
}

- (void)refresh {
    if (self.creature.isDead) {
        self.creature = nil;
    } else {
        [self.creature refresh];
    }
}

- (id)copyWithZone:(nullable NSZone *)zone {
    Space *space = [Space new];
    space.creature = [self.creature copy];
    space.xIndex = self.xIndex;
    space.yIndex = self.yIndex;
    return space;
}

@end
