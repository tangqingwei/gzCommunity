//
//  CommunityListViewController.m
//  gzCommunity
//
//  Created by qige on 2019/8/7.
//  Copyright © 2019 qige. All rights reserved.
//

#import "CommunityListViewController.h"
#import "GZCLViewModel.h"
#import "GZTableViewCell.h"
#import "DetailViewController.h"
#import "SVProgressHUD+Schenley.h"

@interface CommunityListViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *rectArray;

@end

@implementation CommunityListViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //http://www.guanzhuangwang.com/mobcent/app/web/index.php?r=forum/topiclistex
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.tableView];
    
    self.navigationItem.title = self.boardName;
    
    GZCLViewModel *viewModel = [[GZCLViewModel alloc] init];
    viewModel.boardId = self.boardId;
    [viewModel createDataWithResult:^(id  _Nonnull value) {
        self.dataArray = value;
        if (self.dataArray.count == 0) {
            [SVProgressHUD schenleyShowInfoWithText:@"暂无内容"];
        }else{
            [self.tableView reloadData];
        }
        
    }];
    
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
    vc.topicId = model.topicId;
    vc.boardId = model.boardId;
    vc.boardName = model.boardName;
    vc.userId = model.userId;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
