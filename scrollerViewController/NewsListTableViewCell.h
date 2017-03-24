//
//  NewsListTableViewCell.h
//  scrollerViewController
//
//  Created by Hamastar on 2017/3/14.
//  Copyright © 2017年 Hamastar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsListTableViewCell : UITableViewCell {
    UIWebView *contentWebView;

}

@property (nonatomic, assign) UIImageView *iconImage;
@property (nonatomic, assign) UILabel *title;
@property (nonatomic, assign) NSString *contentString;

- (void)loadHtmlString ;

@end
