//
//  SettingsViewController.m
//  SampleProject6
//
//  Created by Balagurubaran on 26/09/2014.
//  Copyright (c) 2014 Iapps. All rights reserved.
//

#import "SettingsViewController.h"
#import "FileManager.h"

#import "VideoDetailWebservice.h"

@interface SettingsViewController (){

    VideoDetailWebservice *service;
}

@end

NSArray *_tabelContent;


@implementation SettingsViewController

- (void)viewDidLoad {
    service = [VideoDetailWebservice sharedInstance];
    
    _tabelContent = [FileManager sharedInstance].moreOption;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_tabelContent count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = [_tabelContent objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    service.isRefresh = NO;
    if(![service.searchString isEqualToString:_tabelContent[indexPath.row]]){
        service.isRefresh = YES;
        service.searchString = _tabelContent[indexPath.row];
    }
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addVideoListViewController" object:nil];
    }];
}

@end
