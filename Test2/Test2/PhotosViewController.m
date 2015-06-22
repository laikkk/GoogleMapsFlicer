//
//  PhotosViewController.m
//  Test2
//
//  Created by Kamil Zielinski on 21/06/15.
//  Copyright (c) 2015 Kamil Zielinski. All rights reserved.
//

#import "PhotosViewController.h"
#import "AFNetworking.h"
@interface PhotosViewController ()

@end

@implementation PhotosViewController
{
UIScrollView *scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //add the scrollview to the view
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,
                                                                     self.view.frame.size.width,
                                                                     self.view.frame.size.height)];
    scrollView.pagingEnabled = YES;
    [scrollView setAlwaysBounceVertical:NO];
    //setup internal views
    NSInteger numberOfViews = 3;
    for (int i = 0; i < numberOfViews; i++) {
        CGFloat xOrigin = i * self.view.frame.size.width;
        UIImageView *image = [[UIImageView alloc] initWithFrame:
                              CGRectMake(xOrigin, 0,
                                         self.view.frame.size.width,
                                         self.view.frame.size.height)];
        image.image = [UIImage imageNamed:[NSString stringWithFormat:
                                           @"image_%d.jpeg", i+1]];
        image.contentMode = UIViewContentModeScaleAspectFit;
        [scrollView addSubview:image];
    }
    //set the scroll view content size
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width *
                                             numberOfViews,
                                             self.view.frame.size.height);
    //add the scrollview to this view
    //[self.view addSubview:scrollView];
    self.view = scrollView;
}

-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"Values in array");
    for (NSString *value in self.photos) {
        NSLog(@"%@",value);
    }
    NSLog(@"END");
}

-(void) fetchPhotos{
    NSURL *URL = [NSURL URLWithString:@"http://example.com/foo.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]
                                         initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
    } failure:nil];
    [operation start];
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
