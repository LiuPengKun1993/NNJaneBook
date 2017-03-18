//
//  NNViewController.m
//  NNJaneBook
//
//  Created by 刘朋坤 on 17/3/16.
//  Copyright © 2017年 刘朋坤. All rights reserved.
//

#import "NNViewController.h"

@interface NNViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) CGFloat currentPostion;
@property (nonatomic, assign) CGFloat stopPosition;
@property (nonatomic, assign) CGFloat lastPosition;
@property (nonatomic, assign) BOOL topBool;
@property (nonatomic, assign) BOOL bottomBool;
@property (nonatomic, strong) UIView *alphaView;

@end

@implementation NNViewController

static NSString *cellID = @"UITableViewCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
}

- (void)setupViews {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.lastPosition = 0;
    self.stopPosition = 0;
    self.topBool = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    self.title = @"NNTreasure";
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    tableView.delegate = self;
    tableView.dataSource = self;
    _tableView = tableView;
    [self.view addSubview:_tableView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    imageView.image = [UIImage imageNamed:@"headImage"];
    _tableView.tableHeaderView = imageView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    self.currentPostion = scrollView.contentOffset.y;
    
    if (self.currentPostion > 0) {
        if (self.currentPostion - self.lastPosition >= 0) {
                if (self.topBool) {
                    self.topBool = NO;
                    self.bottomBool = YES;
                self.stopPosition = self.currentPostion + 64;
            }
            self.lastPosition = self.currentPostion;
            self.navigationController.navigationBar.alpha = 1 - self.currentPostion / 500;
        } else {
            if (self.bottomBool) {
                self.bottomBool = NO;
                self.topBool = YES;
                self.stopPosition = self.currentPostion + 64;
            }
            self.lastPosition = self.currentPostion;
            self.navigationController.navigationBar.alpha = (self.stopPosition - self.currentPostion) / 200;
        }
    }
}


@end
