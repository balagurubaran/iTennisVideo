//
//  VideoDetailWebservice.m
//  SampleProject6
//
//  Created by Balagurubaran on 16/09/2014.
//  Copyright (c) 2014 Iapps. All rights reserved.
//

#import "VideoDetailWebservice.h"
#import "VideoDetail.h"
#import "NetworkHandler.h"

@implementation VideoDetailWebservice


static VideoDetailWebservice *sharedInstance;
@synthesize isRefresh;
@synthesize searchString;

NetworkHandler *handler;
videoDetaiBlock completionBlock;

+ (id) sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sharedInstance == NULL){
            sharedInstance = [[super allocWithZone:NULL] init];
            sharedInstance.VideoDetailArr = [[NSMutableArray alloc] init];
            sharedInstance.isRefresh = YES;
            sharedInstance.searchString = [[NSString alloc] init];
            handler = [[NetworkHandler alloc] init];
        }
    });
    return sharedInstance;
}

- (void) getVideoList:(NSString*)searchStrings detailBlock:(videoDetaiBlock)block{
    
    
    sharedInstance.searchString = searchStrings;
    __block NSString *jsonValue = [[NSString alloc] init];
    completionBlock = block;
    if(DEMO){
        // Load string from file
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"json"];
        jsonValue = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
       
    }else{
        
        NSString *urlString = [NSString stringWithFormat:@"http://freekicktube.com/getvideourlforipad.php?team=%@&sports=tennis",sharedInstance.searchString];
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [handler requestWithURL:urlString completion:^(NSDictionary *response) {
            if(![response objectForKey:@"error"]){
                jsonValue = [[NSString alloc] initWithData:[response objectForKey:IMAGEDATA] encoding:NSUTF8StringEncoding];
                [self parseJosnValue:jsonValue];
                
            }else{
                NSLog(@"%@",[[response objectForKey:@"error"] description]);
            }
        }];
    }
}

- (void)parseJosnValue:(NSString*)jsonValue{
    [sharedInstance.VideoDetailArr removeAllObjects];
    if(jsonValue){
        NSRange range;
        range.location = 1;
        range.length = [jsonValue length] - 2;
        
        jsonValue = [jsonValue substringWithRange:range];
        NSArray *videoDetail = [[NSArray alloc] init];
        
        NSData* data = [jsonValue dataUsingEncoding: NSUTF8StringEncoding];
        
        NSError *error = NULL;
        if(data){
            videoDetail = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            if (error){
                [sharedInstance.VideoDetailArr addObject:jsonValue];
            }else{
                for(int i = 0 ; i < [videoDetail count];i++){
                    VideoDetail *eachVideoDetail = [[VideoDetail alloc] init];
                    NSDictionary *eachVideoDetailDic = [[videoDetail objectAtIndex:i] copy];
                
                    if([eachVideoDetailDic objectForKey:@"description"] != (id)[NSNull null] && [[eachVideoDetailDic objectForKey:@"url"] rangeOfString:@"www.youtube.com"].location != NSNotFound){
                        eachVideoDetail.videoDescription = [eachVideoDetailDic objectForKey:@"description"];
                        eachVideoDetail.videoName = [eachVideoDetailDic objectForKey:@"description"];
                        eachVideoDetail.videoURL = [eachVideoDetailDic objectForKey:@"url"];
                        eachVideoDetail.videoBaseURL = [eachVideoDetailDic objectForKey:@"url"];
                        [sharedInstance.VideoDetailArr addObject:eachVideoDetail];
                    }
                }
            }
            
            completionBlock(sharedInstance.VideoDetailArr);
        }
    }
}

@end
