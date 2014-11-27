//
//  utilize.h
//  SampleProject6
//
//  Created by Balagurubaran on 23/10/2014.
//  Copyright (c) 2014 Iapps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface utilize : NSObject
+ (id) sharedInstance;
- (UIViewController*) getStoryBoardViewControllerObject:(NSString*)viewControllerName;
@end