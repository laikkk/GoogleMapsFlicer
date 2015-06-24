//
//  PhotosViewController.m
//  Test2
//
//  Created by Kamil Zielinski on 21/06/15.
//  Copyright (c) 2015 Kamil Zielinski. All rights reserved.
//

// https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=0373f970ea46df4d9d1d41e354e776b9&lat=54.3522&lon=18.6659&radius=1&per_page=10&page=&format=json&nojsoncallback=1&api_sig=a0b90cacc6c1b6a3ef121f9765e6600c

//https://www.flickr.com/services/api/explore/flickr.photos.search

//https://github.com/icanzilb/JSONModel

#import "PhotosViewController.h"
#import "AFNetworking.h"

@interface PhotosViewController ()
@end

@implementation PhotosViewController
{
    UIScrollView *scrollView;
    NSString *flickrURLSearchPattern;
    NSString *flickrURLPhotoPattern;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //add the scrollview to the view
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,
                                                                self.view.frame.size.width,
                                                                self.view.frame.size.height)];
    scrollView.pagingEnabled = YES;
    [scrollView setAlwaysBounceVertical:NO];
    self.view = scrollView;
}

-(void)viewDidAppear:(BOOL)animated
{
}

- (void)ClearViews {
    for(UIView *subview in [self.view subviews]) {
        [subview removeFromSuperview];
    }
}

-(void) fetchAndSetPhotosFromFlickrUsingLat:(double) lat andLon:(double)lon{
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:flickrURLSearchPattern,lat,lon]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        
        //Get photos object
        NSDictionary *photos = [responseObject valueForKey:@"photos"];
        
        //Get photo array of objects
        NSArray *photoArray = [photos valueForKey:@"photo"];
        
        //Clear all views
        [self ClearViews];
        
        for (int i=0; i< photoArray.count; i++) {
            NSValue *farmId = [(NSDictionary *)photoArray[i] valueForKey:@"farm"];
            NSValue *serverId = [(NSDictionary *)photoArray[i] valueForKey:@"server"];
            NSValue *idOfPhoto = [(NSDictionary *)photoArray[i] valueForKey:@"id"];
            NSValue *secret = [(NSDictionary *)photoArray[i] valueForKey:@"secret"];
            
            NSString *urlTOPhoto = [NSString stringWithFormat:flickrURLPhotoPattern,farmId,serverId,idOfPhoto,secret];
            NSLog(@"%@",urlTOPhoto);
            
            NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: urlTOPhoto]];
            UIImage *imageFormFlickr = [UIImage imageWithData: imageData];
            
            CGFloat xOrigin = i * self.view.frame.size.width;
            UIImageView *image = [[UIImageView alloc] initWithFrame:
                                  CGRectMake(xOrigin, 0,
                                             self.view.frame.size.width,
                                             self.view.frame.size.height)];
            image.image = imageFormFlickr;
            image.contentMode = UIViewContentModeScaleAspectFit;
            [scrollView addSubview:image];
        }
        
        //set the scroll view content size
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width *
                                            photoArray.count,
                                            self.view.frame.size.height);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    [operation start];
}

-(void)refreshGalleryUsingLongitude:(double)longitude andLatitude:(double)latitude
{
    NSLog(@"REFRESH GALLERY !");
    flickrURLSearchPattern = @"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=225e7371b0188122ae34437bf7ea02c2&lat=%f&lon=%f&radius=1&per_page=20&format=json&nojsoncallback=1";
    flickrURLPhotoPattern = @"https://farm%@.staticflickr.com/%@/%@_%@.jpg";
    
    [self fetchAndSetPhotosFromFlickrUsingLat:latitude andLon:longitude];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
