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

- (void)setCreature:(Creature *)creature {
    _creature = creature;
    
}

@end
