//
//  VideoDetail.h
//  SampleProject6
//
//  Created by Balagurubaran on 16/09/2014.
//  Copyright (c) 2014 Iapps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoDetail : NSObject

@property(strong) NSString*     videoName;
@property(strong) NSString*     videoId;
@property(strong) NSString*     videoURL;
@property(strong) NSString*     videoDescription;
@property(strong) NSString*     videoTag;
@property(strong) UIImage *     videoThumbnail;
@property(strong) NSString*     videoBaseURL;


- (NSString*) makeEmbedVideoURL;
@end
