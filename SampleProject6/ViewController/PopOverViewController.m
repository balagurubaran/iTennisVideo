//
//  PopOverViewController.m
//  SampleProject6
//
//  Created by Balagurubaran on 11/09/2014.
//  Copyright (c) 2014 Iapps. All rights reserved.
//

#import "PopOverViewController.h"
#import "FileManager.h"
#import "TeamDetail.h"
#import "VideoDetailWebservice.h"

@interface PopOverViewController (){
        VideoDetailWebservice *service;
}

@end

NSArray *_tableContent;

@implementation PopOverViewController

@synthesize LeagueSeq;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    service = [VideoDetailWebservice sharedInstance];
    [self setValueForTableView:[self getTeamDetailFromAllTeam:PLAYERS]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setValueForTableView:(NSArray *)tableContent{
    _tableContent = tableContent;
    _popOverTabelView.dataSource = self;
    _popOverTabelView.delegate = self;
    [_popOverTabelView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -  UITableView DelegateFucntion

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_tableContent count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    TeamDetail *tempValue = [_tableContent objectAtIndex:indexPath.row];
    
    cell.textLabel.text = tempValue.teamName;
    
   /* UISwitch *toggleSwitch = [[UISwitch alloc] init];
    toggleSwitch.tag = tempValue.teamTag;
    [toggleSwitch setOn:tempValue.isAddedToUserList animated:YES];
    [toggleSwitch addTarget:self action:@selector(getSwitchState:) forControlEvents:UIControlEventValueChanged];
    cell.accessoryView = [[UIView alloc] initWithFrame:toggleSwitch.frame];
    [cell.accessoryView addSubview:toggleSwitch];
    */
    return cell;
}
- (IBAction)leagueClicked:(UISegmentedControl *)sender {
    NSString* segmentString = [sender titleForSegmentAtIndex:sender.selectedSegmentIndex];
    [self setValueForTableView:[self getTeamDetailFromAllTeam:segmentString]];
}

- (NSArray*) getTeamDetailFromAllTeam:(NSString*)searchleague{
    NSMutableArray *teamDetailObj = [[NSMutableArray alloc] init];
    NSDictionary *allTeamDetail = [FileManager sharedInstance].teamDetailDic;
    
    for (NSString *key in [allTeamDetail allKeys]){
        TeamDetail *tempValue = [allTeamDetail objectForKey:key];
        if([tempValue.clubName isEqualToString:searchleague]){
            [teamDetailObj addObject:tempValue];
        }
    }
    
    return teamDetailObj;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TeamDetail *tempValue = _tableContent[indexPath.row];
    service.isRefresh = NO;
    if(![service.searchString isEqualToString:tempValue.teamName]){
        service.isRefresh = YES;
        service.searchString = tempValue.teamName;
    }
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addVideoListViewController" object:nil];
    }];
}

- (void) getSwitchState:(UISwitch*)sender{
   /* int teamTag = (int)sender.tag;
    
    NSDictionary *allTeamDetail = [FileManager sharedInstance].teamDetailDic;
    
    for (NSString *key in [allTeamDetail allKeys]){
        TeamDetail *tempValue = [allTeamDetail objectForKey:key];
        if(teamTag == tempValue.teamTag){
            [[FileManager sharedInstance] storeSelectedItem:sender.on name:key];
            tempValue.isAddedToUserList = sender.on;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateiCarousel" object:nil];
        }
    }
    */
}

- (IBAction)iPhoneGobackTOMainScreen:(UIButton *)sender {
    [[[utilize sharedInstance ] getStoryBoardViewControllerObject:@"ViewController"] presentViewController:self animated:YES completion:NULL];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
