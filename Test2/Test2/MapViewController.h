//
//  ViewController.h
//  Test2
//
//  Created by Kamil Zielinski on 16/06/15.
//  Copyright (c) 2015 Kamil Zielinski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "TabBarViewController.h"

@interface MapViewController : UIViewController<GMSMapViewDelegate>

@property (nonatomic, weak) id<PhotoViewControllerDelegate> delegate;

@end

