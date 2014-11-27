//
//  NetworkHandler.m
//  SampleProject6
//
//  Created by Balagurubaran on 17/09/2014.
//  Copyright (c) 2014 Iapps. All rights reserved.
//

#import "NetworkHandler.h"

NetworkCompletionBlock CompletionBlock;

@implementation NetworkHandler


- (void)requestWithURL:(NSString*)URLString completion:(NetworkCompletionBlock)NCompletionBlock{
    [self requestWithURL:URLString requestID:0 completion:NCompletionBlock];
}

- (void)requestWithURL:(NSString*)URLString requestID: (int)requestID completion:(NetworkCompletionBlock)NCompletionBlock{
    
    
    totalResponse = [[NSMutableData alloc] init];
    
    CompletionBlock = [NCompletionBlock copy];
    
    NSURLRequest *URLRequest = [[NSURLRequest alloc]  initWithURL:[NSURL URLWithString:URLString]];
    
    [NSURLConnection sendAsynchronousRequest:URLRequest queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if([connectionError description]){
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:[NSString stringWithFormat:@"%d",requestID] forKey:REQUESTID];
            [dic setObject:connectionError forKey:@"error"];
            
            CompletionBlock(dic);
            return;
        }
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[NSString stringWithFormat:@"%d",requestID] forKey:REQUESTID];
        [dic setObject:data forKey:IMAGEDATA];
        
        CompletionBlock(dic);
    }];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [totalResponse appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
   
}

@end
