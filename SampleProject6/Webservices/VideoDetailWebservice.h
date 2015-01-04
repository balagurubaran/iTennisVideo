//
//  VideoDetailWebservice.h
//  SampleProject6
//
//  Created by Balagurubaran on 16/09/2014.
//  Copyright (c) 2014 Iapps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoDetailWebservice : NSObject

typedef void (^videoDetaiBlock)(NSArray *detail);

@property(strong)NSMutableArray *VideoDetailArr;
@property (assign) BOOL isRefresh;
@property(nonatomic)NSString *searchString;
@property (assign) NSInteger selectediCarouselIndex;
@property (assign) int selectedVideoIndex;

+ (id) sharedInstance;
- (void) getVideoList:(NSString*)searchStrings NumbeOfVideo:(int)number detailBlock:(videoDetaiBlock)block;
- (void)parseJosnValue:(NSString*)jsonValue;
@end
