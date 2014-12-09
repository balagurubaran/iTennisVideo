//
//  PopOverViewController.h
//  SampleProject6
//
//  Created by Balagurubaran on 11/09/2014.
//  Copyright (c) 2014 Iapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopOverViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

//@property (strong, nonatomic) IBOutlet UIView *PopOverView;
@property (weak, nonatomic) IBOutlet UITableView *popOverTabelView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *LeagueSeq;
@property (weak, nonatomic) IBOutlet UISearchBar *searchController;

- (void) setValueForTableView:(NSArray *)tableContent;
@end
