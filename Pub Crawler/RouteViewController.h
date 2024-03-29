//
//  RouteViewController.h
//  Pub Crawler
//
//  Created by Alexandru Clapa on 10/10/2015.
//  Copyright © 2015 Alexandru Clapa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface RouteViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, UIAlertViewDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *header;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *subtitleLabel;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSDictionary *routeDetails;

@end
