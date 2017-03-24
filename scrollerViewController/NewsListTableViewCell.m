//
//  NewsListTableViewCell.m
//  scrollerViewController
//
//  Created by Hamastar on 2017/3/14.
//  Copyright © 2017年 Hamastar. All rights reserved.
//

#import "NewsListTableViewCell.h"

@implementation NewsListTableViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _iconImage = [[UIImageView alloc] init];
        [self addSubview:_iconImage];
        [_iconImage release];
        
        _title = [[UILabel alloc] init];
        _title.textColor = [UIColor whiteColor];
        _title.backgroundColor = [UIColor blackColor];
        _title.numberOfLines = 1;
        _title.lineBreakMode = NSLineBreakByTruncatingTail;
        _title.font = [UIFont fontWithName:@"STHeitiTC-Light" size:24];
        [self addSubview:_title];
        [_title release];
    }
    return self;
}

- (void)setContentString:(NSString *)contentString {
    _contentString = contentString;
}

- (void)layoutSubviews {
    int iconWidth = 77;
    int titlehigh = 30;
    _iconImage.frame = CGRectMake(0, 0, self.frame.size.width, iconWidth);
    _title.frame = CGRectMake(0, iconWidth + 10, self.frame.size.width, titlehigh);
}

@end
