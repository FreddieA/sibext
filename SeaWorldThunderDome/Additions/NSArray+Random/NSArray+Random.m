//
//  NSArray+Random.m
//  SeaWorldThunderDome
//
//  Created by mkirillov on 3/10/2017.
//  Copyright © 2017 freddie-ink. All rights reserved.
//

#import "NSArray+Random.h"

@implementation NSArray (Random)

static NSInteger randomInt(NSInteger min, NSInteger max) {
    NSInteger result = min + arc4random()%(max-min+1);
    return result;
}


- (id)randomObject {
    return self[randomInt(0, self.count - 1)];
}

@end
