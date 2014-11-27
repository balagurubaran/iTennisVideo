//
//  Favourite.h
//  iTennisVideo
//
//  Created by Balagurubaran on 30/10/2014.
//  Copyright (c) 2014 Iapps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Favourite : NSObject{
    
}
+ (id) sharedInstance;
- (void) addToFavouriteList:(NSString*)url description:(NSString*)videoDescripton;
- (NSString*) readFavouriteList;
@end
