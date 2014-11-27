//
//  FileManager.m
//  SampleProject6
//
//  Created by Balagurubaran on 12/09/2014.
//  Copyright (c) 2014 Iapps. All rights reserved.
//

#import  "FileManager.h"
#import  "TeamDetail.h"
#import  "Language.h"

@implementation FileManager

@synthesize teamDetailDic = _teamDetailDic;

int tag = 0;
NSArray *paths;
NSString *documentsDirectory;
NSString *fileContent;

static FileManager *sharedInstance = nil;

// Get the shared instance and create it if necessary.
+ (FileManager *)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
        sharedInstance.teamDetailDic = [[NSMutableDictionary alloc] init];
        
        paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        documentsDirectory = [paths objectAtIndex:0]; // Get documents directory
        tag = 0;
        
        sharedInstance.moreOption = [[NSArray alloc] init];
    }
    
    return sharedInstance;
}

- (void) initTeamDetail{
    [self readFile:USERLIST_FILE];
    [self createTeamDetail:[[PLAYERSLIST componentsSeparatedByString:@","] mutableCopy]];
    [self createTeamDetail:[[SERIESLIST componentsSeparatedByString:@","] mutableCopy]];
    [self buildMoreSettings];
}

- (void) createTeamDetail:(NSMutableArray*)detail{

    NSString *leagueName = [detail objectAtIndex:0];
    [detail removeObjectAtIndex:0];
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"self" ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject: descriptor];
    
    NSArray *eachTeamDetail = [[[NSArray alloc] initWithArray:detail] sortedArrayUsingDescriptors:descriptors];
    
    for(int i = 0 ; i < [eachTeamDetail count]; i++){
        TeamDetail *teamDetail = [[TeamDetail alloc] init];
        teamDetail.teamName = [eachTeamDetail objectAtIndex:i];
        teamDetail.logoName = [NSString stringWithFormat:@"%@",teamDetail.teamName];
        teamDetail.teamTag  = tag;
        teamDetail.clubName = leagueName;
        tag++;
        [sharedInstance.teamDetailDic setObject:teamDetail forKey:teamDetail.teamName];
        teamDetail.isAddedToUserList = NO;
        
        if([self checkIFChossedByUser:teamDetail.teamName])
            teamDetail.isAddedToUserList = YES;
        
    }

}

- (void)buildMoreSettings{
    sharedInstance.moreOption = MORESETTINGS;
}

- (void) getLanguageDetail{
    if([self readFile:LANGUAGE_FILE]){
        
    }else{
        
        /*NSArray *detailArray = [detail componentsSeparatedByString:LANGUAGE];
        for(int i = 0 ; i < [detailArray count];i++){
            Language *lan = [[Language alloc] init];
            lan.languageName = [detailArray objectAtIndex:i];
            lan.isSelected   =  NO;
            [_languageContent addObject:lan];
        }
         */
    }
}

-(BOOL) writeFile:(NSString*)fileName fileContent:(NSString*)content{
    NSError *error;
    BOOL succeed = [content writeToFile:[documentsDirectory stringByAppendingPathComponent:fileName]
                             atomically:YES encoding:NSUTF8StringEncoding error:&error];
    return succeed;
}

-(BOOL) writeFile:(NSString *)fileName fileContentArray:(NSArray *)content{
    NSError *error;
    BOOL succeed = [content writeToFile:[documentsDirectory stringByAppendingPathComponent:fileName] atomically:YES]; //[content writeToFile:[documentsDirectory stringByAppendingPathComponent:fileName] atomically:YES encoding:NSUTF8StringEncoding error:&error];
    return succeed;
}

- (NSString*) readFile:(NSString*)fileName{
    fileContent = nil;
    NSError *error;
    NSString *filepath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    fileContent = [[NSString alloc] initWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:&error];
    
    return fileContent;
}

- (BOOL) checkIFChossedByUser:(NSString*)teamName{
    BOOL checked = NO;
    if(fileContent != nil){
        NSDictionary *dictionary = [self StringtoDictionary:fileContent];
        
        if([self containsKey:teamName dic:dictionary]){
            checked = [[dictionary objectForKey:teamName] boolValue];
        }
    }
    return checked;
}

- (void) storeSelectedItem:(BOOL)isSelected name:(NSString*)teamName{
    NSMutableDictionary *dic = [[self StringtoDictionary:fileContent]mutableCopy];

    
    if(dic == nil){
        dic = [[NSMutableDictionary alloc] init];
    }
    [dic setValue:[NSNumber numberWithBool:isSelected] forKey:teamName];
    
    NSString* content = [self dictionaryToString:dic];
    if(content != nil){
        [self writeFile:USERLIST_FILE fileContent:content];
        [self readFile:USERLIST_FILE];
    }
}

- (BOOL)containsKey: (NSString *)key dic:(NSDictionary*)dicValue{
    BOOL retVal = 0;
    NSArray *allKeys = [dicValue allKeys];
    retVal = [allKeys containsObject:key];
    return retVal;
}

- (NSMutableDictionary*) StringtoDictionary:(NSString *)string{
    NSError *error = NULL;
    
    NSData *tempData = [NSData dataWithBytes:[fileContent UTF8String] length:fileContent.length];
    
    NSMutableDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:tempData options:kNilOptions error:&error];
    
    if(error){
        dictionary = nil;
    }
    return dictionary;
    
}

- (NSString*) dictionaryToString:(NSDictionary*)dic{
    NSString *returnValue = nil;
    
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        returnValue = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    return returnValue;
}

@end
