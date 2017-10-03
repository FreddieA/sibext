//
//  Space.h
//  SeaWorldThunderDome
//
//  Created by mkirillov on 25/09/2017.
//  Copyright © 2017 freddie-ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Creature;

@interface Space : NSObject <NSCopying>

@property (nonatomic, strong) Creature *creature;
@property (nonatomic) int xIndex;
@property (nonatomic) int yIndex;

- (NSString *)imageName;
- (void)refresh;

@end
