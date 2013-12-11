//
//  AMBSlidingTableViewController.m
//  AMBSlidingTableView
//
//  Created by Álvaro on 11/12/13.
//  Copyright (c) 2013 Álvaro Medina Ballester. All rights reserved.
//

#import "AMBSlidingTableViewController.h"

@interface AMBSlidingTableViewController ()

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;

@property (strong, nonatomic) UITableView *tableView01;
@property (strong, nonatomic) UITableView *tableView02;
@property (strong, nonatomic) UITableView *tableView03;

@property (strong, nonatomic) NSArray *dataSource01;
@property (strong, nonatomic) NSArray *dataSource02;
@property (strong, nonatomic) NSArray *dataSource03;

@end

@implementation AMBSlidingTableViewController

#pragma mark - Lazy instantiation

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        _scrollView.alwaysBounceVertical = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        _pageControl.numberOfPages = 3;
        _pageControl.pageIndicatorTintColor = [UIColor blackColor];
    }
    return _pageControl;
}

- (UITableView *)tableView01
{
    if (!_tableView01) {
        _tableView01 = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView01.delegate = self;
        _tableView01.dataSource = self;
        _tableView01.tag = 0;
        _tableView01.backgroundColor = [UIColor redColor];
    }
    return _tableView01;
}

- (UITableView *)tableView02
{
    if (!_tableView02) {
        _tableView02 = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView02.delegate = self;
        _tableView02.dataSource = self;
        _tableView02.tag = 1;
        _tableView02.backgroundColor = [UIColor greenColor];
    }
    return _tableView02;
}

- (UITableView *)tableView03
{
    if (!_tableView03) {
        _tableView03 = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView03.delegate = self;
        _tableView03.dataSource = self;
        _tableView03.tag = 2;
        _tableView03.backgroundColor = [UIColor blueColor];
    }
    return _tableView03;
}


#pragma mark - Lifecycle

- (id)init
{
    self = [super init];
    if (self) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        [self.scrollView addSubview:self.tableView01];
        [self.scrollView addSubview:self.tableView02];
        [self.scrollView addSubview:self.tableView03];
        
        self.navigationItem.titleView = self.pageControl;
        [self.view addSubview:self.scrollView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tableView01.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    self.tableView02.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    self.tableView03.frame = CGRectMake(self.view.bounds.size.width*2, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    self.scrollView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width*3, self.view.bounds.size.height);
    self.pageControl.frame = CGRectMake(0, 0, 50, 20);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (tableView.tag) {
        case 0: {
            return self.dataSource01.count;
            break;
        }
        case 1: {
            return self.dataSource02.count;
            break;
        }
        case 2: {
            return self.dataSource03.count;
            break;
        }
        default: {
            NSAssert(YES, @"Wrong tableView tag");
            return 0;
            break;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat x = scrollView.contentOffset.x;
    CGFloat w = scrollView.bounds.size.width;
    self.pageControl.currentPage = floorf(x/w);
}

@end
