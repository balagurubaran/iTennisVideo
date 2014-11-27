//
//  VideoDetail.m
//  SampleProject6
//
//  Created by Balagurubaran on 16/09/2014.
//  Copyright (c) 2014 Iapps. All rights reserved.
//

#import "VideoDetail.h"

@implementation VideoDetail


- (NSString*) makeEmbedVideoURL{
    NSString *URLString = [NSString stringWithFormat:@"http://www.youtube.com/embed/%@?rel=0",_videoId];
    
    return URLString;
}

@end
