//
//  Creature.h
//  SeaWorldThunderDome
//
//  Created by mkirillov on 25/09/2017.
//  Copyright © 2017 freddie-ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Space;

@interface Creature : NSObject <NSCopying>

- (void)moveToSpace:(Space *)space;
- (void)refresh;

- (Space *)space;
- (NSString *)imageName;

- (BOOL)isDead;
- (BOOL)canReproduceInArea:(NSArray *)spaces;
+ (Space *)preferredSpaceFromSpaces:(NSArray *)spaces;

+ (int)turnsNeededToReproduce;

@end
