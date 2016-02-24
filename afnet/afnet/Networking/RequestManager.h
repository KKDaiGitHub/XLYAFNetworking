//
//  RequestManager.h
//  afnet
//
//  Created by xuliying on 16/2/22.
//  Copyright © 2016年 xly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestDefine.h"
#import "RequestDelegate.h"
#import <UIKit/UIKit.h>
@interface RequestManager : NSObject

+(instancetype)sharedInstance;

+ (Request *)getRequstWithURL:(NSString*)url
                  params:(NSMutableDictionary*)paramsDict
            successBlock:(RequestSucBlock)successBlock
            failureBlock:(RequestFailBlock)failureBlock
                 showHUD:(UIView *)showHUDView;
+ (Request *)getRequstWithURL:(NSString*)url
                  params:(NSMutableDictionary*)paramsDict
                delegate:(id<RequestDelegate>)delegate
                 showHUD:(UIView *)showHUDView;
+ (Request *)getRequstWithURL:(NSString*)url
                  params:(NSMutableDictionary*)paramsDict
                  target:(id)target
                  action:(SEL)action
                 showHUD:(UIView *)showHUDView;

/********************************************************************************************************/

+ (Request *)postRequstWithURL:(NSString*)url
                  params:(NSMutableDictionary*)paramsDict
            successBlock:(RequestSucBlock)successBlock
            failureBlock:(RequestFailBlock)failureBlock
                 showHUD:(UIView *)showHUDView;
+ (Request *)postRequstWithURL:(NSString*)url
                  params:(NSMutableDictionary*)paramsDict
                delegate:(id<RequestDelegate>)delegate
                 showHUD:(UIView *)showHUDView;
+ (Request *)postRequstWithURL:(NSString*)url
                  params:(NSMutableDictionary*)paramsDict
                  target:(id)target
                  action:(SEL)action
                 showHUD:(UIView *)showHUDView;
@end
