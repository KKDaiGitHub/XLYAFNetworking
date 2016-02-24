//
//  RequestManager.m
//  afnet
//
//  Created by xuliying on 16/2/22.
//  Copyright © 2016年 xly. All rights reserved.
//

#import "RequestManager.h"
#import "RequestHandler.h"
@implementation RequestManager
+(instancetype)sharedInstance{
    static RequestManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[RequestManager alloc] init];
    });
    return manager;
}
+(Request *)getRequstWithURL:(NSString *)url params:(NSDictionary *)paramsDict successBlock:(RequestSucBlock)successBlock failureBlock:(RequestFailBlock)failureBlock showHUD:(UIView *)showHUDView{
   return  [[RequestHandler sharedInstance] requestWithURL:url requestMethod:Get params:[NSMutableDictionary dictionaryWithDictionary:paramsDict] delegate:nil showHUD:showHUDView target:nil action:nil successBlock:successBlock failureBlock:failureBlock];
}
+(Request *)getRequstWithURL:(NSString *)url params:(NSDictionary *)paramsDict delegate:(id<RequestDelegate>)delegate showHUD:(UIView *)showHUDView{
  return   [[RequestHandler sharedInstance] requestWithURL:url requestMethod:Get params:[NSMutableDictionary dictionaryWithDictionary:paramsDict] delegate:delegate showHUD:showHUDView target:nil action:nil successBlock:nil failureBlock:nil];
}
+(Request *)getRequstWithURL:(NSString *)url params:(NSDictionary *)paramsDict target:(id)target action:(SEL)action showHUD:(UIView *)showHUDView{
   return  [[RequestHandler sharedInstance] requestWithURL:url requestMethod:Get params:[NSMutableDictionary dictionaryWithDictionary:paramsDict] delegate:nil showHUD:showHUDView target:target action:action successBlock:nil failureBlock:nil];
}


+(Request *)postRequstWithURL:(NSString *)url params:(NSDictionary *)paramsDict successBlock:(RequestSucBlock)successBlock failureBlock:(RequestFailBlock)failureBlock showHUD:(UIView *)showHUDView{
    return [[RequestHandler sharedInstance] requestWithURL:url requestMethod:Post params:[NSMutableDictionary dictionaryWithDictionary:paramsDict] delegate:nil showHUD:showHUDView target:nil action:nil successBlock:successBlock failureBlock:failureBlock];
}
+(Request *)postRequstWithURL:(NSString *)url params:(NSDictionary *)paramsDict delegate:(id<RequestDelegate>)delegate showHUD:(UIView *)showHUDView{
   return  [[RequestHandler sharedInstance] requestWithURL:url requestMethod:Post params:[NSMutableDictionary dictionaryWithDictionary:paramsDict] delegate:delegate showHUD:showHUDView target:nil action:nil successBlock:nil failureBlock:nil];
}
+(Request *)postRequstWithURL:(NSString *)url params:(NSDictionary *)paramsDict target:(id)target action:(SEL)action showHUD:(UIView *)showHUDView{
   return  [[RequestHandler sharedInstance] requestWithURL:url requestMethod:Post params:[NSMutableDictionary dictionaryWithDictionary:paramsDict] delegate:nil showHUD:showHUDView target:target action:action successBlock:nil failureBlock:nil];
}
@end
