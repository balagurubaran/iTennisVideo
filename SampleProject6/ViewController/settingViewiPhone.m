//
//  settingViewiPhone.m
//  SampleProject6
//
//  Created by Balagurubaran on 15/10/2014.
//  Copyright (c) 2014 Iapps. All rights reserved.
//

#import "settingViewiPhone.h"
#import "KxMenu.h"

@implementation settingViewiPhone


- (void) addtMenuContent:(UIViewController*)controller  menuData:(NSArray*)menuContent{
    NSMutableArray *menuItems = [[NSMutableArray alloc]init];
    
    for(NSString*settings in menuContent){
        [menuItems addObject:[KxMenuItem menuItem:settings
                                            image:nil
                                              url:nil
                                           target:controller
                                           action:@selector(pushMenuItem:)]];
    }
    
    //    KxMenuItem *first = menuItems[0];
    //    first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
    //    first.alignment = NSTextAlignmentCenter;
    NSLog(@"%f",controller.view.frame.size.width);
    [KxMenu showMenuInView:controller.view
                  fromRect:CGRectMake(controller.view.frame.size.width - 100, 20/screenWidthRation, 100/screenWidthRation, 50/screenHeightRation)
                 menuItems:menuItems];
}


@end
