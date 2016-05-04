//
//  NSObject+Network.m
//  医院查询Demo
//
//  Created by 孙云 on 16/5/4.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import "NSObject+Network.h"

@implementation NSObject (Network)
/**
 *   post请求
 *
 *  @param httpStr     接口
 *  @param resultBlock 返回的数据
 */
- (void)PostHttp:(NSString *)httpStr Result:(void(^)(id respond,id Error))resultBlock{
    
    //接口转换为url
    NSURL *url = [NSURL URLWithString:httpStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //加载接口
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //如果有问题
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if (error) {
                //主线程操作
                dispatch_async(dispatch_get_main_queue(), ^{
                    resultBlock(nil,error);
                });
            }else{
                //得出数据
                id jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:Nil];
                //主线程操作
                dispatch_async(dispatch_get_main_queue(), ^{
                    resultBlock(jsonData,nil);
                });
            }});
    }];
    //开始请求
    [task resume];
}

- (void)PostHttp:(NSString *)httpStr parameter:(NSDictionary *)parameter Result:(void(^)(id respond,id Error))resultBlock{
    
    NSURL *urls = [NSURL URLWithString:httpStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urls];
    [request setHTTPMethod:@"POST"];
    NSError *error;
    //预防条件为空
    if (parameter == nil) {
        parameter = [NSDictionary dictionary];
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameter
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    [request setHTTPBody:jsonData];
    
    //加载接口
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //如果有问题
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if (error) {
                //主线程操作
                dispatch_async(dispatch_get_main_queue(), ^{
                    resultBlock(nil,error);
                });
            }else{
                //得出数据
                id jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:Nil];
                //主线程操作
                dispatch_async(dispatch_get_main_queue(), ^{
                    resultBlock(jsonData,nil);
                });
            }});
    }];
    //开始请求
    [task resume];
}

@end
