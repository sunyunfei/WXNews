//
//  WXModel.m
//  医院查询Demo
//
//  Created by 孙云 on 16/5/4.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import "WXModel.h"

@implementation WXModel
/**
 *  数据获取
 *
 *  @param dic <#dic description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithWXdic:(NSDictionary *)dic{

    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
/**
 *  判断是不是有id命名参数
 *
 *  @param value <#value description#>
 *  @param key   <#key description#>
 */
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

    if ([key isEqualToString:@"id"]) {
        self.Id = value;
    }
}
@end
