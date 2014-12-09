//
//  ViewController.h
//  SampleProject6
//
//  Created by Balagurubaran on 11/09/2014.
//  Copyright (c) 2014 Iapps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXImageView.h"
#import "iCarousel.h"
//#import "GADBannerView.h"

@interface ViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate>{
    //int updateMainView1;
    //GADBannerView *bannerView_;
}


@property (strong, nonatomic) IBOutlet iCarousel *teamCarouselView;
@property (strong, nonatomic) IBOutlet UILabel *appName;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

- (IBAction)actionClicked:(UIButton *)sender;

@end
