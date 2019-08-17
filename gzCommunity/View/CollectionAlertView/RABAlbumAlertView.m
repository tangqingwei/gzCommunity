//
//  RABAlbumAlertView.m
//  Schenley
//
//  Created by songshushan on 2018/11/19.
//  Copyright © 2018 sqhtech. All rights reserved.
//

#import "RABAlbumAlertView.h"
#import "UIView+Corner.h"
#import "RABClassListCollectionViewCell.h"

@interface RABAlbumAlertView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation RABAlbumAlertView

static CGFloat const itemWidth = 64.0;
static CGFloat const itemHeight = 28.0;
static CGFloat const itemLM = 26.0;
static CGFloat const itemTM = 14.0;
static CGFloat const itemLS = 10.0;

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        collectionViewFlowLayout.minimumLineSpacing = itemLS ;
        collectionViewFlowLayout.minimumInteritemSpacing = 10.0;
        collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(itemTM, itemLM, itemTM, itemLM);
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:collectionViewFlowLayout];
        collectionView.backgroundColor = UIColor.clearColor;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.scrollEnabled = NO;
        collectionView.backgroundColor = UIColor.whiteColor;
        [collectionView registerClass:RABClassListCollectionViewCell.class forCellWithReuseIdentifier:@"aa"];
        [self addSubview:collectionView];
        _collectionView = collectionView;
        
        self.backgroundColor = RGBA(0.0, 0.0, 0.0, 0.2);
    }
    return self;
}


//- (void)layoutSubviews{
//    [super layoutSubviews];
//    self.collectionView.frame = CGRectMake(0, 0, 0, 0);
//    [self.collectionView roundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8.0, 8.0)];
//}

- (void)showWithArray:(NSArray *)array{
    _dataArray = array;
    [self.collectionView reloadData];
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    self.frame = keyWindow.bounds;
    [keyWindow addSubview:self];
    NSInteger numberOfLine = (array.count % 3 == 0) ? (array.count / 3) : (array.count / 3 + 1);
    CGFloat cX = 36.0;
    CGFloat cY = self.frame.size.height;
    CGFloat cW = self.frame.size.width - cX * 2;
    CGFloat cH = (autoXY(itemHeight) + itemLS) * numberOfLine - itemLS + itemTM * 2;
    self.collectionView.frame = CGRectMake(cX, cY, cW, cH);
    [self.collectionView roundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8.0, 8.0)];
    [UIView animateWithDuration:0.25 animations:^{
        SAFE_HEIGHT;
        self.collectionView.y = safe_height - self.collectionView.height;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hide{
    [UIView animateWithDuration:0.25 animations:^{
        self.collectionView.y = self.frame.size.height;
    } completion:^(BOOL finished) {
//        [self.collectionView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hide];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RABClassListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"aa" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [self hide];
    if ([self.delegate respondsToSelector:@selector(albumAlertViewDidSelectItemAtIndexPath:)]) {
        [self.delegate albumAlertViewDidSelectItemAtIndexPath:indexPath];
    }
}



#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(autoXY(itemWidth), autoXY(itemHeight + 1.0));
}


@end
