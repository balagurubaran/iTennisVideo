//
//  VideoViewController.h
//  SampleProject6
//
//  Created by Balagurubaran on 15/09/2014.
//  Copyright (c) 2014 Iapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoViewController : UIViewController

- (IBAction)closeVideo:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UILabel *videoName;
@property (strong, nonatomic) IBOutlet UIWebView *videoWebView;

- (void) playVideo;
- (IBAction)shareTweet:(UIButton *)sender;
- (IBAction)shareFacebookPost:(UIButton *)sender;
@end
