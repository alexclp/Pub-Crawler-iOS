//
//  PubViewController.m
//  Pub Crawler
//
//  Created by Alexandru Clapa on 10/10/2015.
//  Copyright © 2015 Alexandru Clapa. All rights reserved.
//

#import "PubViewController.h"

#define CellIdentifier @"PubCell"

@interface PubViewController ()

@end

@implementation PubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self configureHeader];
	[self configureDetails];
	[self zoomToLocation];
	self.navigationItem.title = [self.pubDetails objectForKey:@"title"];
	self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
	[self.navigationController.navigationBar setBackgroundImage:nil
												  forBarMetrics:UIBarMetricsDefault];
	self.navigationController.navigationBar.shadowImage = nil;
	self.navigationController.navigationBar.translucent = NO;
	self.navigationController.navigationBar.tintColor = [UIColor blackColor];
	

}

- (void)configureDetails {
	int price = [[self.pubDetails objectForKey:@"price"] intValue];
	NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"$$$$$"];
	[text addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, price)];
	[text addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(price, text.length - price)];
	
	self.priceLabel.attributedText = text;
	NSMutableString *ratingString = [NSMutableString string];
	
	for (int i = 0; i < [[self.pubDetails objectForKey:@"raiting"] intValue] ; ++i) {
		[ratingString appendString:@"*"];
	}
	self.ratingLabel.text = ratingString.copy;
	self.details.text = [self.pubDetails objectForKey:@"description"];
	
}

- (void)configureHeader {
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		self.headerImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.pubDetails objectForKey:@"image"]]]];
	});
}

- (void)zoomToLocation {
	MKCoordinateRegion region;
	region.center.latitude = [[self.pubDetails objectForKey:@"lat"] doubleValue];
	region.center.longitude = [[self.pubDetails objectForKey:@"long"] doubleValue];
	
	region.span.latitudeDelta = 0.0005;
	region.span.longitudeDelta = 0.0005;
	
	[self.mapView setRegion:region animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
