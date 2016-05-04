//
//  ViewController.m
//  医院查询Demo
//
//  Created by 孙云 on 16/5/4.
//  Copyright © 2016年 haidai. All rights reserved.
//44eb960a021748030089922315fcea41

#import "WXNewsViewController.h"
#import "NSObject+Network.h"
#import "WXModel.h"
#import "WXCell.h"
#import "HtmlViewController.h"
static NSString * const WXCELL = @"WXCell";
@interface WXNewsViewController ()
@property(nonatomic,strong)NSMutableArray *dataAarray;
@property(nonatomic,strong)FootView *footView;
@property(nonatomic,assign)int count;
@end

@implementation WXNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataAarray = [NSMutableArray array];
    //加载表
    [self initTableView];
    [self loadData];
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  数据请求
 */
- (void)loadData{
    
    __weak typeof(self)weakSelf = self;
    NSString *str;
    if (_count == 0) {
        
        str = @"http://v.juhe.cn/weixin/query?key=307e9177267c4350603fd3041725e8b9";
    }else{
    
        str = [NSString stringWithFormat:@"http://v.juhe.cn/weixin/query?key=307e9177267c4350603fd3041725e8b9&pno=%i",_count];
    }
    [self PostHttp:str Result:^(id respond, id Error) {
        if (respond) {
            if (weakSelf.count == 0) {
                weakSelf.dataAarray = [NSMutableArray array];
            }
            //获取需要的内容
            NSArray *contentsArray = respond[@"result"][@"list"];
            //转换为model
            for (NSDictionary *dic in contentsArray) {
                WXModel *wx = [[WXModel alloc]initWithWXdic:dic];
                [weakSelf.dataAarray addObject:wx];
            }
            [weakSelf.tableView reloadData];
            weakSelf.footView.refreshBtn.hidden = NO;
            [weakSelf.footView.activeView stopAnimating];
        }else{
        
            NSLog(@"%@",Error);
        }
       
    }];

    
}

- (void)initTableView{

    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //表尾
    _footView = [[FootView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    __weak typeof(self)weakSelf = self;
    _footView.refreshBlock = ^{
        [weakSelf loadData];
        weakSelf.count ++;
    };
    self.tableView.tableFooterView = _footView;
    [self.view addSubview:_tableView];
}
#pragma mark-- 表的代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataAarray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * const ID = @"cell";
    WXCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WXCell alloc]initWithStyle:0 reuseIdentifier:ID];
    }
    cell.model = self.dataAarray[indexPath.row];
    return cell;
}
/**
 *  行高
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 *
 *  @return <#return value description#>
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    WXModel *model = self.dataAarray[indexPath.row];
    return [WXCell cellHeightFromWxModel:model];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    WXModel *model = self.dataAarray[indexPath.row];
    HtmlViewController *htmlVC = [[HtmlViewController alloc]init];
    htmlVC.urlString = model.url;
    [self.navigationController pushViewController:htmlVC animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    float offsety = _tableView.contentOffset.y;
    if (offsety < -200.00){
        //刷新数据
        _count = 0;
        [self loadData];
    }
}

@end


/**************************底部视图***********************************/
@implementation FootView

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame: frame];
    if (self) {
        //加载按钮和菊花
        [self initBtn];
        [self initActiveView];
    }
    return self;
}
- (void)initBtn{

    _refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _refreshBtn.frame = CGRectMake(self.frame.size.width / 2 - 50,0, 100, 20);
    _refreshBtn.layer.masksToBounds = YES;
    _refreshBtn.layer.cornerRadius = 5;
    _refreshBtn.layer.borderWidth = 1;
    _refreshBtn.layer.borderColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.831608952702703].CGColor;
    [self.refreshBtn setTitle:@"点击加载数据" forState:UIControlStateNormal];
    [_refreshBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _refreshBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_refreshBtn addTarget:self action:@selector(refreshIng) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_refreshBtn];
}
/**
 *  加载活动图
 */
- (void)initActiveView{

    _activeView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    _activeView.center = self.center;
    _activeView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self addSubview:_activeView];
}
/**
 *  按钮事件
 */
- (void)refreshIng{

    //按钮隐藏
    self.refreshBtn.hidden = YES;
    [self.activeView startAnimating];
    if(self.refreshBlock){
    
        self.refreshBlock();
    }
}
@end
