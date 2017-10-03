//
//  Orca.m
//  SeaWorldThunderDome
//
//  Created by mkirillov on 26/09/2017.
//  Copyright © 2017 freddie-ink. All rights reserved.
//

#import "Orca.h"
#import "Space.h"
#import "Penguin.h"
#import "NSArray+Random.h"

@interface Orca()

@property (nonatomic) int deathCount;

@end

@implementation Orca

- (NSString *)imageName {
    return @"orca";
}

- (void)moveToSpace:(Space *)space {
    if ([space.creature isKindOfClass:Penguin.class]) {
        self.deathCount = 0;
    } else {
        self.deathCount ++;
    }
    
    if (!self.isDead) {
        [super moveToSpace:space];
    }
}

- (int)turnsNeededToDie {
    return 3;
}

- (BOOL)isDead {
    return self.deathCount >= self.turnsNeededToDie;
}

+ (Space *)preferredSpaceFromSpaces:(NSArray *)spaces {
    NSArray *spacesWithFood = [spaces filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(Space *space, NSDictionary *bindings) {
        return [space.creature isKindOfClass:Penguin.class];
    }]];
    if (spacesWithFood.count) {
        return spacesWithFood.randomObject;
    }
    return [super preferredSpaceFromSpaces:spaces];
}

+ (int)turnsNeededToReproduce {
    return 8;
}

@end
