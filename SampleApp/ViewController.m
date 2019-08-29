//
//  ViewController.m
//  SampleApp
//
//  Created by haozhu on 2019/8/29.
//  Copyright © 2019 朱浩. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableViewCell.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

#define getRectNavAndStatusHight \
({\
CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];\
CGRect rectNav = self.navigationController.navigationBar.frame;\
( rectStatus.size.height+ rectNav.size.height);\
})\

#define iPhoneX ((kScreenH == 812.f || kScreenH == 896.f) ? YES : NO)
#define CF_TabbarSafeBottomMargin (iPhoneX ? 34.f : 0.f)

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>{
    UITableView *_tableView;
    NSDictionary *_jsonDic;
    NSArray *_jsonArray;
    NSMutableArray *_isExpandArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isExpandArray = [[NSMutableArray alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"city list";
    [self readLocalFile];
    [self initTableView];
}

- (void)readLocalFile{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    _jsonDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    _jsonArray = [_jsonDic allKeys];
    for (NSInteger i = 0; i < _jsonArray.count; i++) {
        [_isExpandArray addObject:@"0"];//0:not expand 1:expand
    }
    NSLog(@"city list:%@",_jsonDic);
}

- (void)initTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, getRectNavAndStatusHight, kScreenW, kScreenH-CF_TabbarSafeBottomMargin-getRectNavAndStatusHight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma -- mark tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _jsonArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_isExpandArray[section]isEqualToString:@"1"]) {
        NSString *keyProvince = _jsonArray[section];
        NSArray *cityArray = [_jsonDic objectForKey:keyProvince];
        return  cityArray.count;
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    UILabel *provinceLabel = [[UILabel alloc]initWithFrame:CGRectMake(54, 0, 200, 26)];
    provinceLabel.textColor = [UIColor blackColor];
    provinceLabel.text = _jsonArray[section];
    [headerView addSubview:provinceLabel];
    UIImageView *selectImageView = [[UIImageView alloc]initWithFrame:CGRectMake(26, 5, 18, 18)];
    [headerView addSubview:selectImageView];
    if ([_isExpandArray[section] isEqualToString:@"0"]) {
        selectImageView.image = [UIImage imageNamed:@"caret"];
    }else{
        selectImageView.image = [UIImage imageNamed:@"caret_open"];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tap.delegate = self;
    [headerView addGestureRecognizer:tap];
    headerView.tag = section;
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *iditifier = @"CustomTableViewCell";
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iditifier];
    if (cell == nil) {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iditifier];
    }
    NSString *keyOfProvince = _jsonArray[indexPath.section];
    NSArray *cityArray = [_jsonDic objectForKey:keyOfProvince];
    cell.provinceKey.text = @"province";
    cell.provinceValue.text = [cityArray[indexPath.row] objectForKey:@"province"];
    cell.nameKey.text = @"name";
    cell.nameValue.text = [cityArray[indexPath.row] objectForKey:@"name"];
    cell.idKey.text = @"id";
    cell.idValue.text = [cityArray[indexPath.row] objectForKey:@"id"];
    return cell;
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    if ([_isExpandArray[tap.view.tag] isEqualToString:@"0"]) {
        [_isExpandArray replaceObjectAtIndex:tap.view.tag withObject:@"1"];
    }else{
        [_isExpandArray replaceObjectAtIndex:tap.view.tag withObject:@"0"];
        
    }
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:tap.view.tag];
    [_tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

