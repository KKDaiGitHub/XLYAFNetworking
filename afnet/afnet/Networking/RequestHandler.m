//
//  RequestHandler.m
//  afnet
//
//  Created by xuliying on 16/2/22.
//  Copyright © 2016年 xly. All rights reserved.
//

#import "RequestHandler.h"
#import "AFNetworking.h"
#import "NSDictionary+Addtion.h"
#import "AFNetworkActivityIndicatorManager.h"
@implementation RequestHandler
+(RequestHandler *)sharedInstance{
    static RequestHandler *handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[RequestHandler alloc] init];
    });
    return handler;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.networkError = NO;
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        self.manager = [AFHTTPSessionManager manager];
        self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return self;
}
-(Request *)requestWithURL:(NSString *)url requestMethod:(RequestMethod)method params:(NSMutableDictionary *)params delegate:(id)delegate showHUD:(UIView *)showHUDView target:(id)target action:(SEL)action successBlock:(RequestSucBlock)successBlock failureBlock:(RequestFailBlock)failureBlock{
    if (method == Get) {
        if (self.requestItems[url]) {
            return self.requestItems[url];
        }
    }else{
        NSString *urlStr = [url stringByAppendingString:[params keyValueString]];
        if (self.requestItems[urlStr]) {
            NSLog(@"请求已存在");
            return self.requestItems[urlStr];
        }
    }
    self.request = [[Request alloc] initWithUrl:url requestMethod:method params:params delegate:self target:target action:action showHUD:showHUDView successBlock:successBlock failureBlock:failureBlock];
    self.request.delegate = self;
    [self.requestItems setObject:self.request forKey:self.request.url];
    return self.request;
}
-(NSMutableDictionary *)requestItems
{
    if (!_requestItems) {
        _requestItems = [NSMutableDictionary dictionary];
    }
    return _requestItems;
}
+ (void)cancelAllRequest
{
    RequestHandler *handler = [RequestHandler sharedInstance];
    for (Request *req in handler.requestItems.allValues) {
        [req.task cancel];
    }
    [handler.requestItems removeAllObjects];
    handler.request = nil;
}
+(void)cancelRequest:(Request *)request{
    RequestHandler *handler = [RequestHandler sharedInstance];
    if (handler.requestItems[request.url]) {
        [[handler.requestItems[request.url] task] cancel];
        [handler.requestItems removeObjectForKey:request.url];
    }
    if (request == handler.request) {
        handler.request = nil;
    }
}
- (void)requestWillDealloc:(Request *)request
{
    [self.requestItems removeObjectForKey:request.url];
    if (self.request == request) {
        self.request = nil;
    }
}
+(void)startMonitoring{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"unkonw");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无法连接");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi");
                break;
                
            default:
                break;
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}
@end
