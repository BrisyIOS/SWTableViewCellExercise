//
//  ViewController.m
//  SWTableViewCell的简单使用
//
//  Created by zhangxu on 16/3/20.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

#import "ViewController.h"
#import "HeaderView.h"
#import <SWTableViewCell.h>
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
NSString * const ID = @"cell";
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,SWTableViewCellDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 添加tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:_tableView];
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    [self.tableView registerClass:[HeaderView class] forHeaderFooterViewReuseIdentifier:ID];
    
    [self setData];
    // Do any additional setup after loading the view, typically from a nib.
}


// 懒加载
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)setData{
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < 5; i++) {
        NSString *str = [NSString stringWithFormat:@"张 %d 正在看报纸",i];
        [array addObject:str];
    }
    
    for (int i = 0; i < 4; i++) {
        [self.dataSource addObject:array];
    }
    
}

#pragma mark - 返回表头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    HeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    headerView.titleLabel.text = [NSString stringWithFormat:@"第 %ld 组",section];
    return headerView;
}


#pragma mark - 返回表头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}

#pragma mark - 返回cell 高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

#pragma mark - 返回多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

#pragma mark - 返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.dataSource[section] count];
}

#pragma mark - 返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SWTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SWTableViewCell  alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.rightUtilityButtons = [self rightUtilityButtons];
    cell.textLabel.text = self.dataSource[indexPath.section][indexPath.row];
    cell.delegate = self;
    return cell;
    
}

#pragma mark - 想左边滑右边出现按钮
- (NSMutableArray *)rightUtilityButtons{
    
    NSMutableArray *rightUtilityButtons = [NSMutableArray array];
    [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor grayColor] title:@"更多"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor redColor] title:@"删除"];
    return rightUtilityButtons;
}

#pragma mark - 点击右边的按钮调用此方法
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index{
    
    switch (index) {
        case 0:
            NSLog(@"更多");
            break;
        case 1:
            NSLog(@"删除");
            break;
        default:
            break;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
