//
//  ViewController.h
//  医院查询Demo
//
//  Created by 孙云 on 16/5/4.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXNewsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;

@end

//表的尾部加载
@interface FootView : UIView
@property(nonatomic,strong)UIButton *refreshBtn;
//加载时
@property(nonatomic,strong)UIActivityIndicatorView *activeView;
@property(nonatomic,copy)void(^refreshBlock)();
@end
