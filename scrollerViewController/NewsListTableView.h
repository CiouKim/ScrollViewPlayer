//
//  NewsListTableView.h
//  scrollerViewController
//
//  Created by Hamastar on 2017/3/14.
//  Copyright © 2017年 Hamastar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsListTableView : UIView <UITableViewDelegate, UITableViewDataSource> {
    UITableView *conferenceTableView;
    NSArray *sortedConferenceArray;
}


@end
