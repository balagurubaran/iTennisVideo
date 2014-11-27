//
//  VideoViewController.m
//  SampleProject6
//
//  Created by Balagurubaran on 15/09/2014.
//  Copyright (c) 2014 Iapps. All rights reserved.
//

#import "VideoViewController.h"
#import "VideoDetailWebservice.h"
#import "VideoDetail.h"
#import "VideoDetailWebservice.h"
#import "AdmobViewController.h"
#import "SocialNetwork.h"


@interface VideoViewController (){
    BOOL isTitleShow;
    AdmobViewController *adsController;
    SocialNetwork *socialNW;
}

@end
VideoDetailWebservice *webservice;
VideoDetail *detail;

@implementation VideoViewController

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
    // Do any additional setup after loading the view.
    
    webservice = [VideoDetailWebservice sharedInstance];
   // _videoName.frame = CGRectMake(0, 0, _videoName.frame.size.width, _videoName.frame.size.height);
    isTitleShow = YES;
    detail = [webservice.VideoDetailArr objectAtIndex:webservice.selectedVideoIndex];
    //_videoName.text = detail.videoName;
    [self playVideo];
    
    self.videoWebView.scrollView.scrollEnabled = NO;
    self.videoWebView.scrollView.bounces = NO;
    
    adsController = [AdmobViewController singleton];
    [adsController resetAdView:self];
    socialNW = [SocialNetwork sharedInstance];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)shareTweet:(UIButton *)sender {
    [socialNW shareOnSocialNetwork:SLServiceTypeTwitter message:[NSString stringWithFormat:@"I am watching %@",detail.videoName] url:[NSURL URLWithString:detail.videoBaseURL] image:detail.videoThumbnail parentView:self];
}

- (IBAction)shareFacebookPost:(UIButton *)sender {
    [socialNW shareOnSocialNetwork:SLServiceTypeFacebook message:[NSString stringWithFormat:@"I am watching %@",detail.videoName] url:[NSURL URLWithString:detail.videoBaseURL] image:detail.videoThumbnail parentView:self];
}

- (void) playVideo{
    
   NSString* embedHTML = @"<!doctype html>\
    <html>\
    <style>body{padding:0;margin:0;}</style>\
    <iframe width=\"%f\" height=\"%f\" src=\"%@&vq=hd720 or &vq=hd1080\" frameborder=\"0\" allowfullscreen></iframe>\
    </html>";

    NSString* html = [NSString stringWithFormat:embedHTML, self.view.frame.size.width, self.view.frame.size.height,[detail makeEmbedVideoURL]];
    [self.videoWebView loadHTMLString:html baseURL:nil];
}

- (IBAction)closeVideo:(UIButton *)sender {
    VideoDetailWebservice *service = [VideoDetailWebservice sharedInstance];
    service.isRefresh = NO;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
