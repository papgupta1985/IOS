
//  ViewController.m
//  Table
//
//  Created by Guest User on 09/12/15.
//  Copyright (c) 2015 Guest User. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _list=[NSArray arrayWithObjects:@"List 1",@"List 2",@"List 3",@"List 4", nil];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"news" withExtension:@"xml"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    feeds=[[NSMutableArray alloc] init];
    parser= [[NSXMLParser alloc] initWithData:data];
    
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
    
    
    
    
            // Do any additional setup after loading the view, typically from a nib
}


-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{

    element = elementName;
    
    if([element isEqualToString:@"item"]){
    
        item = [[NSMutableDictionary alloc] init];
        
        title = [[NSMutableString alloc] init];
        
        link = [[NSMutableString alloc] init];
    
    
    }


}
-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{

    if ([element isEqualToString:@"title"]) {
        
        [title appendString:string];
        
    }else if ([element isEqualToString:@"link"]){
    
        [link appendString:string];
    
    }




}



-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    if ([elementName isEqualToString:@"item"]) {
        
        [item setObject:title forKey:@"title"];
        [item setObject:link forKey:@"link"];
        [feeds addObject:[item copy]];
    }
    
    
    
    
}

-(void)parserDidEndDocument:(NSXMLParser *)parser{

    NSLog(@"%@", feeds);
    

}

-(void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    
    
    NSDictionary *userInfo = parseError.userInfo;
    NSNumber *lineNumber = userInfo[@"NSXMLParserErrorLineNumber"];
    NSNumber *errorColumn = userInfo[@"NSXMLParseErrorColumn"];
    NSString *errorMessage = userInfo[@"NSXMLParseErrorMessage"];
    NSLog(@"Error at line %@ and column %@: %@", lineNumber, errorColumn, errorMessage);

}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
   // return [_list count];
    return [feeds count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *tableIdentifier = @"SimpleTable Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if(cell==nil){
        
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        
        
    }
    
   // cell.textLabel.text = [_list objectAtIndex:indexPath.row];
    cell.textLabel.text = [[feeds objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.imageView.image=[UIImage imageNamed:@"pics.jpg"];
    return cell;
}


@end
