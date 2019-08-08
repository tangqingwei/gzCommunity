//
//  DetailViewController.m
//  gzCommunity
//
//  Created by qige on 2019/7/31.
//  Copyright © 2019 qige. All rights reserved.
//

#import "DetailViewController.h"
#import "AFNetworkingSchenley.h"
#import "GZParameters.h"
#import "GZDetailTextCell.h"
#import "GZDetailImageCell.h"
#import "GZDetailLinkCell.h"
#import "NSString+Size.h"
#import "SDWebImageManager.h"
#import "GZDetailHeaderView.h"
#import "UIImageView+WebCache.h"
#import "NSString+Date.h"

@interface DetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *contentArray;
@property (nonatomic, strong) NSMutableDictionary *imageSizeDic;
@property (nonatomic, strong) GZDetailHeaderView *headerView;

@end

@implementation DetailViewController

- (NSMutableDictionary *)imageSizeDic{
    if (_imageSizeDic == nil) {
        _imageSizeDic = [NSMutableDictionary dictionary];
    }
    return _imageSizeDic;
}

- (GZDetailHeaderView *)headerView{
    if (_headerView == nil) {
        _headerView = [[GZDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 100)];
    }
    return _headerView;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        //TODO
        NAVIGATION_HEIGHT;
        SAFE_HEIGHT;
        CGFloat x = 0.0;
        CGFloat y = 0.0;
        CGFloat w = WIDTH;
        CGFloat h = safe_height - y;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(x, y, w, h) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.tableHeaderView = self.headerView;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.navigationItem.title = self.boardName;
    
    [self.view addSubview:self.tableView];
    [self createData];
}


- (void)createData{
    //http://www.guanzhuangwang.com/mobcent/app/web/index.php?r=forum/postlist
    //http://www.guanzhuangwang.com/mobcent/app/web/index.php?r=forum/postlist
    NSMutableDictionary *parameters = [NSMutableDictionary parameters];
    parameters[@"topicId"]=self.topicId;
    parameters[@"boardId"]=self.boardId;
    parameters[@"order"] = @0;
    [[AFNetworkingSchenley sharedInstance] requestWithPOST:REQUEST_URL(@"/mobcent/app/web/index.php?r=forum/postlist") parameters:parameters success:^(NSData *responseObject) {
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",rootDic);
        self.headerView.titleLabel.text = rootDic[@"topic"][@"title"];
        [self.headerView.iconView sd_setImageWithURL:[NSURL URLWithString:rootDic[@"topic"][@"icon"]]];
        self.headerView.userNickNameLabel.text = rootDic[@"topic"][@"user_nick_name"];
        self.headerView.dateLabel.text = [NSString dateStringWithSecondNumber:rootDic[@"topic"][@"create_date"]];
        self.contentArray = rootDic[@"topic"][@"content"];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)downImageWithUrlStr:(NSString *)urlStr image:(void (^) (UIImage *image))completeImage{
    [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:urlStr] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        completeImage(image);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contentArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.contentArray[indexPath.row];
    if ([dic[@"type"] integerValue] == 0) {
        GZDetailTextCell *cell = [[GZDetailTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"aaa"];
        cell.contentLabel.text = dic[@"infor"];
        return cell;
    }else if ([dic[@"type"] integerValue] == 1){
        GZDetailImageCell *cell = [[GZDetailImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"bbb"];
        [self downImageWithUrlStr:dic[@"originalInfo"] image:^(UIImage *image) {
            cell.contentImageView.image = image;
            CGFloat imageWidth = WIDTH - 16.0;
            CGFloat imageHeight = imageWidth * image.size.height / image.size.width;
            CGSize imageSize = CGSizeMake(imageWidth, imageHeight);
            cell.imageSize = imageSize;
            self.imageSizeDic[indexPath] = [NSValue valueWithCGSize:imageSize];
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
        return cell;
    }else if ([dic[@"type"] integerValue] == 4){
        GZDetailLinkCell *cell = [[GZDetailLinkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ccc"];
        NSString *text = dic[@"infor"];
        NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:text attributes:attribtDic];
        [cell.linkLabel setAttributedText:attribtStr];
        return cell;
    }else {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ddd"];
        return cell;
    }
    return nil;
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.contentArray[indexPath.row];
    if ([dic[@"type"] integerValue] == 0) {
        CGFloat height = [dic[@"infor"] lineBreak_calculateRowHeightWithWidth:WIDTH-16.0 fontSize:14.0];
        return height;
    }else if ([dic[@"type"] integerValue] == 1){
        if (self.imageSizeDic[indexPath] == nil) {
            return 10.0;
        }else{
            NSValue *sizeValue = self.imageSizeDic[indexPath];
            CGSize size = [sizeValue CGSizeValue];
            return size.height + 16.0;
        }
    }else if ([dic[@"type"] integerValue] == 4){
        CGFloat height = [dic[@"infor"] lineBreak_calculateRowHeightWithWidth:WIDTH-16.0 fontSize:14.0];
        return height;
    }
    return 1.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
