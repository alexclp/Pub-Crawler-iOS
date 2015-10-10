//
//  PubViewController.h
//  Pub Crawler
//
//  Created by Alexandru Clapa on 10/10/2015.
//  Copyright © 2015 Alexandru Clapa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PubViewController : UINavigationController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSDictionary *pubDetails;
@property (nonatomic, assign) NSInteger price;

@property (nonatomic, weak) IBOutlet UIImageView *headerImage;

@end
