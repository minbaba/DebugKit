//
//  YWSandboxBrowserVC.m
//
//  Created by 郭敏 on 2017/8/28.
//  Copyright © 2017年 ypzdw. All rights reserved.
//

#import "YWSandboxBrowserVC.h"
#import "YWSandboxFileItem.h"

UIColor *SBColorFromHexNumber(NSInteger hexNumber) {
    return [UIColor colorWithRed:((double)((hexNumber & 0xFF0000) >> 16))/255.0 green:((double)((hexNumber & 0xFF00) >> 8))/255.0 blue:((double)(hexNumber & 0xFF))/255.0 alpha:1.];
}

@interface YWSandboxBrowserVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy, readwrite) NSString *path;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *fileArray;
@property (nonatomic, assign) BOOL isRootDirectory;

@end

@implementation YWSandboxBrowserVC {
    NSIndexPath *_selectedIndexPath;
}

+ (instancetype)instanceWithPath:(NSString *)path {
    YWSandboxBrowserVC *vc = [[YWSandboxBrowserVC alloc] init];
    vc.path = path;
    return vc;
}

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    [self loadContentWithPath:self.path];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_selectedIndexPath) {
        [self.tableView deselectRowAtIndexPath:_selectedIndexPath animated:animated];
        _selectedIndexPath = nil;
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

#pragma mark - Private
- (void)setupUI {
    NSString *title;
    if ([self.path isEqualToString:NSHomeDirectory()]) {
        title = @"沙盒浏览器";
    } else {
        title = [self.path lastPathComponent];
    }
    self.title = title;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *closeBtn = [[UIBarButtonItem alloc]
                                 initWithTitle:@"关闭"
                                 style:UIBarButtonItemStylePlain
                                 target:self
                                 action:@selector(closeAction:)];
    closeBtn.tintColor = [UIColor redColor];
    self.navigationItem.rightBarButtonItem = closeBtn;
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithTitle:@""
                                             style:UIBarButtonItemStylePlain
                                             target:nil
                                             action:nil];
    
    [self configTableView];
}

- (void)configTableView {
    UITableView *tv = [[UITableView alloc] initWithFrame:CGRectZero
                                                   style:UITableViewStyleGrouped];
    tv.delegate         = self;
    tv.dataSource       = self;
    tv.tableFooterView  = [UIView new];
    [self.view addSubview:tv];
    _tableView = tv;
}

- (void)loadContentWithPath:(NSString *)filePath {
    
    NSMutableArray *contentArray = [NSMutableArray array];
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSError *error = nil;
    NSArray *contents = [fm contentsOfDirectoryAtPath:filePath error:&error];
    if (!error) {
        for (NSString *content in contents) {
            if ([[content lastPathComponent] hasPrefix:@"."]) {
                // 忽略隐藏文件(夹)
                continue;
            }
            
            BOOL isDir = NO;
            NSString *fullPath = [filePath stringByAppendingPathComponent:content];
            BOOL exists = [fm fileExistsAtPath:fullPath isDirectory:&isDir];
            
            if (exists) {
                YWSandboxFileItem *fileItem = [YWSandboxFileItem new];
                fileItem.fileName           = content;
                fileItem.fileFullPath       = fullPath;
                fileItem.fileType           = isDir ? YWFileItemTypeDirectory : YWFileItemTypeFile;
                
                if (isDir) {
                    // 计算文件夹内文件(夹)个数
                    NSError *err = nil;
                    NSArray<NSString *> *subContents = [fm contentsOfDirectoryAtPath:fullPath
                                                                               error:&err];
                    if (!err) {
                        [subContents enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            if ([[obj lastPathComponent] hasPrefix:@"."]) {
                                return;
                            }
                            fileItem.subContentsCount++;
                        }];
                    } else {
                        NSLog(@"calculate counte error: %@", err.localizedDescription);
                    }
                }
                [contentArray addObject:fileItem];
            }
        }
    } else {
        NSLog(@"eerror %@", error.localizedDescription);
    }
    
    self.fileArray = [NSArray arrayWithArray:contentArray];
    [self.tableView reloadData];
}

