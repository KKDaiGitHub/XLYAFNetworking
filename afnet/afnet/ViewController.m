//
//  ViewController.m
//  afnet
//
//  Created by xuliying on 16/2/22.
//  Copyright © 2016年 xly. All rights reserved.
//

#import "ViewController.h"
#import "RequestManager.h"
#import "RequestHandler.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    static int i = 10;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@1,@"pageNO",@(i),@"pageSize", nil];
   Request * re = [RequestManager postRequstWithURL:@"http://203.166.163.162/app/bid/dingqibao.do" params:dict successBlock:^(NSDictionary *returnData) {
       NSLog(@"%@",returnData);
        NSLog(@"成功");
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    } showHUD:self.view];
    
    static BOOL ret = YES;
    if (ret) {
        [RequestHandler cancelRequest:re];

    }
    i++;
    ret = !ret;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
