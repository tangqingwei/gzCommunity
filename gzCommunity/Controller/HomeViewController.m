//
//  HomeViewController.m
//  gzCommunity
//
//  Created by qige on 2019/7/31.
//  Copyright © 2019 qige. All rights reserved.
//

#import "HomeViewController.h"
#import "GZViewModel.h"
#import "GZTableViewCell.h"
#import "GZModelRect.h"
#import "DetailViewController.h"
#import "UIButton+Reload.h"

@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *rectArray;
@property (nonatomic, strong) UIButton *reloadButton;
@property (nonatomic, strong) GZViewModel *viewMoidel;

@end

@implementation HomeViewController

- (UIButton *)reloadButton{
    if (_reloadButton == nil) {
        _reloadButton = [UIButton reloadButton];
        _reloadButton.center = self.view.center;
        [_reloadButton addTarget:self action:@selector(reloadButtonClick:) forControlEvents:UIControlEventTouchDown];
    }
    return _reloadButton;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        SAFE_HEIGHT;
        NAVIGATION_HEIGHT;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, safe_height - navigation_height) style:UITableViewStylePlain];
//        _tableView.backgroundColor = ;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _tableView;
}

- (GZViewModel *)viewMoidel{
    if (_viewMoidel == nil) {
        _viewMoidel = [[GZViewModel alloc] init];
    }
    return _viewMoidel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:self.tableView];
    
    [self createData];
    
}

- (void)createData{
    __weak typeof(self) weakSelf = self;
    [self.viewMoidel createDataWithResult:^(id  _Nonnull value) {
        if (weakSelf.reloadButton.superview != nil) {
            [weakSelf.reloadButton removeFromSuperview];
        }
        weakSelf.dataArray = value;
        [weakSelf.tableView reloadData];
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

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"gz_table_cell";
    GZTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[GZTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    GZModel *model = self.dataArray[indexPath.row];
    cell.modelRect = [[GZModelRect alloc] initWithModel:model];
    cell.model = model;
    return cell;
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    GZModel *model = self.dataArray[indexPath.row];
    return [[GZModelRect alloc] initWithModel:model].height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GZModel *model = self.dataArray[indexPath.row];
    DetailViewController *vc = [[DetailViewController alloc] init];
    vc.topicId = model.sourceId;
    vc.boardId = model.boardId;
    vc.boardName = model.boardName;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
