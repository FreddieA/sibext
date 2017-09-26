//
//  NSObject+Count.m
//  SeaWorldThunderDome
//
//  Created by mkirillov on 26/09/2017.
//  Copyright © 2017 freddie-ink. All rights reserved.
//

#import "NSObject+Count.h"

@implementation NSObject (Count)

+ (NSArray *)objectsWithCount:(NSUInteger)count {
    NSMutableArray *array = [NSMutableArray new];
    for (int i = 0; i < count; i++) {
        [array addObject:[self.class new]];
    }
    return array;
}

@end
