//
//  WXCell.h
//  医院查询Demo
//
//  Created by 孙云 on 16/5/4.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXModel.h"
@interface WXCell : UITableViewCell
@property (nonatomic,strong) UILabel     *titleLabel;//标题
@property (nonatomic,strong) UIImageView *icon;//小图片
@property (nonatomic,strong) UILabel     *sourceLabel;//来源
@property (nonatomic,strong) WXModel     *model;//数据
//单元格高度
+ (CGFloat)cellHeightFromWxModel:(WXModel *)model;
@end
