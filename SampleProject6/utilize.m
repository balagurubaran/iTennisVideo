//
//  utilize.m
//  SampleProject6
//
//  Created by Balagurubaran on 23/10/2014.
//  Copyright (c) 2014 Iapps. All rights reserved.
//

#import "utilize.h"

static utilize *sharedInstance;
@implementation utilize{
    
}

+ (id) sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sharedInstance == NULL){
            sharedInstance = [[super allocWithZone:NULL] init];
        }
    });
    return sharedInstance;
}

- (UIViewController*) getStoryBoardViewControllerObject:(NSString*)viewControllerName{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:currentStoryBoard bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:viewControllerName];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    return vc;
}

@end
