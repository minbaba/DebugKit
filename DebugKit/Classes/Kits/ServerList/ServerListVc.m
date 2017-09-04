//
//  ServerListVc.m
//  DebugKit
//
//  Created by 郑敏 on 2017/8/14.
//
//

#import "ServerListVc.h"
#import "DebugManager.h"

@interface ServerListVc ()

@property (copy, nonatomic) NSArray<NSString *> *dataList;

@property (copy, nonatomic) NSString *currentEnv;

@end

@implementation ServerListVc

- (instancetype)initWithServerList:(NSArray<NSString *> *)list
{
    self = [super init];
    if (self) {
        self.dataList = list;
        self.currentEnv = [DebugManager defualtManager].helper.currentNetEnv;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.rowHeight = 44;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataList[indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    if ([self.currentEnv isEqualToString:self.dataList[indexPath.row]]) {
        cell.textLabel.textColor = [UIColor blueColor];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (![self.currentEnv isEqualToString:self.dataList[indexPath.row]]) {
        [DebugManager defualtManager].helper.currentNetEnv = self.dataList[indexPath.row];
    }
}

@end
