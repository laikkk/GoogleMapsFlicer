//
//  PhotosViewController.h
//  Test2
//
//  Created by Kamil Zielinski on 21/06/15.
//  Copyright (c) 2015 Kamil Zielinski. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PhotoViewControllerDelegate <NSObject>

-(void) fetchFotosWithLongtitude:(double)longtitude andLatitude:(double) latitude;

@end

@interface PhotosViewController : UIViewController

@property NSArray *photos;
-(void) refreshGalleryUsingLongitude:(double) longitude andLatitude:(double)latitude;

@end

