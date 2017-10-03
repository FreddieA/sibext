//
//  NSIndexPath+Array.m
//  SeaWorldThunderDome
//
//  Created by mkirillov on 03/10/2017.
//  Copyright © 2017 freddie-ink. All rights reserved.
//

#import "NSIndexPath+Array.h"
#import <UIKit/NSIndexPath+UIKitAdditions.h>

@implementation NSIndexPath (Array)

+ (NSArray *)indexPathsFromIndexesArray:(NSArray<NSNumber *> *)array {
    NSMutableArray *indexPathsArray = [NSMutableArray array];
    for(NSNumber *index in array) {
        [indexPathsArray addObject:[NSIndexPath indexPathForItem:index.unsignedIntegerValue inSection:0]];
    }
    return indexPathsArray;
}

@end
