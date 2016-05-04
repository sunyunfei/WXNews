//
//  WXModel.h
//  医院查询Demo
//
//  Created by 孙云 on 16/5/4.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXModel : NSObject
//图片
@property(nonatomic,copy)NSString *firstImg;
//id
@property(nonatomic,copy)NSString *Id;
//来源
@property(nonatomic,copy)NSString *source;
//标题
@property(nonatomic,copy)NSString *title;
//网页
@property(nonatomic,copy)NSString *url;
//获取数据 
- (instancetype)initWithWXdic:(NSDictionary *)dic;
@end
