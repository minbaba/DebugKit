//
//  DebugRootVc.m
//  DebugKit
//
//  Created by 郑敏 on 2017/7/31.
//
//

#import "DebugRootVc.h"
#import "DebugManager.h"
#import "DebugItemCell.h"

@interface DebugRootVc ()

@end



@implementation DebugRootVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [DebugManager defualtManager].items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DebugItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.nameLabel.text = [[DebugManager defualtManager].items[indexPath.row] name];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIViewController *vc = [[DebugManager defualtManager].items[indexPath.row] detailViewcontroller];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
