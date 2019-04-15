//
//  ViewController.m
//  Fox_Movies
//
//  Created by Esraa Mohamed on 4/8/19.
//  Copyright © 2019 Esraa Mohamed. All rights reserved.
//

#import "ViewController.h"
#import <HCSStarRatingView.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title=@"Movie Details";
   // _myFilm=[Results new];
    BOOL f=NO;
    
    
    RLMResults* k =[Results allObjects];
    
    for (int i=0; i<k.count; i++) {
        Results* a=[k objectAtIndex:i] ;
        
        if(_myFilm.ID== a.ID) {
            
            f=YES;
            
        }
        
    }
    
    
    if (f) [_btn setImage:[UIImage imageNamed:@"hearted"] forState : UIControlStateNormal];
        
    
    
    
    [ _scroll setContentSize:CGSizeMake(0, 1500)];
    
    _myTitle.text=_myFilm.title;
    _ReleaseDate.text=_myFilm.releaseDate;
    
    
    
    NSString *str =[NSString stringWithFormat:@"%f", _myFilm.voteAverage];
    NSString *newStr = [str substringWithRange:NSMakeRange(0, 3)];
    _VoteAverage.text=newStr;
    
    [_img sd_setImageWithURL:[NSURL URLWithString:_myFilm.posterPath]
           placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    
 //-----------------------------------------------[Table view setDelegates]--------------------------------------------//
    
    
    [_ReviewsTableView setDelegate:self];
    [_ReviewsTableView setDataSource:self];
    
    
    
    
    //----------------------------------------LOADING REVIEWS----------------------------------------------------------//
    _totalReviews =[NSMutableArray new];
    NSString* a=[NSString stringWithFormat:@"%ld", (long)_myFilm.ID ];

    // 1
    NSString *x = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@/reviews?api_key=1a45f741aada87874aacfbeb73119bae&language=en-US&page=1", a];
    NSURL *url = [NSURL URLWithString:x];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 3
        self.dictionary = (NSDictionary *)responseObject;
        _array=[_dictionary objectForKey:@"results"];
        
        for(int i=0 ; i<_array.count ;i++){
            _dictionary=_array[i];
            _each=[Reviews new];
            _each.Author=[_dictionary objectForKey:@"author"];
            _each.Content=[_dictionary objectForKey:@"content"];
            _each.ID=[_dictionary objectForKey:@"ID"];
            _each.url=[_dictionary objectForKey:@"url"];
            
            [_totalReviews addObject:_each];
            
            NSLog(@"%@",_each.Author);
        }
        
        
        [_ReviewsTableView reloadData];
        printf("%d",_totalReviews.count);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 4
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    // 5
    [operation start];
    
    //--------------------------------trailer-------------------------------------
   // NSString* a=[NSString stringWithFormat:@"%ld", (long)_myFilm.ID ];
    _trailers =[NSMutableArray new];
    // 1
    NSString *y = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@/videos?api_key=1a45f741aada87874aacfbeb73119bae&language=en-US", a];
    NSURL *urly = [NSURL URLWithString:y];
    NSURLRequest *requesty = [NSURLRequest requestWithURL:urly];
    
    // 2
    AFHTTPRequestOperation *operationy = [[AFHTTPRequestOperation alloc] initWithRequest:requesty];
    operationy.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operationy setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operationy, id responseObject) {
        
        // 3
        self.dictionary = (NSDictionary *)responseObject;
        _array=[_dictionary objectForKey:@"results"];
        
        for(int i=0 ; i<_array.count ;i++){
            _dictionary=_array[i];
            NSString* t=[NSString new];
            t=[_dictionary objectForKey:@"key"];
            
            
            [_trailers addObject:t];
            
            NSLog(@"%@ \n \n \n",t);
        }
        
        
        //[_ReviewsTableView reloadData];
        printf("%d",_trailers.count);
     //-----------------------------------------------------
        if (_trailers.count==0) {
            
            _playerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"q"]];
            
//
//           // [_playerView addSubview:v];
            
        }
        else[self.playerView loadWithVideoId:_trailers[0]];
      //  [self.playerView reloadInputViews];
    //-----------------------------------------------------
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 4
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Results"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    // 5
    [operationy start];
    
   // --------------------------Stars Rating----------------//
   HCSStarRatingView *starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(0,0, 200, 50)];
    starRatingView.maximumValue = 5;
    starRatingView.minimumValue = 0;
    
    starRatingView.value =_myFilm.voteAverage*0.5;
    //[_myFilm.voteAverage Value];
    
    starRatingView.tintColor = [UIColor redColor];
//   [starRatingView addTarget:self action:nil forControlEvents:UIControlEventValueChanged];
    starRatingView.allowsHalfStars = YES;
   
    starRatingView.accurateHalfStars = YES;

    starRatingView.tintColor= [UIColor redColor];
    
    [self.starView setUserInteractionEnabled:NO];
    [self.starView addSubview:starRatingView];
    
    
    
    
  
    


    
    


}


//---------------------------------------------table view functions------------------------------------//

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _totalReviews.count;
}

//(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 //   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    cell.textLabel.text=[[_totalReviews objectAtIndex:indexPath.row] Author];
    
    cell.detailTextLabel.text=[[_totalReviews objectAtIndex:indexPath.row] Content];
    cell.detailTextLabel.lineBreakMode=UILineBreakModeWordWrap;
    cell.detailTextLabel.numberOfLines=0;
    return cell;
}



//------------------------------------Realm Insert---------------------------------------//
//the current object is _myFilm from class Results  which parent is RLMObject

- (IBAction)addFavourit:(id)sender {
    
    if([[_btn imageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"unhearted"]]){
    //if([_btn.currentImage isEqual:[UIImage imageNamed:@"unhearted"]]){
    [sender  setImage:[UIImage imageNamed:@"hearted"] forState : UIControlStateNormal];
    }
else{
    [sender  setImage:[UIImage imageNamed:@"unhearted"] forState : UIControlStateNormal];
    }
    
  
   
}

- (void)viewWillDisappear:(BOOL)animated{
    
    Results* temp=[Results new];
    temp.ID =_myFilm.ID;
    temp.title =_myFilm.title;
    temp.voteAverage =_myFilm.voteAverage;
    temp.releaseDate =_myFilm.releaseDate;
    temp.posterPath =_myFilm.posterPath;
    temp.overview =_myFilm.overview;
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    RLMResults* x =[Results allObjects];
    
    
    
    for (int i=0; i<x.count; i++) {
        Results* a=[x objectAtIndex:i] ;
        
        if(_myFilm.ID== a.ID) {
            [realm beginWriteTransaction];
            [realm deleteObject:[x objectAtIndex:i]];
            [realm commitWriteTransaction];
            
            
            return;
            
        }
        
    }
    
    //first fav
    //  if (x.count==0) {
    [realm beginWriteTransaction];
    [realm addObject:temp];
    [realm commitWriteTransaction];
    //    }
    
    
    
    NSLog(@"%@", _myFilm.title);
    NSLog(@"%ld",_myFilm.ID);
    

}


@end
