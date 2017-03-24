//
//  NewsImageView.m
//  scrollerViewController
//
//  Created by Hamastar on 2017/3/9.
//  Copyright © 2017年 Hamastar. All rights reserved.
//

#import "NewsImageView.h"

@implementation NewsImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        topView.backgroundColor = [UIColor clearColor];
        topView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:topView];
        [topView release];
        
        vedioView = [[UIImageView alloc] init];
        vedioView.backgroundColor = [UIColor blueColor];
        [topView addSubview:vedioView];
        vedioView.hidden = NO;
        [vedioView release];
        
        titleLel = [[UILabel alloc] init];
        titleLel.textColor = [UIColor blueColor];
        titleLel.backgroundColor = [UIColor clearColor];
        titleLel.numberOfLines = 1;
        titleLel.lineBreakMode = NSLineBreakByTruncatingTail;
        titleLel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:24];
        [self addSubview:titleLel];
        [titleLel release];
        
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture:)];
        
        tapGesture1.numberOfTapsRequired = 1;
        [tapGesture1 setDelegate:self];
        [self addGestureRecognizer:tapGesture1];
        [tapGesture1 release];

    }
    return self;
}

- (void)layoutSubviews {
    topView.frame = CGRectMake (0, 0, self.frame.size.width, self.frame.size.height -30);
    vedioView.frame = CGRectMake(topView.frame.size.width -100, 0, 100, 40);
    if ([titleLel.text isEqualToString:@""] == NO) {
        titleLel.frame = CGRectMake(0, self.frame.size.height -30, self.frame.size.width, 30);
    }
}

- (void)setUrlPath:(NSString *)urlPath {
    _urlPath = urlPath;
}

- (void)setNewTile:(NSString *)newTile {
    _newTile = newTile;
    [self updataTitleText];
}

- (void) updataTitleText {
    titleLel.text = _newTile;
    [self setNeedsLayout];
}

- (void)playYoutubeFromUrl:(NSString*)url {
    NSString *urlPath= url;
    if (youtubeView == nil) {
        youtubeView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    }
    if ([urlPath containsString:@"autoplay=1"] == NO) {
        urlPath = [NSString stringWithFormat:@"%@%@",urlPath ,@"&autoplay=1"];
    }
    [youtubeView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlPath]]];
    youtubeView.scrollView.bounces = NO;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        youtubeView.allowsInlineMediaPlayback = NO;//ipad need Setting NO
    }
    [youtubeView setMediaPlaybackRequiresUserAction:NO];
}

- (void)updataTopViewImage:(NSString *)urlPath {
    NSString *topViewImagePath = urlPath;
    if ([urlPath containsString:@"youtube"]) {
        NSArray *arr = [urlPath componentsSeparatedByString:@"v="];
        NSString *youtubeID;
        if([arr count] > 0) {
            if([arr count] == 1) {
                youtubeID= [[urlPath componentsSeparatedByString:@"/"] lastObject];
                
            } else{
                NSArray *urlComponents = [[arr objectAtIndex:1] componentsSeparatedByString:@"&"];
                youtubeID = [urlComponents objectAtIndex:0];
            }
        }
        _isYoutubeLink = YES;
        vedioView.hidden = NO;

        topViewImagePath = [NSString stringWithFormat:@"http://img.youtube.com/vi/%@/0.jpg",youtubeID];
    } else {
        _isYoutubeLink = NO;
        vedioView.hidden = YES;
    }
    
    //async set view
    
    UIActivityIndicatorView * activityindicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(150, 50, 30, 30)];
    [activityindicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
//    [activityindicator1 setColor:[UIColor grayColor]];
    [self addSubview:activityindicator];
    [activityindicator startAnimating];
    [activityindicator release];


    dispatch_async(dispatch_get_main_queue(), ^{
        NSURL *urlImage = [NSURL URLWithString:topViewImagePath];
        NSData *urlImageData = [NSData dataWithContentsOfURL:urlImage];
        UIImage *leftImage = [UIImage imageWithData:urlImageData];
        [topView setImage:leftImage];
        [activityindicator stopAnimating];
    });
}
//get youtube Key
- (NSString *)valueForKey:(NSString *)key fromQueryItems:(NSArray *)queryItems {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name=%@", key];
    NSURLQueryItem *queryItem = [[queryItems
                                  filteredArrayUsingPredicate:predicate]
                                 firstObject];
    return queryItem.value;
}

- (void)tapGesture:(id)sender {
    if (_isYoutubeLink) {
        [self playYoutubeFromUrl:_urlPath];
        NSLog(@"video tap");
    } else {
        NSLog(@"image tap");
    }
}

- (void)dealloc {
    [super dealloc];
}

@end