#pragma mark - Getter
- (NSString *)path {
    if (!_path) {
        _path = NSHomeDirectory();
    }
    return _path;
}

- (BOOL)isRootDirectory {
    if (!_isRootDirectory) {
        _isRootDirectory = [self.path isEqualToString:NSHomeDirectory()];
    }
    return _isRootDirectory;
}

- (NSString *)currentFullPathString {
    NSString *tip = @"当前目录：";
    NSString *path = [self.path stringByReplacingOccurrencesOfString:NSHomeDirectory()
                                                          withString:@""];
    if (![path hasPrefix:@"/"]) {
        path = [@"/" stringByAppendingString:path];
    }
    return [tip stringByAppendingString:path];
}

#pragma mark - Action
- (void)closeAction:(id)sender {
    // 回到沙盒浏览器`前`一个控制器，如果没有，则回到沙盒浏览器根控制器。
    NSArray *viewControllers = self.navigationController.viewControllers;
    __block NSUInteger firstSandboxVCIndex = 0;
    [viewControllers enumerateObjectsUsingBlock:^(UIViewController   * _Nonnull  obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[self class]]) {
            firstSandboxVCIndex = idx;
            *stop = YES;
        }
    }];
    
    NSInteger targetIndex = firstSandboxVCIndex - 1;
    if (targetIndex < 0) {
        targetIndex = 0;
    }
    UIViewController *targetVC = viewControllers[targetIndex];
    [self.navigationController popToViewController:targetVC animated:YES];
}

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 1 : self.fileArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *pathCellIdentifier = @"CurrentPathCellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:pathCellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:pathCellIdentifier];
            cell.textLabel.numberOfLines    = 0;
            cell.textLabel.lineBreakMode    = NSLineBreakByTruncatingHead;
            cell.selectionStyle             = UITableViewCellSelectionStyleNone;
            cell.textLabel.font             = [UIFont systemFontOfSize:15.];
            cell.textLabel.textColor        = SBColorFromHexNumber(0x333333);
        }
        cell.textLabel.text = [self currentFullPathString];
        return cell;
    }
    
    static NSString *fileCellIdentifier = @"FileNameCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:fileCellIdentifier];
    
    UILabel *nameLabel;
    UILabel *countLabel;
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:fileCellIdentifier];
        
        nameLabel = ({
            UILabel *label      = [[UILabel alloc] initWithFrame:CGRectZero];
            label.tag           = 11;
            label.font          = [UIFont systemFontOfSize:17.];
            label.textColor     = SBColorFromHexNumber(0x333333);
            label.lineBreakMode = NSLineBreakByTruncatingMiddle;
            label.translatesAutoresizingMaskIntoConstraints = NO;
            label;
        });
        [cell.contentView addSubview:nameLabel];
        
        countLabel = ({
            UILabel *label      = [[UILabel alloc] initWithFrame:CGRectZero];
            label.tag           = 12;
            label.textAlignment = NSTextAlignmentRight;
            label.font          = [UIFont systemFontOfSize:17.];
            label.textColor     = [UIColor lightGrayColor];
            label.translatesAutoresizingMaskIntoConstraints = NO;
            label;
        });
        [cell.contentView addSubview:countLabel];
        
        NSArray *constraintsH = [NSLayoutConstraint
                                 constraintsWithVisualFormat:@"H:|-15.0-[nameLabel]-8.0-[countLabel(>=8)]-0.0-|"
                                 options:0
                                 metrics:nil
                                 views:NSDictionaryOfVariableBindings(nameLabel, countLabel)];
        NSArray *constraintsV1 = [NSLayoutConstraint
                                  constraintsWithVisualFormat:@"V:|-[nameLabel]-|"
                                  options:NSLayoutFormatAlignAllCenterY
                                  metrics:nil
                                  views:NSDictionaryOfVariableBindings(nameLabel)];
        NSArray *constraintsV2 = [NSLayoutConstraint
                                  constraintsWithVisualFormat:@"V:|-[countLabel]-|"
                                  options:NSLayoutFormatAlignAllCenterY
                                  metrics:nil
                                  views:NSDictionaryOfVariableBindings(countLabel)];
        
        [cell.contentView addConstraints:constraintsH];
        [cell.contentView addConstraints:constraintsV1];
        [cell.contentView addConstraints:constraintsV2];
        
        [countLabel setContentHuggingPriority:251.0
                                      forAxis:UILayoutConstraintAxisHorizontal];
    }
    
    nameLabel   = [cell.contentView viewWithTag:11];
    countLabel  = [cell.contentView viewWithTag:12];
    
    YWSandboxFileItem *fileItem = self.fileArray[indexPath.row];
    nameLabel.text = fileItem.fileName;
    
    if (fileItem.fileType == YWFileItemTypeDirectory) {
        // 文件夹，展示文件夹内文件数量
        countLabel.text = [NSString stringWithFormat:@"%ld", fileItem.subContentsCount];
    }
    
    if (self.isRootDirectory) {
        // 根目录文件夹不能分享
        cell.accessoryType = (fileItem.fileType == YWFileItemTypeDirectory) ?
        UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
    } else {
        // 文件夹展示 i 按钮标识
        cell.tintColor = [UIColor lightGrayColor];
        cell.accessoryType = (fileItem.fileType == YWFileItemTypeDirectory) ?
        UITableViewCellAccessoryDetailDisclosureButton : UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UILabel *textLabel      = [[UILabel alloc] initWithFrame:CGRectZero];
        textLabel.font          = [UIFont systemFontOfSize:15.];
        textLabel.text          = [self currentFullPathString];
        textLabel.numberOfLines = 0;
        [textLabel sizeToFit];
        CGFloat height = [textLabel sizeThatFits:CGSizeMake(CGRectGetWidth(self.view.frame) - 30,
                                                            CGFLOAT_MAX)].height + 10;
        return MAX(ceil(height), 35.);
    }
    return 44.;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20.;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) return;
    
    YWSandboxFileItem *fileItem = self.fileArray[indexPath.row];
    if (fileItem.fileType == YWFileItemTypeDirectory) {
        _selectedIndexPath = indexPath;
        [self showDirectorDetailContentWithPath:fileItem.fileFullPath];
    } else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        _selectedIndexPath = nil;
        [self shareContentWithPath:fileItem.fileFullPath];
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    // 点击文件夹上的 i 按钮，分享此文件夹。
    YWSandboxFileItem *fileItem = self.fileArray[indexPath.row];
    [self shareContentWithPath:fileItem.fileFullPath];
}

