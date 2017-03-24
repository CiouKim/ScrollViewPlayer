//
//  displayScrollview.h
//  scrollerViewController
//
//  Created by Hamastar on 2017/3/8.
//  Copyright © 2017年 Hamastar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsImageView;

typedef enum {
    UIPageControlShowStyleNone,//default
    UIPageControlShowStyleLeft,
    UIPageControlShowStyleCenter,
    UIPageControlShowStyleRight
    
} UIPageControlShowStyle;


@interface DisplayScrollview : UIScrollView <UIScrollViewDelegate>{
    NewsImageView * leftImageView;
    NewsImageView * centerImageView;
    NewsImageView * rightImageView;

    NSTimer * moveTime;
    BOOL isTimeUp;
}

@property (nonatomic, strong) UIPageControl * pageControl;
@property (nonatomic, strong) NSArray * imageNameArray;
@property (nonatomic, assign) UIPageControlShowStyle  PageControlShowStyle;

- (void)setImageUrlArray:(NSArray *)imageUrlArray;
- (void)updateImgView;



@end
