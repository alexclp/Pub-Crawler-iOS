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
#import "UIImageView+AFNetworking.h"
#import "AFNetworking.h"

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

- (void)share {

	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Share" message:@"Enter the user name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
	[alertView show];
}

- (void)configureHeader {
	self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
	[self.navigationController.navigationBar setBackgroundImage:[UIImage new]
												  forBarMetrics:UIBarMetricsDefault];
	self.navigationController.navigationBar.shadowImage = [UIImage new];
	self.navigationController.navigationBar.translucent = YES;
	self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
	
	UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share)];
	self.navigationItem.rightBarButtonItem = shareButton;
	self.navigationController.navigationBar.topItem.title = @"";
	
	UIColor *tintColor = [UIColor colorWithWhite:0.3 alpha:0.3];
//	self.header.image = [UIImageEffects imageByApplyingBlurToImage:[UIImage imageNamed:@"headerImage.jpg"] withRadius:30 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
//	[self.header setImageWithURL:[NSURL URLWithString:[self.routeDetails objectForKey:@"image"]]
	[self.header setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self.routeDetails objectForKey:@"image"]]] placeholderImage:[UIImage imageNamed:@"beer1.jpg"] success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nonnull response, UIImage * _Nonnull image) {
		UIImage *newImage = [UIImageEffects imageByApplyingBlurToImage:image withRadius:3 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
		self.header.image = newImage;
	} failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nonnull response, NSError * _Nonnull error) {
		
	}];
	
	self.titleLabel.text = [self.routeDetails objectForKey:@"title"];
	self.subtitleLabel.text = [self.routeDetails objectForKey:@"description"];
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
		NSLog(@"INDEX: %@", [[self.routeDetails objectForKey:@"pubs"] objectAtIndex:self.selectedIndex]);
//		vc.pubDetails = [[self.routeDetails objectForKey:@"pubs"] objectAtIndex:self.selectedIndex];
		vc.pubDetails = [NSDictionary dictionaryWithDictionary:[[self.routeDetails objectForKey:@"pubs"] objectAtIndex:self.selectedIndex]];
	}
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
	
	if([title isEqualToString:@"OK"]) {
		UITextField *username = [alertView textFieldAtIndex:0];
		
		AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
		NSDictionary *parameters = @{@"to": username.text};
		[manager POST:[NSString stringWithFormat:@"http://f9df6384.ngrok.io/routes/%@", [self.routeDetails objectForKey:@"_id"]] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//			NSLog(@"JSON: %@", responseObject);
			NSLog(@"SENT TEXT");
		} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
			NSLog(@"Error: %@", error);
		}];
	}
}

@end
