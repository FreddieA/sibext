//
//  Penguin.m
//  SeaWorldThunderDome
//
//  Created by mkirillov on 26/09/2017.
//  Copyright © 2017 freddie-ink. All rights reserved.
//

#import "Penguin.h"
#import "Space.h"

@implementation Penguin

- (NSString *)imageName {
    return @"tux";
}

+ (Space *)preferredSpaceFromSpaces:(NSArray *)spaces {
    Space *space = [super preferredSpaceFromSpaces:spaces];
    return (space.creature) ? nil : space;
}

+ (int)turnsNeededToReproduce {
    return 3;
}

@end
