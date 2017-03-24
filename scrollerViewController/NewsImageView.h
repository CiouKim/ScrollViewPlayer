//
//  NewsImageView.h
//  scrollerViewController
//
//  Created by Hamastar on 2017/3/9.
//  Copyright © 2017年 Hamastar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsImageView : UIView <UIGestureRecognizerDelegate>{
    UIImageView *topView;
    UIWebView *youtubeView;
    UIImageView *vedioView;
    UILabel *titleLel;
}


@property (nonatomic, assign) NSString *urlPath;
@property (nonatomic, assign) BOOL isYoutubeLink;
@property (nonatomic, assign) NSString *newTile;

- (void)setUrlPath:(NSString *)urlPath;
- (void)updataTopViewImage:(NSString *)url;


@end
