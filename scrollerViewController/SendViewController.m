//
//  SendViewController.m
//  scrollerViewController
//
//  Created by Hamastar on 2017/3/20.
//  Copyright © 2017年 Hamastar. All rights reserved.
//

#import "SendViewController.h"
#import "SendView.h"

@implementation SendViewController

- (void)loadView {
    sendView = [[SendView alloc] initWithController:self];
    [sendView createNewsScrollView];
    self.view = sendView;
    [sendView release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:NO];
    UIBarButtonItem *homeItem = [[UIBarButtonItem alloc] initWithTitle:@"<<" style:UIBarButtonItemStylePlain target:self action:@selector(homeClick:)];
    self.navigationItem.leftBarButtonItem = homeItem;
    [homeItem release];
}

- (void)homeClick:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)dealloc {
    [super dealloc];
}

@end
