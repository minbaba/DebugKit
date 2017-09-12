//
//  RequestDetailVc.m
//  Pods
//
//  Created by 郑敏 on 2017/9/12.
//
//

#import "RequestDetailVc.h"
#import "RequestDetailCell.h"
#import "NSString+FormatJSON.h"


typedef NS_ENUM(NSUInteger, RequestDetailSection) {
    RequestDetailSectionUrl = 0,
    RequestDetailSectionParam,
    RequestDetailSectionResponse,
    RequestDetailSectionCount
};


@interface RequestDetailVc () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RequestDetailVc

+ (instancetype)instance {
    NSBundle *podBundle = [NSBundle bundleForClass:[RequestDetailVc class]];
    NSURL *bundleURL = [podBundle URLForResource:@"DebugKit" withExtension:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithURL:bundleURL];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Debug" bundle:bundle];
    return [sb instantiateViewControllerWithIdentifier:@"RequestDetailVc"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"请求详情";
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 150;
    self.tableView.tableFooterView = [UIView new];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return RequestDetailSectionCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RequestDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.cpyButton.hidden = YES;
    switch (indexPath.row) {
        case RequestDetailSectionUrl: {
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"日期: YYYY-MM-dd hh:mm:SS"];
            NSString *timeStr = [formatter stringFromDate:self.model.startTime];
            
            cell.contentLabel.text = [NSString stringWithFormat:@"%@\n%@\n%@",
                                                                self.model.url,
                                                                self.model.method,
                                                                timeStr];
            break;
        }
        
        case RequestDetailSectionParam: {
            cell.contentLabel.text = [NSString stringWithFormat:@"参数:\n%@", self.model.requestBody];
            break;
        }
        default:
            
            cell.contentLabel.text = [NSString stringWithFormat:@"返回:\n%@", self.model.responseData.formatJSON];
            cell.cpyButton.hidden = NO;
            break;
    }
    
    
    return cell;
}


#pragma mark - setter and getter
- (void)setModel:(HttpDebugModel *)model {
    _model = model;
    [self.tableView reloadData];
}

@end
