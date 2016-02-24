
//
//  RequestDelegate.h
//  afnet
//
//  Created by xuliying on 16/2/22.
//  Copyright © 2016年 xly. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Request;
@protocol RequestDelegate <NSObject>
@optional
- (void)requestDidFinishLoading:(NSDictionary*)returnData;

- (void)requestdidFailWithError:(NSError*)error;

- (void)requestWillDealloc:(Request*)request;

@end