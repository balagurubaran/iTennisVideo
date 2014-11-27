//
//  FileManager.h
//  SampleProject6
//
//  Created by Balagurubaran on 12/09/2014.
//  Copyright (c) 2014 Iapps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject

+ (FileManager *)sharedInstance;
- (void) initTeamDetail;

@property (strong) NSMutableDictionary* teamDetailDic;
@property (strong) NSArray*      moreOption;

- (void) storeSelectedItem:(BOOL)isSelected name:(NSString*)teamName;
-(BOOL) writeFile:(NSString*)fileName fileContent:(NSString*)content;
-(BOOL) writeFile:(NSString *)fileName fileContentArray:(NSArray *)content;
- (NSString*) readFile:(NSString*)fileName;
@end
