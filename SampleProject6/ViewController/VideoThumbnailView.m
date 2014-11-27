//
//  VideoThumbnailView.m
//  SampleProject6
//
//  Created by Balagurubaran on 16/09/2014.
//  Copyright (c) 2014 Iapps. All rights reserved.
//

#import "VideoThumbnailView.h"
#import "VideoDetailWebservice.h"
#import "Favourite.h"
#import "VideoDetail.h"


UIButton *videoBtn;
UILabel  *descriptionView;
NSArray *videoDetailArray;
VideoDetailWebservice *service;
Favourite *fav;

@implementation VideoThumbnailView



- (id)initWithFrame:(CGRect)frame background:(UIImage*)image text:(NSString*)descriptionText index:(int)videoIndex target:(id)target
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:.5].CGColor;
        self.layer.borderWidth = 3;
    }
    return self;
}

@end
