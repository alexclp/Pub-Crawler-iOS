//
//  PubViewController.h
//  Pub Crawler
//
//  Created by Alexandru Clapa on 10/10/2015.
//  Copyright © 2015 Alexandru Clapa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface PubViewController : UIViewController 

@property (nonatomic, strong) NSDictionary *pubDetails;
@property (nonatomic, assign) NSInteger price;

@property (nonatomic, weak) IBOutlet UILabel *priceLabel;
@property (nonatomic, weak) IBOutlet UILabel *ratingLabel;
@property (nonatomic, weak) IBOutlet UITextView *details;
@property (nonatomic, weak) IBOutlet UIImageView *headerImage;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;

@end
