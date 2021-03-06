//
//  RequestDebugVc.m
//  DebugKit
//
//  Created by 郑敏 on 2017/8/3.
//
//

#import "RequestDebugVc.h"
#import "HttpDebugModel.h"
#import "RequestItemCell.h"
#import "RequestDetailVc.h"

@interface RequestDebugVc () <UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (copy, nonatomic) NSArray<HttpDebugModel *> *dataList;

@end

@implementation RequestDebugVc

+ (instancetype)instance {
    NSBundle *podBundle = [NSBundle bundleForClass:[RequestDebugVc class]];
    NSURL *bundleURL = [podBundle URLForResource:@"DebugKit" withExtension:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithURL:bundleURL];

    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Debug" bundle:bundle];
    return [sb instantiateViewControllerWithIdentifier:@"RequestDebugVc"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    
    [self updateKeywords:@""];
}

- (void)updateKeywords:(NSString *)keywords {
    
    NSMutableArray *mArr = [NSMutableArray array];
    HttpDebugModel *p = [HttpDebugModel head];
    while (p) {
        if ([p.url.lowercaseString containsString:keywords.lowercaseString] || !keywords.length) {
            [mArr addObject:p];
        }
        p = p.next;
    }
    self.dataList = mArr;
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    HttpDebugModel *model = self.dataList[indexPath.row];
    RequestItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.urlLabel.text = model.url;
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"日期:yyyy-MM-dd HH:mm:ss"];
    cell.timeLabel.text = [formatter stringFromDate:model.startTime];
    cell.stateHint.backgroundColor = model.error? [UIColor redColor]: [UIColor greenColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= self.dataList.count) {
        return;
    }
    
    HttpDebugModel *model = self.dataList[indexPath.row];
    RequestDetailVc *vc = [RequestDetailVc instance];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - searchBar delegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self updateKeywords:searchText];
}

@end
