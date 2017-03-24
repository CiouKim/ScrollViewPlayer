//
//  SendView.m
//  scrollerViewController
//
//  Created by Hamastar on 2017/3/20.
//  Copyright © 2017年 Hamastar. All rights reserved.
//

#import "SendView.h"
#import "NewsImageView.h"

@implementation SendView
- (id)initWithController:(id)aController {
    self = [super init];
    if (self) {
        // Initialization code
        controller = aController;
        scroller = [[UIScrollView alloc] init];
        [self addSubview:scroller];
        [scroller release];
    }
    return self;
}

- (void)dealloc {
    controller = nil;
    [super dealloc];
}

- (void)createNewsScrollView {
    NSArray *newsArray = [self getData];
    newsImgArray = [[NSMutableArray alloc] initWithCapacity:1];
    for (NSDictionary *newDic in newsArray) {
        NewsImageView *newImg = [[NewsImageView alloc] init];
        [newImg updataTopViewImage:[NSString stringWithFormat:@"http://dataapi.hamastar.com.tw/%@",[newDic valueForKey:@"COVER_PIC"]]];
        [newsImgArray addObject:newImg];
        newImg.newTile = [newDic valueForKey:@"TITLE"];
    }
    
    [self setNeedsLayout];

}

- (void)layoutSubviews {
    int imgWidth = 400;
    int imgHight = 200;
    int edge = 50;
    int orignY = 20;
    int gap = 20;
    scroller.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    if (newsImgArray != nil) {
        for (NewsImageView *img in newsImgArray) {
            img.frame = CGRectMake(0, orignY , imgWidth, imgHight);
            orignY = orignY + imgHight +gap;
            [scroller addSubview:img];
        }
        scroller.contentSize = CGSizeMake(self.frame.size.width, orignY +40 );
    }//set frame
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
//    NSLog(@"response%@" , [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&err];
    NSMutableArray *dataArray = [[NSMutableArray alloc] initWithCapacity:1];
    for (NSDictionary *dic in result) {
        [dataArray addObject:dic];
    }
    return [[dataArray mutableCopy] autorelease];
}

@end
