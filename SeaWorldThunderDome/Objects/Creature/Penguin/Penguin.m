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

+ (int)turnsNeededToReproduce {
    return 3;
}

- (NSString *)winText {
    return @"Penguins won. Hail our new flightless overlords";
}

@end
