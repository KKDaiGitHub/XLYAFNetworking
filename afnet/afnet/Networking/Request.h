//
//  Request.h
//  afnet
//
//  Created by xuliying on 16/2/22.
//  Copyright © 2016年 xly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RequestDefine.h"
#import "RequestDelegate.h"
@interface Request : NSObject

@property(nonatomic,assign) RequestMethod requestMethod;
@property(nonatomic,strong) NSString *url;
@property(nonatomic,strong) NSDictionary *params;
@property(nonatomic,assign) id<RequestDelegate> delegate;
@property(nonatomic,assign) id target;
@property(nonatomic,assign) SEL action;
@property(nonatomic,strong) NSURLSessionDataTask *task;

@property(nonatomic,strong) NSDictionary *dataDict;
@property(nonatomic,strong) NSArray *dataArray;
@property(nonatomic,strong) UIImage* dataImage;


@property(nonatomic,assign,readonly) BOOL isRunning;
@property(nonatomic,assign,readonly) BOOL isSuspended;
@property(nonatomic,assign,readonly) BOOL isCanceling;
@property(nonatomic,assign,readonly) BOOL isCompleted;


-(Request *)initWithUrl:(NSString *)url requestMethod:(RequestMethod)method params:(NSDictionary *)params delegate:(id)delegate target:(id)target action:(SEL)action showHUD:(UIView *)view successBlock:(RequestSucBlock)successBlock failureBlock:(RequestFailBlock)failureBlock;
@end
