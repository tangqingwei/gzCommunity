//
//  InfoView.m
//  gzCommunity
//
//  Created by qige on 2019/8/12.
//  Copyright © 2019 qige. All rights reserved.
//

#import "InfoView.h"
#import "GZAttentionCell.h"

@interface InfoView()<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, weak) UILabel *attentionLabel;
@property (nonatomic, weak) UITableView *tableView;

@end


@implementation InfoView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.layer.masksToBounds = YES;
        [self addSubview:iconView];
        _iconView = iconView;
        
        UILabel *unLabel = [[UILabel alloc] init];
        unLabel.font = [UIFont systemFontOfSize:14.0];
        unLabel.textAlignment = NSTextAlignmentCenter;
//        unLabel.text = @"用户名";
        [self addSubview:unLabel];
        _unLabel = unLabel;
        
        UILabel *attentionLabel = [[UILabel alloc] init];
        attentionLabel.font = [UIFont systemFontOfSize:14.0];
        attentionLabel.text = @"我的关注";
        [self addSubview:attentionLabel];
        _attentionLabel = attentionLabel;
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:tableView];
        _tableView = tableView;
//        UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        logoutButton.backgroundColor = UIColor.redColor;
//        [logoutButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
//        [logoutButton setTitle:@"退出" forState:UIControlStateNormal];
//        [logoutButton addTarget:self action:@selector(logoutButtonClkick) forControlEvents:UIControlEventTouchUpInside];
//        logoutButton.layer.cornerRadius = 4.0f;
//        logoutButton.layer.masksToBounds = YES;
//        [self addSubview:logoutButton];
//        _logoutButton = logoutButton;
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    CGFloat iW = autoXY(64.0);
    CGFloat iH = iW;
    CGFloat iX = (width - iW) * 0.5;
    CGFloat iY = 24.0;
    self.iconView.frame = CGRectMake(iX, iY, iW, iH);
    self.iconView.layer.cornerRadius = iW * 0.5;
    
    CGFloat unlX = 0.0;
    CGFloat unlY = CGRectGetMaxY(self.iconView.frame);
    CGFloat unlW = width;
    CGFloat unlH = 32.0;
    self.unLabel.frame = CGRectMake(unlX, unlY, unlW, unlH);
    
    CGFloat alX = 12.0;
    CGFloat alY = CGRectGetMaxY(self.unLabel.frame) + 8.0;
    CGFloat alW = 100;
    CGFloat alH = 24.0;
    self.attentionLabel.frame = CGRectMake(alX, alY, alW, alH);
    
    CGFloat tX = 0.0;
    CGFloat tY = CGRectGetMaxY(self.attentionLabel.frame);
    CGFloat tW = width;
    CGFloat tH = height - tY;
    self.tableView.frame = CGRectMake(tX, tY, tW, tH);
    
//    CGFloat lbX = 24.0;
//    CGFloat lbY = height * 0.5;
//    CGFloat lbW = width - lbX * 2;
//    CGFloat lbH = 46.0;
//    self.logoutButton.frame = CGRectMake(lbX, lbY, lbW, lbH);
}

- (void)logoutButtonClkick{
    if ([self.delegate respondsToSelector:@selector(infoViewLogoutButtonEvent)]) {
        [self.delegate infoViewLogoutButtonEvent];
    }
}


- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self.tableView reloadData];
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
    GZAttentionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[GZAttentionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.dataDic = self.dataArray[indexPath.row];
    cell.cancelBlock = ^{
        if ([self.delegate respondsToSelector:@selector(infoViewDeSelectedIndexPath:)]) {
            [self.delegate infoViewDeSelectedIndexPath:indexPath];
        }
    };
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
    return 96.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