#pragma mark - Cell Action
// Go to Directory and show Content.
- (void)showDirectorDetailContentWithPath:(NSString *)path {
    YWSandboxBrowserVC *vc = [YWSandboxBrowserVC instanceWithPath:path];
    [self.navigationController pushViewController:vc animated:YES];
}

// Share With Activity
- (void)shareContentWithPath:(NSString *)path {
    NSURL *url = [NSURL fileURLWithPath:path];
    NSArray *contentArray = @[url];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]
                                            initWithActivityItems:contentArray
                                            applicationActivities:nil];
    
    // 排除以下分享平台。
    NSArray<UIActivityType> *eaTypes = @[UIActivityTypePostToFacebook, UIActivityTypePostToTwitter,
                                         UIActivityTypePostToWeibo, UIActivityTypeMessage,
                                         UIActivityTypeMail, UIActivityTypePrint,
                                         UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact,
                                         UIActivityTypeSaveToCameraRoll, UIActivityTypeAddToReadingList,
                                         UIActivityTypePostToFlickr, UIActivityTypePostToVimeo,
                                         UIActivityTypePostToTencentWeibo, UIActivityTypeOpenInIBooks];
    activityVC.excludedActivityTypes = eaTypes;
    
    [self presentViewController:activityVC animated:YES completion:nil];
}

@end
