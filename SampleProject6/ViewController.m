//
//  ViewController.m
//  SampleProject6
//
//  Created by Balagurubaran on 11/09/2014.
//  Copyright (c) 2014 Iapps. All rights reserved.
//

#import "ViewController.h"
#import "PopOverViewController.h"
#import "FileManager.h"
#import "TeamDetail.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

#import "VideoListViewController.h"
#import "VideoDetailWebservice.h"
#import "AdmobViewController.h"
#import "KxMenu.h"
#import "settingViewiPhone.h"

#import "VideoThumbnailView.h"
#import "NetworkHandler.h"
#import "VideoDetailWebservice.h"
#import "VideoDetail.h"
#import "VideoThumbNailData.h"

#import "Favourite.h"

@interface ViewController ()
@property (nonatomic, strong) NSMutableDictionary *imagesDic;
@property (nonatomic, strong) NSMutableArray *images;
@property (weak, nonatomic) IBOutlet UICollectionView *MainVideoCollectionView;
@end

NSMutableArray *kxMenuItemArr;
NSMutableArray *kxMenuItemArr1;
UIPopoverController *popOverController;
VideoDetailWebservice *service;
AdmobViewController *adsController;

settingViewiPhone *settingiPhoneView;
NSArray            *videoDetailArray;
UIActivityIndicatorView *spinner;
Favourite *fav;

NSMutableArray *VideoThumbnailArray;

@implementation ViewController

@synthesize imagesDic = _imagesDic;
@synthesize images = _images;
@synthesize teamCarouselView = _teamCarouselView;

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];

   // [self.MainVideoCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"videothumbnailcell"];
    screenWidthRation = 768/self.view.frame.size.width;
    screenHeightRation = 1024/self.view.frame.size.height;
    videoDetailArray = [[NSArray alloc] init];
    
    [[FileManager sharedInstance] initTeamDetail];
    
    service = [VideoDetailWebservice sharedInstance];
    service.isRefresh = YES;


    _images = [[NSMutableArray alloc] init];
    VideoThumbnailArray = [[NSMutableArray alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addVideoListViewController) name:@"addVideoListViewController" object:nil];
    
    _appName.text = NSLocalizedString(@"appName", nil);
    adsController = [AdmobViewController singleton];
    [adsController resetAdView:self];
    
    settingiPhoneView = [[settingViewiPhone alloc] init];
     fav = [Favourite sharedInstance];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [adsController resetAdView:self];
    [super viewDidAppear:animated];
   
    if(!loadNewVideo){
        loadNewVideo = YES;
        [self loadTheVideoList:@"New"];
    }
}



- (void) didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) pushMenuItem:(id)sender{
    KxMenuItem *eachMenu = (KxMenuItem*)sender;
    [self loadTheVideoList:eachMenu.title];
}

- (IBAction)iphonePopOVerScreen:(UIButton *)sender {
    UIViewController *vc = [[utilize sharedInstance] getStoryBoardViewControllerObject:@"PopOver"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:NULL];
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (IBAction)iPhoneSettingsAtion:(id)sender {
    [settingiPhoneView addtMenuContent:self menuData:[FileManager sharedInstance].moreOption];
}

- (void)addVideoListViewController{
    
    [self loadTheVideoList:service.searchString];
}

- (void)loadTheVideoList:(NSString*)searchString{
    [VideoThumbnailArray removeAllObjects];
    _appName.text = [NSString stringWithFormat:@"%@ Videos",service.searchString];
    if(service.isRefresh){
        if([service.searchString isEqualToString:@"Favourite"]){
            NSString *temp = [fav readFavouriteList];
            if(temp != nil){
                [service parseJosnValue:temp];
                //videoDetailArray = service.VideoDetailArr;
                //[self loadTheVideoList ];
            }
            
        }else{
            
            [service getVideoList:searchString detailBlock:^(NSArray *detail) {
                videoDetailArray = [detail copy];
                [self loadTheVideoList ];
                
            }];
        }
        
    }
}

- (void) loadTheVideoList{
    /*for(UIView *subView in [_baseHolderScrollView subviews]){
        [subView removeFromSuperview];
    }
    */
    if([videoDetailArray count] <= 0 ){
        return;
    }
    
    [spinner startAnimating];
    if(videoDetailArray && [[videoDetailArray objectAtIndex:0] isKindOfClass:[NSString class]] && [[videoDetailArray objectAtIndex:0] isEqualToString:@"No result found"]){
        _appName.text = @"Videos not available";
        [spinner stopAnimating];
        return;
    }
    [self loadThumbnailview];
}

- (void) loadThumbnailview{
    int index = 0;
    for(VideoDetail *detail in videoDetailArray){
        __block UIImage *tempImage;
        if(service.isRefresh){
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
    service.selectedVideoIndex = (int)btn.tag;
    //[self dismissViewControllerAnimated:YES completion:nil];
    
    UIViewController *vc = [[utilize sharedInstance] getStoryBoardViewControllerObject:@"VideoViewController"];
    [self presentViewController:vc animated:YES completion:NULL];
}

- (IBAction)closeVideoListViewController:(UIButton *)sender {
    [adsController resetAdView:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) setImage:(UIImage*) image description:(NSString*)videoTitle index:(int)videoIndex{
    
    if(image != NULL && videoTitle != (id)[NSNull null]){
        
        VideoThumbNailData *temp = [[VideoThumbNailData alloc] init];
        temp.videoDescreption = videoTitle;
        temp.videoThumbnail = image;
        [VideoThumbnailArray addObject:temp];
        if(VideoThumbnailArray.count == videoDetailArray.count)
            [self.MainVideoCollectionView reloadData];
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

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return VideoThumbnailArray.count;
}
// 2
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}
// 3
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    VideoThumbnailView *cell = [cv dequeueReusableCellWithReuseIdentifier:@"videothumbnailcell" forIndexPath:indexPath];
    VideoThumbNailData *temp = [VideoThumbnailArray objectAtIndex:indexPath.row];
    cell.thumbNailImageView.image = temp.videoThumbnail;
    cell.thumBNailVideoTitle.text = temp.videoDescreption;
    cell.layer.cornerRadius = 10;
    cell.layer.masksToBounds = YES;
    cell.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5].CGColor;
    cell.layer.borderWidth = 3;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    service.selectedVideoIndex = indexPath.row;
    UIViewController *vc = [[utilize sharedInstance] getStoryBoardViewControllerObject:@"VideoViewController"];
    [self presentViewController:vc animated:YES completion:NULL];
}
@end
