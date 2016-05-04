//
//  NSObject+Network.h
//  医院查询Demo
//
//  Created by 孙云 on 16/5/4.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Network)
- (void)PostHttp:(NSString *)httpStr parameter:(NSDictionary *)parameter Result:(void(^)(id respond,id Error))resultBlock;
- (void)PostHttp:(NSString *)httpStr Result:(void(^)(id respond,id Error))resultBlock;
@end
