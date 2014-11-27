//
//  SocialNetwork.h
//  UIRefreshSampleCode
//
//  Created by Balagurubaran on 24/07/2014.
//  Copyright (c) 2014 Balagurubaran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Social/Social.h>

@interface SocialNetwork : NSObject{
    
}

- (SLComposeViewController*) shareOnSocialNetwork:(NSString*)networkName message:(NSString*)message url:(NSURL*)url image:(UIImage*)image parentView:(UIViewController*) viewController;
+(id) sharedInstance;
@end
