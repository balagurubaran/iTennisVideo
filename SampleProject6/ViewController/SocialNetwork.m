//
//  SocialNetwork.m
//  UIRefreshSampleCode
//
//  Created by Balagurubaran on 24/07/2014.
//  Copyright (c) 2014 Balagurubaran. All rights reserved.
//

#import "SocialNetwork.h"

__strong static id _sharedObject = nil;

SLComposeViewController *controller = nil;

@implementation SocialNetwork


+(id)sharedInstance{
    if (!_sharedObject) {
        _sharedObject = [[self alloc] init];
    }
    // returns the same object each time
    return _sharedObject;
}

#pragma mark ---- FaceBook Function ---

- (SLComposeViewController*) shareOnSocialNetwork:(NSString*)networkName message:(NSString*)message url:(NSURL*)url image:(UIImage*)image parentView:(UIViewController*) viewController{
    controller = nil;
    if([SLComposeViewController isAvailableForServiceType:networkName]) {
        controller = [SLComposeViewController composeViewControllerForServiceType:networkName];
        
        if(message != nil)
            [controller setInitialText:message];
        if(url != nil)
            [controller addURL:url];
        if(image != nil)
            [controller addImage:image];
        
        [viewController presentViewController:controller animated:YES completion:Nil];
        
    }else{
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:[networkName isEqualToString:SLServiceTypeFacebook]?SOCIAL_ERROR_MESSAGE_FACEBOOK:SOCIAL_ERROR_MESSAGE_TWITTER
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
    return controller;
}

@end
