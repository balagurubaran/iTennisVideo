//
//  Favourite.m
//  iTennisVideo
//
//  Created by Balagurubaran on 30/10/2014.
//  Copyright (c) 2014 Iapps. All rights reserved.
//

#import "Favourite.h"
#import "FileManager.h"
@implementation Favourite{
    FileManager *fm;
}
static Favourite *sharedInstance;
+ (id) sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sharedInstance == NULL){
            sharedInstance = [[super allocWithZone:NULL] init];
            sharedInstance->fm = [[FileManager alloc] init];
        }
    });
    return sharedInstance;
}

- (void) addToFavouriteList:(NSString*)url description:(NSString*)videoDescripton{
    
    NSString *fileContentString = [self readFavouriteList];
    NSMutableArray *fileContent = [[NSMutableArray alloc] init];
    
    NSData* data = [fileContentString dataUsingEncoding:NSUTF8StringEncoding];
    NSError* error;
    if(data != nil)
        fileContent = [[NSJSONSerialization JSONObjectWithData:data options:0 error:&error] mutableCopy ];

    
    NSMutableDictionary *videoDetail = [[NSMutableDictionary alloc] init];
    [videoDetail setValue:videoDescripton forKey:@"description"];
    [videoDetail setValue:url forKey:@"url"];
    
    if(fileContent != nil){
        
        int removeIndex = -1;
        for(int i= 0 ; i < [fileContent count];i++){
            NSDictionary *eachVideoDetail = [fileContent objectAtIndex:i];
            if([[eachVideoDetail objectForKey:@"url"] isEqualToString:url]){
                removeIndex = i;
            }
        }
        if(removeIndex != -1){
            [fileContent removeObjectAtIndex:removeIndex];
        }else{
            [fileContent addObject:videoDetail];
        }
        NSLog(@"json%@",fileContent);
    }else{
        [fileContent addObject:videoDetail];
    }

    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:fileContent options:0 error:nil];
    fileContentString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    [fm writeFile:@"favourite" fileContent:fileContentString];
}

- (NSString*) readFavouriteList{
    NSString *favouriteList = [fm readFile:@"favourite"];
    return favouriteList;
}

@end
