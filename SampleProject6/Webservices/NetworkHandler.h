//
//  NetworkHandler.h
//  SampleProject6
//
//  Created by Balagurubaran on 17/09/2014.
//  Copyright (c) 2014 Iapps. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^NetworkCompletionBlock)(NSDictionary *response);

@interface NetworkHandler : NSObject<NSURLConnectionDelegate>{
    NSURLConnection *connection;
    NSMutableData   *totalResponse;
}
- (void)requestWithURL:(NSString*)URLString completion:(NetworkCompletionBlock)NCompletionBlock;
- (void)requestWithURL:(NSString*)URLString requestID: (int)requestID completion:(NetworkCompletionBlock)NCompletionBlock;

@end
