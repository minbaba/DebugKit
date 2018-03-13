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

@interface DebugRootVc () {
    NSArray<UIViewController *> *extentionVCs;
}

@end



@implementation DebugRootVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    extentionVCs = [DebugManager defualtManager].helper.extensionEnters;
    return [DebugManager defualtManager].items.count + extentionVCs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DebugItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (indexPath.row < [DebugManager defualtManager].items.count) {
        cell.nameLabel.text = [[DebugManager defualtManager].items[indexPath.row] name];
    } else {
        cell.nameLabel.text = extentionVCs[indexPath.row - [DebugManager defualtManager].items.count].title;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row < [DebugManager defualtManager].items.count) {
        UIViewController *vc = [[DebugManager defualtManager].items[indexPath.row] detailViewcontroller];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        [self.navigationController pushViewController:extentionVCs[indexPath.row - [DebugManager defualtManager].items.count] animated:YES];
    }
}

@end
