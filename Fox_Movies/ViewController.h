//
//  ViewController.h
//  Fox_Movies
//
//  Created by Esraa Mohamed on 4/8/19.
//  Copyright © 2019 Esraa Mohamed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"Results.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Reviews.h"
#import "AFNetworking.h"
#import "YTPlayerView.h"

@interface ViewController : UIViewController
<UITableViewDelegate , UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property Results *myFilm;
@property (weak, nonatomic) IBOutlet UILabel *myTitle;
@property (weak, nonatomic) IBOutlet UILabel *ReleaseDate;
//@property (weak, nonatomic) IBOutlet UILabel *PosterPath;
//@property (weak, nonatomic) IBOutlet UILabel *VoteAverage;
@property (weak, nonatomic) IBOutlet UILabel *VoteAverage;

@property (weak, nonatomic) IBOutlet UIScrollView *scroll;

@property(nonatomic, strong) IBOutlet YTPlayerView *playerView;

@property (weak, nonatomic) IBOutlet UIView *starView;

@property NSDictionary* dictionary;
@property NSMutableArray* array;
@property Reviews* each;
@property NSMutableArray* totalReviews;
@property NSMutableArray* trailers;
//@property Results* temp;
@property (weak, nonatomic) IBOutlet UITableView *ReviewsTableView;
- (IBAction)addFavourit:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end
//
//@property NSString *ID;//
//
//@property double *voteAverage;
//@property NSString  *title;
//
//@property NSString *releaseDate;
//@property NSString *posterPath;
//
//@property NSString *overview;//
