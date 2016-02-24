//
//  RequestDefine.h
//  afnet
//
//  Created by xuliying on 16/2/22.
//  Copyright © 2016年 xly. All rights reserved.
//

#ifndef RequestDefine_h
#define RequestDefine_h

typedef enum {
    Get = 1,
    Post
} RequestMethod;

typedef void (^RequestSucBlock)(NSDictionary *returnData);
typedef void (^RequestFailBlock)(NSError *error);


#endif /* RequestDefine_h */
