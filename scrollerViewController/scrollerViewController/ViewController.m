//
//  ViewController.m
//  scrollerViewController
//
//  Created by Hamastar on 2017/3/8.
//  Copyright © 2017年 Hamastar. All rights reserved.
//

#define UISCREENHEIGHT  self.view.bounds.size.height
#define UISCREENWIDTH  self.view.bounds.size.width


#import "ViewController.h"
#import "DisplayScrollview.h"
#import "NewsImageView.h"
#import "NewsListTableView.h"
#import "SendViewController.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)viewWillAppear:(BOOL)animated {
    
}

- (void)createScrollView {
    DisplayScrollview * scrollView = [[DisplayScrollview alloc]initWithFrame:CGRectMake(0, 64, UISCREENWIDTH, 300)];
    scrollView.contentInset = UIEdgeInsetsMake(64, 40, 0, 0);
    
    
    UIActivityIndicatorView * activityindicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(self.view.center.x - 25, self.view.center.y -25, 50, 50)];
    [activityindicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
//    [activityindicator setColor:[UIColor redColor]];
    [self.view addSubview:activityindicator];
    [activityindicator startAnimating];
    [activityindicator release];

    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        scrollView.imageNameArray = @[@"https://www.youtube.com/watch?v=QpAn9ryoB4Y",
                                      @"https://www.youtube.com/watch?v=9xWiro_tS1k",
                                      @"https://www.youtube.com/watch?v=QslJYDX3o8s",
                                      @"http://vghks.hamastar.com.tw/Upload/Vendor/1654/636208686906819381.png",
                                      @"https://www.youtube.com/watch?v=8A2t_tAjMz8",
                                      @"https://www.youtube.com/watch?v=ePpPVE-GGJw",
                                      @"https://www.youtube.com/watch?v=edTQsoNcADA",
                                      @"https://www.youtube.com/watch?v=wSBXfzgqHtE",
                                      @"https://www.youtube.com/watch?v=QOjR0s2Wk30"];
        
        
        [scrollView updateImgView];
        scrollView.PageControlShowStyle = UIPageControlShowStyleCenter;
        scrollView.pageControl.pageIndicatorTintColor = [UIColor blackColor];
        
        scrollView.pageControl.currentPageIndicatorTintColor = [UIColor yellowColor];
        [self.view addSubview:scrollView];
        [scrollView release];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 70, 70);
        [btn setBackgroundColor:[UIColor grayColor]];
        [btn setTitle:@"=" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(70, 0, self.view.frame.size.width, 70)];
        topView.backgroundColor = [UIColor redColor];
        [self.view addSubview:topView];
        [topView release];

        
        
//        NewsListTableView *tableView = [[NewsListTableView alloc] initWithFrame:CGRectMake(0, 400, UISCREENWIDTH, 295)];
//        [self.view addSubview: tableView];
//        [tableView release];
        
        menuArray = @[@"項目ㄧ", @"畫面", @"獎項", @"APP"];
        [menuArray retain];
        
        menutableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, 200, 200)];
        menutableView.dataSource = self;
        menutableView.delegate = self;
        menutableView.backgroundColor = [UIColor greenColor];
        [self.view addSubview:menutableView];
        menutableView.hidden = YES;
        [menutableView release];
        [activityindicator stopAnimating];
    });

    
}

#pragma tableDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return menuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell =[[UITableViewCell alloc] initWithFrame:CGRectMake(0, 60, 500, 30)];
    cell.textLabel.text = menuArray[indexPath.row];
    cell.backgroundColor = [UIColor greenColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"SelectedRow:%@", menuArray[indexPath.row]);
    [self hideMenutableView];
    sendViewController = [[SendViewController alloc] init];
    [self.navigationController pushViewController:sendViewController animated:YES];
    [sendViewController release];

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    [tableView setSeparatorColor:[UIColor clearColor]];
    return 0;
}


- (void)btnclick {
    if (menutableView.hidden) {
        [self showMenutableView];
    } else {
        [self hideMenutableView];
    }
}

- (void)hideMenutableView {
    [UIView animateWithDuration:0.3 animations:^{
        menutableView.frame = CGRectMake(0, 0, 0, 0);
    } completion:^(BOOL finished) {
        menutableView.hidden = YES;
    }];
}

- (void)showMenutableView {
    [UIView animateWithDuration:0.3 animations:^{
        menutableView.frame = CGRectMake(0, 70, 200, 200);
    } completion:^(BOOL finished) {
        menutableView.hidden = NO;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [menuArray release];
    [super dealloc];
}

@end
