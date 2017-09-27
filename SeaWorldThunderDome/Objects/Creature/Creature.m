//
//  Creature.m
//  SeaWorldThunderDome
//
//  Created by mkirillov on 25/09/2017.
//  Copyright © 2017 freddie-ink. All rights reserved.
//

#import "Creature.h"
#import "Space.h"

@interface Creature() <NSCopying>

@property (nonatomic, weak) Space *space;

@end

@implementation Creature

- (void)moveToSpace:(Space *)space {
    Space *oldSpace = _space;
    _space = space;
    _space.creature = self;
    oldSpace.creature = nil;
}

- (Space *)space {
    return _space;
}

- (NSString *)imageName {
    return nil;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return [[[self class] alloc] init];
}

@end
