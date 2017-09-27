//
//  ViewController.m
//  SeaWorldThunderDome
//
//  Created by mkirillov on 25/09/2017.
//  Copyright © 2017 freddie-ink. All rights reserved.
//

#import "CageViewController.h"
#import "CreatureViewCell.h"
#import "WorldEngine.h"

@interface CageViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) WorldEngine *engine;

@end

@implementation CageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"CreatureViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CreatureViewCell"];
    
    _engine = [[WorldEngine alloc] initWithItemsPerRow:10 itemsCount:150];
    [_collectionView reloadData];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CreatureViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CreatureViewCell" forIndexPath:indexPath];
    cell.space = _engine.spaces[indexPath.item];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _engine.spaces.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    float width = floorf(collectionView.bounds.size.width / 10);
    return CGSizeMake(width, width);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [_engine runCycleWithCompletion:^{
        [_collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    }];
}

@end
