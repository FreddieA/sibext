//
//  CreatureViewCell.m
//  SeaWorldThunderDome
//
//  Created by mkirillov on 27/09/2017.
//  Copyright © 2017 freddie-ink. All rights reserved.
//

#import "CreatureViewCell.h"
#import "Space.h"
#import "Creature.h"

@interface CreatureViewCell ()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end

@implementation CreatureViewCell

- (void)setSpace:(Space *)space {
    _space = space;
    _imageView.image = [UIImage imageNamed:_space.imageName];
}

+ (NSString *)tableReuseIdentifier {
    return NSStringFromClass(self.class);
}

@end
