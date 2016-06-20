//
//  NSXMLParserToDictionary.m
//  NSXMLParser
//
//  Created by 宋旭 on 16/4/18.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "NSXMLParserToDictionary.h"

@implementation NSXMLParserToDictionary

- (void)startParser:(NSString *)fileName {
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"xml"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    parser.delegate = self;
    [parser parse];
}

#pragma mark NSXMLParserDelegate Methods
- (void)parserDidStartDocument:(NSXMLParser *)parser {
    _contentArray = [NSMutableArray new];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"%@", parseError);
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    
    _currentTagName = elementName;
    if ([_currentTagName isEqualToString:@"Day"]) {
        NSString *id = [attributeDict objectForKey:@"id"];
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:id forKey:@"id"];
        [_contentArray addObject:dict];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([string isEqualToString:@" "]) {
        return;
    }
    
    NSMutableDictionary *dict = [_contentArray lastObject];
    
    if ([_currentTagName isEqualToString:@"time"] && dict) {
        [dict setObject:string forKey:@"time"];
    }
    
    if ([_currentTagName isEqualToString:@"activity"] && dict) {
        string = [string stringByRemovingPercentEncoding];
        [dict setObject:string forKey:@"activity"];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    self.currentTagName = nil;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    self.block(self.contentArray);
    self.contentArray = nil;
}

@end
