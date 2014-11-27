//
//  VideoListViewController.m
//  SampleProject6
//
//  Created by Balagurubaran on 16/09/2014.
//  Copyright (c) 2014 Iapps. All rights reserved.
//

#import "VideoListViewController.h"
#import "VideoDetailWebservice.h"
#import "VideoDetail.h"
#import <QuartzCore/QuartzCore.h>
#import "VideoThumbnailView.h"
#import "NetworkHandler.h"
//#import "AFNetworking.h"


@interface VideoListViewController ()

@end

VideoDetailWebservice *webService;
AdmobViewController *adsController;

UIActivityIndicatorView *spinner;
NSArray *videoDetailArray;

int width = 300;
int height = 300;

int x = 32;
int y = 5;

@implementation VideoListViewController
@synthesize videoGroupName = _videoGroupName;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

+ (id) getInstance{
    id temp;
    
    if(self)
        temp = self;
    return temp;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    webService = [VideoDetailWebservice sharedInstance];
    videoDetailArray = [[NSArray alloc] init];
    
    //[self loadTheVideoList:webService.searchString];
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [spinner setCenter:CGPointMake(_topBarView.frame.size.width-100/screenWidthRation,75/screenHeightRation)]; // I do this because I'm in landscape mode
    [_topBarView addSubview:spinner];
    
    
    adsController = [AdmobViewController singleton];
    [adsController resetAdView:self];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadTheVideoList:(NSString*)searchString{
    self.videoGroupName.text = [NSString stringWithFormat:@"%@ Videos",searchString];
    if(webService.isRefresh){

         [webService getVideoList:searchString detailBlock:^(NSArray *detail) {
            videoDetailArray = [detail copy];
             if(videoDetailArray != NULL){
                 [self loadTheVideoList ];
             }
             
        }];
    }
}

- (void) loadTheVideoList{
    
    for(UIView *subView in [_baseHolderScrollView subviews]){
        [subView removeFromSuperview];
    }
    
    if([videoDetailArray count] <= 0 ){
        return;
    }
    
    if([currentStoryBoard isEqualToString: @"Main_iPad"]){
        width = 290;
        height = 195;
    }else{
        width = 150;
        height = 100;
    }
    
    //width = 300/screenHeightRation;
    //height = 300/screenHeightRation;
    
    x = 40;
    y = 30;
    
    int videoPerPage = (([currentStoryBoard isEqualToString: @"Main_iPad"])? VIDEO_PER_PAGE_IPAD:VIDEO_PER_PAGE_IPHONE);
    int totalPage = ([videoDetailArray count]/videoPerPage) - 1;
    _baseHolderScrollView.contentSize = CGSizeMake(1024/screenHeightRation, self.view.frame.size.height*totalPage);
    
    int index = 0;
    [spinner startAnimating];
    
    for(VideoDetail *detail in videoDetailArray){
        __block UIImage *tempImage;
        if(webService.isRefresh){
            NSString *videoId = [self getVideoIDFromURL:detail.videoURL];
            detail.videoId = videoId;
            NetworkHandler *nHandler = [[NetworkHandler alloc] init];
            NSString *URLString = [NSString stringWithFormat:@"http://img.youtube.com/vi/%@/mqdefault.jpg",detail.videoId];
            
            [nHandler requestWithURL:URLString requestID:index completion:^(NSDictionary *response) {
                
                if(![response objectForKey:@"error"]){
                    NSArray       *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                    NSString  *documentsDirectory = [paths objectAtIndex:0];
                    
                    NSString  *filePath = [NSString stringWithFormat:@"%@/filename.jpg", documentsDirectory];
                    [[response objectForKey:IMAGEDATA] writeToFile:filePath atomically:YES];
                    
                    NSData * data = [[NSData alloc] initWithContentsOfFile:filePath];
                    
                    tempImage = [[UIImage alloc] initWithData:data];
                    
                    int videoIndex = (int)[[response objectForKey:REQUESTID] integerValue];
                    VideoDetail *temp = [videoDetailArray objectAtIndex:videoIndex];
                

                    if(tempImage){
                      [self setImage:tempImage description:temp.videoDescription index:videoIndex];
                       temp.videoThumbnail = tempImage;
                    }
                
                }
                
            }];
            
        }
        else{
            tempImage = detail.videoThumbnail;
            [self setImage:tempImage description:detail.videoDescription index:index];
        }
        index++;
    }

}

- (void) playVideo:(id)sender{
    if(spinner.isAnimating)
        return;
    
    UIButton *btn = (UIButton*)sender;
    webService.selectedVideoIndex = (int)btn.tag;
    //[self dismissViewControllerAnimated:YES completion:nil];
    
    UIViewController *vc = [[utilize sharedInstance] getStoryBoardViewControllerObject:@"VideoViewController"];
    [self presentViewController:vc animated:YES completion:NULL];
}

- (IBAction)closeVideoListViewController:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) setImage:(UIImage*) image description:(NSString*)videoTitle index:(int)videoIndex{
    
    if(image != NULL && videoTitle != (id)[NSNull null]){
        
        VideoThumbnailView *tempView = [[VideoThumbnailView alloc] initWithFrame:CGRectMake(x, y, width, height) background:image text:videoTitle index:videoIndex target:self];
        
        [_baseHolderScrollView addSubview:tempView];
        
        
        x+= width + 30/screenWidthRation;
        if(x > width * 3){
            y += height + 45/screenHeightRation;
            x = 40;
        }
        if(videoIndex == [videoDetailArray count]-1){
            [spinner stopAnimating];
        }
    }
    
}


- (NSString*) getVideoIDFromURL:(NSString*)url{
    NSArray* foo = [url componentsSeparatedByString: @"="];
    NSString* videoId = [foo objectAtIndex: 1];
    return videoId;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
