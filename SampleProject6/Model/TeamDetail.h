//
//  TeamDetail.h
//  SampleProject6
//
//  Created by Balagurubaran on 12/09/2014.
//  Copyright (c) 2014 Iapps. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TeamDetail : NSObject

@property(strong) NSString*     teamName;
@property(strong) NSString*     clubName;
@property(strong) NSString*     logoName;
@property(nonatomic) int        teamTag;
@property(nonatomic) BOOL       isAddedToUserList;

@end
