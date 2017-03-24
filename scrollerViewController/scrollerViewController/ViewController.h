//
//  ViewController.h
//  scrollerViewController
//
//  Created by Hamastar on 2017/3/8.
//  Copyright © 2017年 Hamastar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SendViewController;

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    UITableView *menutableView;
    NSArray *menuArray;
    SendViewController *sendViewController;
}

-(void) createScrollView;

@end

