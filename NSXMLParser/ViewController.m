//
//  ViewController.m
//  NSXMLParser
//
//  Created by 宋旭 on 16/4/17.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "ViewController.h"
#import "NSXMLParserToDictionary.h"

@interface ViewController ()

@property(nonatomic, strong) NSMutableArray *array;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSXMLParserToDictionary *parser = [NSXMLParserToDictionary new];
    
    parser.block = ^(NSMutableArray *array) {
        self.array = array;
    };
    
    [parser startParser:@"data"];
    
    if (_array.count > 0) {
        [_array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                NSLog(@"%@: %@",key,obj);
            }];
        }];
    }
}

@end
