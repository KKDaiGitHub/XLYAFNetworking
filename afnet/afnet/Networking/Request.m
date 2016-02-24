//
//  Request.m
//  afnet
//
//  Created by xuliying on 16/2/22.
//  Copyright © 2016年 xly. All rights reserved.
//

#import "Request.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "NSDictionary+Addtion.h"
#import "RequestHandler.h"
@implementation Request

-(Request *)initWithUrl:(NSString *)url requestMethod:(RequestMethod)method params:(NSMutableDictionary *)params delegate:(id)delegate target:(id)target action:(SEL)action showHUD:(UIView *)view successBlock:(RequestSucBlock)successBlock failureBlock:(RequestFailBlock)failureBlock{
    if (self = [super init]) {
        self.requestMethod = method;
        self.params = params;
        self.delegate = delegate;
        self.target = self;
        self.action = action;
        if (params && [params isKindOfClass:[NSDictionary class]]) {
            self.url = [url stringByAppendingString:[params keyValueString]];
        }else{
            self.url = url;
        }
        if (view) {
            [MBProgressHUD showHUDAddedTo:view animated:YES];
        }
        __weak typeof(self)weakSelf = self;
        
        NSLog(@"%d",[NSThread isMainThread]);

        AFHTTPSessionManager *manager = [RequestHandler sharedInstance].manager;
        
        if (method == Get) {
         self.task = [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [MBProgressHUD hideHUDForView:view animated:YES];
             id result = [weakSelf jsonParseWithData:responseObject];
                if (successBlock) {
                    successBlock(result);
                }
                if ([weakSelf.delegate respondsToSelector:@selector(requestDidFinishLoading:)]) {
                    [weakSelf.delegate requestDidFinishLoading:result];
                }
                [weakSelf performSelector:@selector(finishedRequest: didFaild:) withObject:result withObject:nil];
                [weakSelf removewItem];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failureBlock) {
                    failureBlock(error);
                }
                if ([weakSelf.delegate respondsToSelector:@selector(requestdidFailWithError:)]) {
                    [weakSelf.delegate requestdidFailWithError:error];
                }
                [weakSelf performSelector:@selector(finishedRequest: didFaild:) withObject:nil withObject:error];
                [weakSelf removewItem];
            }];
        }else{
          self.task =  [manager POST:url parameters:params constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [MBProgressHUD hideHUDForView:view animated:YES];
                id result =   [weakSelf jsonParseWithData:responseObject];
                if (successBlock) {
                    successBlock(result);
                }
                if ([weakSelf.delegate respondsToSelector:@selector(requestDidFinishLoading:)]) {
                    [weakSelf.delegate requestDidFinishLoading:result];
                }
                [weakSelf performSelector:@selector(finishedRequest: didFaild:) withObject:result withObject:nil];
                [weakSelf removewItem];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [MBProgressHUD hideAllHUDsForView:view animated:YES];
                if (failureBlock) {
                    failureBlock(error);
                }
                if ([weakSelf.delegate respondsToSelector:@selector(requestdidFailWithError:)]) {
                    [weakSelf.delegate requestdidFailWithError:error];
                }
                [weakSelf performSelector:@selector(finishedRequest: didFaild:) withObject:nil withObject:error];
                [weakSelf removewItem];
            }];
            
        }
    }
    return self;
}
-(id)jsonParseWithData:(NSData *)data{
    id result=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    if ([result isKindOfClass:[NSDictionary class]]) {
        self.dataDict=result;
    }else{
        if ([result isKindOfClass:[NSArray class]]) {
            self.dataArray=result;
        }else{
            self.dataImage=[UIImage imageWithData:data];
        }
    }
    return  result;
}
- (void)removewItem
{
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([weakSelf.delegate respondsToSelector:@selector(requestWillDealloc:)]) {
            [weakSelf.delegate requestWillDealloc:weakSelf];
        }
    });
}
- (void)finishedRequest:(id)data didFaild:(NSError*)error
{
    if ([self.target respondsToSelector:self.action]) {
        [self.target performSelector:@selector(finishedRequest:didFaild:) withObject:data withObject:error];
    }
}
-(BOOL)isRunning{
    return self.task.state == NSURLSessionTaskStateRunning;
}
-(BOOL)isCanceling{
    return self.task.state == NSURLSessionTaskStateCanceling;
}
-(BOOL)isSuspended{
    return self.task.state == NSURLSessionTaskStateSuspended;
}
-(BOOL)isCompleted{
    return self.task.state == NSURLSessionTaskStateCompleted;
}
@end
