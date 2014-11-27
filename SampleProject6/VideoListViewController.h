//
//  VideoListViewController.h
//  SampleProject6
//
//  Created by Balagurubaran on 16/09/2014.
//  Copyright (c) 2014 Iapps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdmobViewController.h"

@interface VideoListViewController : UIViewController{
    
}
- (IBAction)closeVideoListViewController:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UILabel *videoGroupName;
@property (strong, nonatomic) IBOutlet UILabel *helpLbl;
@property (strong, nonatomic) IBOutlet UIScrollView *baseHolderScrollView;

@property (strong, nonatomic) IBOutlet UIView *topBarView;
- (void) loadTheVideoList:(NSString*)searchString;
+ (id) getInstance;
@end
