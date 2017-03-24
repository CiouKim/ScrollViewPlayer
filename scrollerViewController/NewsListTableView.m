//
//  NewsListTableView.m
//  scrollerViewController
//
//  Created by Hamastar on 2017/3/14.
//  Copyright © 2017年 Hamastar. All rights reserved.
//

#import "NewsListTableView.h"
#import "NewsListTableViewCell.h"

@implementation NewsListTableView


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        conferenceTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        conferenceTableView.delegate = self;
        conferenceTableView.dataSource = self;
        conferenceTableView.tag = 1;
        if ([conferenceTableView respondsToSelector:@selector(separatorInset)]) {
            conferenceTableView.separatorInset = UIEdgeInsetsZero;
        }
        
        if ([conferenceTableView respondsToSelector:@selector(setCellLayoutMarginsFollowReadableWidth:)]) {
            conferenceTableView.cellLayoutMarginsFollowReadableWidth = NO;
        }
        [self addSubview:conferenceTableView];
        [conferenceTableView release];
        
        [self reloadTable];
    }
    return self;
}

- (void)layoutSubviews{
    int edge;
    int titleY;
    int titleHeight;
    int fileBrowseWidth;
    int functionwidth;
    int labealWidth;
    edge = 4;
    titleY = 35;
    titleHeight = 40;
    fileBrowseWidth = 100;
    functionwidth = 100;
    labealWidth = (self.frame.size.width - fileBrowseWidth - functionwidth - edge*2) / 2;
    
    conferenceTableView.frame = CGRectMake(edge, titleY + titleHeight, self.frame.size.width-edge*2, self.frame.size.height - titleHeight - titleY);
}

- (void)reloadTable {
    if (sortedConferenceArray != nil) {
        [sortedConferenceArray release];
    }
    sortedConferenceArray = [self getData];
    [sortedConferenceArray retain];
    
    [conferenceTableView reloadData];
}

#pragma mark - TableDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 1) {
        return  sortedConferenceArray.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsListTableViewCell *cell =[[NewsListTableViewCell alloc] initWithFrame:CGRectMake(0, 60, 500, 60)];
    cell.title.text = [sortedConferenceArray[indexPath.row] valueForKey:@"TITLE"];
//    cell.title.text = sortedConferenceArray[indexPath.row];
    cell.contentString = [sortedConferenceArray[indexPath.row] valueForKey:@"CONTENTS"];
    NSURL *urlImage = [NSURL URLWithString:[NSString stringWithFormat:@"http://dataapi.hamastar.com.tw/%@",[sortedConferenceArray[indexPath.row] valueForKey:@"COVER_PIC"]]];
    NSData *urlImageData = [NSData dataWithContentsOfURL:urlImage];
    cell.iconImage.image = [UIImage imageWithData:urlImageData];
//    [cell loadHtmlString];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"conferenceTableSelected" object:self userInfo:[sortedConferenceArray objectAtIndex:indexPath.row]];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  180;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    [tableView setSeparatorColor:[UIColor clearColor]];
    return 0;
}


- (NSArray *)getData {
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://tugo.hamastar.com.tw/Api/BackEnd/NewsAllRelationApi.ashx"]];
//    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://tugo.hamastar.com.tw/Api/BackEnd/NewsApi.ashx"]];
    [urlRequest addValue:@"application/jsoself.vn" forHTTPHeaderField:@"Content-Type"];
    urlRequest.HTTPMethod = @"POST";
    NSError *err = nil;
//    urlRequest.HTTPBody = [NSJSONSerialization dataWithJSONObject:@{@"Function_Type":@"GetList", @"data":@{@"RowID":@"1B2FC96C-21BD-450A-8785-E4DF5255BE20"}} options:0 error:&err];
    urlRequest.HTTPBody = nil;
    NSURLResponse *response = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:nil];
    NSLog(@"response%@" , [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&err];
    NSMutableArray *dataArray = [[NSMutableArray alloc] initWithCapacity:1];
    for (NSDictionary *dic in result) {
        [dataArray addObject:dic];
    }
    return [[dataArray mutableCopy] autorelease];
}

@end
