//
//  CommunityViewController.m
//  gzCommunity
//
//  Created by qige on 2019/7/31.
//  Copyright © 2019 qige. All rights reserved.
//

#import "CommunityViewController.h"
#import "CommunityCell.h"
#import "GZCommunityViewModel.h"
#import "GZCommunityModel.h"
#import "CommunityListViewController.h"
#import "UIButton+Reload.h"

@interface CommunityViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) GZCommunityViewModel *viewModel;
@property (nonatomic, strong) UIButton *reloadButton;

@end

@implementation CommunityViewController

static NSString *const identifier = @"community_cell";

- (GZCommunityViewModel *)viewModel{
    if (_viewModel == nil) {
        _viewModel = [[GZCommunityViewModel alloc] init];
    }
    return _viewModel;
}

- (UIButton *)reloadButton{
    if (_reloadButton == nil) {
        _reloadButton = [UIButton reloadButton];
        _reloadButton.center = self.view.center;
        [_reloadButton addTarget:self action:@selector(reloadButtonClick:) forControlEvents:UIControlEventTouchDown];
    }
    return _reloadButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.groupTableViewBackgroundColor;
    self.navigationItem.title = @"分类";
    
    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    collectionViewFlowLayout.minimumLineSpacing = 2.0;
    collectionViewFlowLayout.minimumInteritemSpacing = 2.0;
    collectionViewFlowLayout.headerReferenceSize = CGSizeMake(0, 0);
    SAFE_HEIGHT;
    NAVIGATION_HEIGHT;
    CGFloat collectionX = 0.0;
    CGFloat collectionY = 0.0;
    CGFloat collectionW = WIDTH;
    CGFloat collectionH = safe_height - collectionY;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(collectionX, collectionY, collectionW, collectionH) collectionViewLayout:collectionViewFlowLayout];
    collectionView.backgroundColor = UIColor.clearColor;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerClass:CommunityCell.class forCellWithReuseIdentifier:identifier];
    [self.view addSubview:collectionView];
    _collectionView = collectionView;
    
    
    [self createData];
}

- (void)createData{
    __weak typeof(self) weakSelf = self;
    [self.viewModel createDataWithResult:^(id  _Nonnull value) {
        if (weakSelf.reloadButton.superview != nil) {
            [weakSelf.reloadButton removeFromSuperview];
        }
        weakSelf.dataArray = value;
        [weakSelf.collectionView reloadData];
    } failure:^(NSError * _Nonnull error) {
        if (weakSelf.reloadButton.superview == nil) {
            [weakSelf.view addSubview:weakSelf.reloadButton];
        }
    }];
}

- (void)reloadButtonClick:(UIButton *)button{
    [self.reloadButton removeFromSuperview];
    [self createData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CommunityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    GZCommunityModel *model = self.dataArray[indexPath.row];
    cell.titleLabel.text = model.boardName;
    if ([model.boardContent isEqual:@1]) {
        cell.dateLabel.text = model.lastPostsDate;
    }else{
        cell.dateLabel.text = @"暂无内容";
    }
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    GZCommunityModel *model = self.dataArray[indexPath.row];
    CommunityListViewController *vc = [[CommunityListViewController alloc] init];
    vc.boardId = model.boardId;
    vc.boardName = model.boardName;
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((WIDTH - 2.0) * 0.5, WIDTH * 0.25);
}

@end
