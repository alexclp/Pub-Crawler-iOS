//
//  PubViewController.h
//  Pub Crawler
//
//  Created by Alexandru Clapa on 10/10/2015.
//  Copyright © 2015 Alexandru Clapa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PubViewController : UINavigationController

@property (nonatomic, strong) NSDictionary *pubDetails;
@property (nonatomic, assign) NSInteger price;

@end
