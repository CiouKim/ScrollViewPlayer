//
//  SendView.h
//  scrollerViewController
//
//  Created by Hamastar on 2017/3/20.
//  Copyright © 2017年 Hamastar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendView : UIView <UIScrollViewDelegate> {
    id controller;
    UIScrollView *scroller;
    NSMutableArray *newsImgArray;
}

- (id)initWithController:(id)aController;
- (void)createNewsScrollView;

@end
