//
//  ViewController.m
//  Pub Crawler
//
//  Created by Alexandru Clapa on 10/10/2015.
//  Copyright © 2015 Alexandru Clapa. All rights reserved.
//

#import "InitialViewController.h"
#import "IntroTableViewCell.h"
#import "UIImageEffects.h"

#define CellIndentifier @"TableViewCell"

@interface InitialViewController ()

@end

@implementation InitialViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	self.title = @"Pub Crawler";
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

	return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == 0) {
		return 235;
	}
	return 113;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	IntroTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIndentifier forIndexPath:indexPath];
	
	UIImage *backgroundImage = [UIImageEffects imageByApplyingLightEffectToImage:[UIImage imageNamed:@"headerImage.jpg"]];
	
	
	cell.backgroundImage.image = backgroundImage;
	cell.titleLabel.text = @"BEER";
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	
	UIImage *myImage = [UIImage imageNamed:@"headerImage.jpg"];
	UIImageView *imageView = [[UIImageView alloc] initWithImage:myImage];
	imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, 235);
	
	return imageView;
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 235;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	CGFloat sectionHeaderHeight = 337;//Change as per your table header height
	if (scrollView.contentOffset.y <= sectionHeaderHeight&&scrollView.contentOffset.y >= 0) {
		scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
	} else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
		scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
	}
}
*/
@end
