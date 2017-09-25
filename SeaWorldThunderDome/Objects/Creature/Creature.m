//
//  Creature.m
//  SeaWorldThunderDome
//
//  Created by mkirillov on 25/09/2017.
//  Copyright © 2017 freddie-ink. All rights reserved.
//

#import "Creature.h"

@interface Creature()

@property (nonatomic, weak) Space *space;

@end

@implementation Creature

- (void)moveToSpace:(Space *)space {
    _space = space;
}

- (Space *)space {
    return _space;
}

@end
