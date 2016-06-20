//
//  NSXMLParserToDictionary.h
//  NSXMLParser
//
//  Created by 宋旭 on 16/4/18.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^MyBlock)(NSMutableArray *array);

@interface NSXMLParserToDictionary : NSObject<NSXMLParserDelegate>

@property(nonatomic, strong) NSMutableArray *contentArray;

@property(nonatomic, strong) NSString *currentTagName;

- (void)startParser:(NSString *)fileName;

@property MyBlock block;

@end
