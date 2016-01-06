//
//  ViewController.h
//  Table
//
//  Created by Guest User on 09/12/15.
//  Copyright (c) 2015 Guest User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate>{

    NSXMLParser *parser;
    NSMutableArray *feeds;
    NSMutableDictionary *item;
    NSMutableString *title;
    NSMutableString *link;
    NSString *element;



}

@property(nonatomic, retain) NSArray *list;

@end

