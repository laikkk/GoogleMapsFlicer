//
//  TabBarViewController.m
//  Test2
//
//  Created by Kamil Zielinski on 22/06/15.
//  Copyright (c) 2015 Kamil Zielinski. All rights reserved.
//

#import "TabBarViewController.h"
#import "MapViewController.h"
#import "PhotosViewController.h"

@interface TabBarViewController ()
{
    MapViewController* mapvc;
    PhotosViewController* pvc;
}
@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"hello from TabBarViewController");
    
    [self setupTabBar];
}

- (void) setupTabBar
{
    //setup viewControllers
     mapvc = [[MapViewController alloc] init];
     pvc = [[PhotosViewController alloc] init];
    
    //attach delegate
    mapvc.delegate = self;
    
    NSArray *controllers = [NSArray arrayWithObjects:mapvc,pvc, nil];
    self.viewControllers = controllers;
    
    // extract to method
    UIImage *anImage = [UIImage imageNamed:@"world_icon.png"];
    UITabBarItem *theItem = [[UITabBarItem alloc] initWithTitle:@"Map" image:anImage tag:0];
    mapvc.tabBarItem = theItem;
    
    anImage = [UIImage imageNamed:@"photo_icon.png"];
    theItem = [[UITabBarItem alloc] initWithTitle:@"Photos" image:anImage tag:1];
    pvc.tabBarItem = theItem;
}

 #pragma mark - PhotosView delegate

-(void) fetchFotosWithLongtitude:(double)longtitude andLatitude:(double) latitude;
{
    NSLog(@"Passed cords long:%g lati:%g",longtitude,latitude);
    [pvc refreshGalleryUsingLongitude:longtitude andLatitude:latitude];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
