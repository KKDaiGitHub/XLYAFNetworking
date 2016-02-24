//
//  RequestHandler.h
//  afnet
//
//  Created by xuliying on 16/2/22.
//  Copyright © 2016年 xly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RequestDefine.h"
#import "Request.h"
@class AFHTTPSessionManager;
@interface RequestHandler : NSObject<RequestDelegate>

@property(nonatomic,strong) NSMutableDictionary *requestItems;
@property(nonatomic,strong) Request *request;
@property(nonatomic,assign)BOOL networkError;
@property(nonatomic,retain) AFHTTPSessionManager *manager;


+(RequestHandler *)sharedInstance;

-(Request *)requestWithURL:(NSString *)url requestMethod:(RequestMethod)method params:(NSMutableDictionary *)params delegate:(id)delegate showHUD:(UIView *)showHUDView target:(id)target action:(SEL)action successBlock:(RequestSucBlock)successBlock failureBlock:(RequestFailBlock)failureBlock;
+ (void)cancelAllRequest;
+(void)cancelRequest:(Request *)request;
+(void)startMonitoring;
@end
