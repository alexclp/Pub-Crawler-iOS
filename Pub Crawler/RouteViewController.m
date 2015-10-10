//
//  RouteViewController.m
//  Pub Crawler
//
//  Created by Alexandru Clapa on 10/10/2015.
//  Copyright © 2015 Alexandru Clapa. All rights reserved.
//

#import "RouteViewController.h"
#import "UIImageEffects.h"
#import "PubTableViewCell.h"
#import "PubViewController.h"

#define CellIdentifier @"PubCell"

@interface RouteViewController ()

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) NSInteger selectedPrice;

@end

@implementation RouteViewController

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
	[self.navigationController.navigationBar setBackgroundImage:nil
												  forBarMetrics:UIBarMetricsDefault];
	self.navigationController.navigationBar.shadowImage = nil;
	self.navigationController.navigationBar.translucent = NO;
	self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self configureHeader];
	
	self.locationManager = [[CLLocationManager alloc] init];
	self.locationManager.delegate = self;
	self.locationManager.distanceFilter = kCLDistanceFilterNone;
	self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	
	[self.locationManager requestAlwaysAuthorization];
	[self.locationManager startUpdatingLocation];
	
}

- (void)configureHeader {
	self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
	[self.navigationController.navigationBar setBackgroundImage:[UIImage new]
												  forBarMetrics:UIBarMetricsDefault];
	self.navigationController.navigationBar.shadowImage = [UIImage new];
	self.navigationController.navigationBar.translucent = YES;
	self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
	
	
	self.navigationController.navigationBar.topItem.title = @"";
	
	UIColor *tintColor = [UIColor colorWithWhite:0.3 alpha:0.3];
	self.header.image = [UIImageEffects imageByApplyingBlurToImage:[UIImage imageNamed:@"headerImage.jpg"] withRadius:30 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
	
	self.titleLabel.text = [self.routeDetails objectForKey:@"title"];
	self.subtitleLabel.text = @"Lorem ipsum";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (int)generateRandomNumberWithlowerBound:(int)lowerBound
							  upperBound:(int)upperBound {
	int rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
	return rndValue;
}

- (double)generateRandomDoubleLowerBound:(int)lowerBound upperBound:(int)upperBound {
	int randValue = lowerBound + arc4random() % (upperBound - lowerBound);
	return (double)randValue / 100;
}

#pragma mark UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [[self.routeDetails objectForKey:@"pubs"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	PubTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
	
	NSDictionary *currentPub = [[self.routeDetails objectForKey:@"pubs"] objectAtIndex:indexPath.row];
	cell.name.text = [currentPub objectForKey:@"title"];
	
	int price = 0;
	
//	if ([currentPub objectForKey:@"price"]) {
		price = [[currentPub objectForKey:@"price"] intValue];
//	} else {
//		price = [self generateRandomNumberWithlowerBound:0 upperBound:4];
//	}
	
	NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"$$$$$"];
	[text addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, price)];
	[text addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(price, text.length - price)];
	cell.priceRange.attributedText = text;

	cell.distance.text = [NSString stringWithFormat:@"%.2f km", [self generateRandomDoubleLowerBound:100 upperBound:500]];
	
	return cell;
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	self.selectedIndex = indexPath.row;
	[self performSegueWithIdentifier:@"showPubSegue" sender:self];
}

#pragma mark Location Delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
	self.currentLocation = [locations lastObject];
	[self.locationManager stopUpdatingLocation];
}

#pragma mark Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"showPubSegue"]) {
		PubViewController *vc = segue.destinationViewController;
		vc.pubDetails = [[self.routeDetails objectForKey:@"pubs"] objectAtIndex:self.selectedIndex];
	}
}

@end
