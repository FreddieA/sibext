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
#import "NSArray+Random.h"
#import "NSIndexPath+Array.h"

const int kItemsCount = 150;
const int kItemsPerRow = 10;

@interface CageViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UISwitch *autoSwitch;

@property (nonatomic, strong) WorldEngine *engine;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation CageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_collectionView registerNib:[UINib nibWithNibName:CreatureViewCell.tableReuseIdentifier
                                                bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:CreatureViewCell.tableReuseIdentifier];
    [self reloadDataSource];
}

- (void)reloadDataSource {
    _engine = [[WorldEngine alloc] initWithItemsPerRow:kItemsPerRow itemsCount:kItemsCount];
    [_engine runCycleWithCompletion:nil];
    [_collectionView reloadData];
}

- (void)autoPlay:(NSTimer *)timer {
    [_engine runCycleWithCompletion:^(NSArray *changedSpaces){
        [_collectionView reloadItemsAtIndexPaths:[NSIndexPath indexPathsFromIndexesArray:changedSpaces]];
        //[_collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    }];
}

#pragma mark Actions

- (IBAction)autoPlayAction:(UISwitch *)sender {
    if (sender.on) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(autoPlay:) userInfo:nil repeats:YES];
    } else {
        [_timer invalidate];
        _timer = nil;
    }
}

- (IBAction)resetAction:(id)sender {
    if (_timer) {
        [_timer invalidate];
        _autoSwitch.on = NO;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self reloadDataSource];
    });
}

#pragma mark UICollectionView methods

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CreatureViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CreatureViewCell.tableReuseIdentifier forIndexPath:indexPath];
    cell.space = _engine.spaces[indexPath.item];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _engine.spaces.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    float width = floorf(collectionView.bounds.size.width / kItemsPerRow);
    return CGSizeMake(width, width);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [_engine runCycleWithCompletion:^(NSArray *changedSpaces){
        //[_collectionView reloadItemsAtIndexPaths:[NSIndexPath indexPathsFromIndexesArray:changedSpaces]];
        [_collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    }];
}

#pragma mark dealoc

- (void)dealloc {
    [_timer invalidate];
    _timer = nil;
}

@end
