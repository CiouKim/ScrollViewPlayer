//
//  displayScrollview.m
//  scrollerViewController
//
//  Created by Hamastar on 2017/3/8.
//  Copyright © 2017年 Hamastar. All rights reserved.
//

#import "DisplayScrollview.h"
#import "NewsImageView.h"

#define UISCREENWIDTH  self.bounds.size.width
#define UISCREENHEIGHT  self.bounds.size.height

#define HIGHT self.bounds.origin.y

static CGFloat const chageImageTime = 3.0;
static NSUInteger currentImage = 1;//開始圖片1


@implementation DisplayScrollview

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bounces = NO;
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.contentOffset = CGPointMake(UISCREENWIDTH, 0);
        self.contentSize = CGSizeMake(UISCREENWIDTH * 3, UISCREENHEIGHT);
        self.delegate = self;
        
        
        
        leftImageView = [[NewsImageView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, UISCREENHEIGHT)];
        [self addSubview:leftImageView];
        [leftImageView release];
        
        centerImageView = [[NewsImageView alloc]initWithFrame:CGRectMake(UISCREENWIDTH, 0, UISCREENWIDTH, UISCREENHEIGHT)];
        [self addSubview:centerImageView];
        [centerImageView release];
        
        rightImageView = [[NewsImageView alloc]initWithFrame:CGRectMake(UISCREENWIDTH*2, 0, UISCREENWIDTH, UISCREENHEIGHT)];
        [self addSubview:rightImageView];
        [rightImageView release];
        
        isTimeUp = NO;
    }
    return self;
}

#pragma mark - setting image
- (void)setImageNameArray:(NSArray *)imageNameArray {
    _imageNameArray = imageNameArray;
//    [_imageNameArray retain];
}

- (void)updateImgView {
    [leftImageView updataTopViewImage:_imageNameArray[0]];
    leftImageView.urlPath = _imageNameArray[0];
    
    [centerImageView updataTopViewImage:_imageNameArray[1]];
    leftImageView.urlPath = _imageNameArray[1];
    
    [rightImageView updataTopViewImage:_imageNameArray[2]];
    leftImageView.urlPath = _imageNameArray[2];
}


- (void)setPageControlShowStyle:(UIPageControlShowStyle)PageControlShowStyle {
    if (PageControlShowStyle == UIPageControlShowStyleNone) {
        return;
    }
    _pageControl = [[UIPageControl alloc]init];
    _pageControl.numberOfPages = _imageNameArray.count;
    [_imageNameArray retain];
    
    if (PageControlShowStyle == UIPageControlShowStyleLeft) {
        _pageControl.frame = CGRectMake(10, HIGHT+UISCREENHEIGHT - 20, 20*_pageControl.numberOfPages, 20);
    } else if (PageControlShowStyle == UIPageControlShowStyleCenter) {
        _pageControl.frame = CGRectMake(0,0, 20*_pageControl.numberOfPages, 20);
        _pageControl.center = CGPointMake(UISCREENWIDTH/2, self.frame.origin.y + self.frame.size.height - 10);
    } else {
        _pageControl.frame = CGRectMake( UISCREENWIDTH - 20*_pageControl.numberOfPages, HIGHT+UISCREENHEIGHT - 20, 20*_pageControl.numberOfPages, 20);
    }
    _pageControl.currentPage = 0;
    
    _pageControl.enabled = NO;
    
//    [self performSelector:@selector(addPageControl) withObject:nil afterDelay:0.1f];
}

//- (void)addPageControl {
//    [self addSubview:_pageControl];
//}

- (void)animalMoveImage {
    [self setContentOffset:CGPointMake(UISCREENWIDTH * 2, 0) animated:YES];
    isTimeUp = YES;
    [NSTimer scheduledTimerWithTimeInterval:0.4f target:self selector:@selector(scrollViewDidEndDecelerating:) userInfo:nil repeats:NO];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.contentOffset.x == 0) {
        if (_pageControl.currentPage == 0) {
            _pageControl.currentPage = _imageNameArray.count;
            currentImage = _imageNameArray.count;
        } else {
            _pageControl.currentPage = (_pageControl.currentPage - 1) % _imageNameArray.count;
            currentImage = (currentImage - 1) % _imageNameArray.count;
        }
    } else if(self.contentOffset.x == UISCREENWIDTH * 2) {
        currentImage = (currentImage + 1) % _imageNameArray.count;
        _pageControl.currentPage = (_pageControl.currentPage + 1) % _imageNameArray.count;
    } else {
        return;
    }
    
    [leftImageView updataTopViewImage:_imageNameArray[(currentImage - 1) % _imageNameArray.count]];
    leftImageView.urlPath = _imageNameArray[(currentImage - 1) % _imageNameArray.count];
    
    [centerImageView updataTopViewImage:_imageNameArray[(currentImage ) % _imageNameArray.count]];
    centerImageView.urlPath = _imageNameArray[(currentImage) % _imageNameArray.count];
    
    [rightImageView updataTopViewImage:_imageNameArray[(currentImage + 1) % _imageNameArray.count]];
    rightImageView.urlPath = _imageNameArray[(currentImage + 1) % _imageNameArray.count];
    
    
    self.contentOffset = CGPointMake(UISCREENWIDTH, 0);
    
    if (!isTimeUp) {
        [moveTime setFireDate:[NSDate dateWithTimeIntervalSinceNow:chageImageTime]];
    }
    isTimeUp = NO;
}


- (void)dealloc {
    if (_imageNameArray) {
        [_imageNameArray release];
        _imageNameArray = nil;
    }
    [super dealloc];
}

@end
