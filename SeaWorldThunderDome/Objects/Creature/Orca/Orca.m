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

@interface Orca()

@property (nonatomic) int deathCounter;

@end

@implementation Orca

- (NSString *)imageName {
    return @"orca";
}

- (void)moveToSpace:(Space *)space {
    if ([space.creature isKindOfClass:Penguin.class]) {
        _deathCounter = 0;
    } else {
        _deathCounter ++;
    }
    
    if (!self.dead) {
        [super moveToSpace:space];
    }
}

- (int)turnsNeededToDie {
    return 3;
}

- (BOOL)dead {
    return _deathCounter >= self.turnsNeededToDie;
}

+ (Space *)preferredSpaceFromSpaces:(NSArray *)spaces {
    NSArray *spacesWithFood = [spaces filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(Space *space, NSDictionary *bindings) {
        return [space.creature isKindOfClass:Penguin.class];
    }]];
    if (spacesWithFood.count) {
        return [super preferredSpaceFromSpaces:spacesWithFood];
    }
    return [super preferredSpaceFromSpaces:[spaces filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"creature == nil"]]];
}

+ (int)turnsNeededToReproduce {
    return 8;
}

@end
