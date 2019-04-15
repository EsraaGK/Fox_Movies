//
//  CollectionViewController.m
//  Fox_Movies
//
//  Created by Esraa Mohamed on 4/9/19.
//  Copyright © 2019 Esraa Mohamed. All rights reserved.
//

#import "CollectionViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AFNetworking.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title=@"Movies";
    
    NSString *str = @"https://image.tmdb.org/t/p/w154/";
    _finalResult =[NSMutableArray new];
   
    _flag =NO;
    
    
        // 1
        //NSString *string = [NSString stringWithFormat:@"%@results.php?format=json", @"https://api.themoviedb.org/3/movie/popular?api_key=1a45f741aada87874aacfbeb73119bae&language=en-US&page=1"];
        NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/popular?api_key=1a45f741aada87874aacfbeb73119bae&language=en-US&page=1"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        // 2
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            // 3
            self.movies = (NSDictionary *)responseObject;
            _array=[_movies objectForKey:@"results"];
        
            for(int i=0 ; i<_array.count ;i++){
                _movies=_array[i];
                 _each=[Results new];
                _each.title=[_movies objectForKey:@"title"];
                
                
                 NSString *a=[_movies objectForKey:@"id"];
                _each.ID= [a integerValue];
                
                _each.posterPath=[_movies objectForKey:@"poster_path"];
                _each.posterPath = [str stringByAppendingString:_each.posterPath];
                
                _each.releaseDate=[_movies objectForKey:@"release_date"];
               
                
                //_each.voteAverage=
               NSString* B =[_movies objectForKey:@"vote_average" ];
                float c=[B floatValue];
                _each.voteAverage=c;
                
                NSLog(@"%f@",_each.voteAverage);
                                   
                [_finalResult addObject:_each];
                
                //NSLog(@"%@",_each.voteAverage);
            }

            
            [self.collectionView reloadData];
            printf("%d",_finalResult.count);
            
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
    

    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    printf("%d",_finalResult.count);
    
    return _finalResult.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell
    UIImageView *img= [cell viewWithTag:1];
   // [img sd_setImageWithURL:[NSURL URLWithString:]];
//[UIImageView setImageWithURL:[NSURL URLWithString:imageURL objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    [img sd_setImageWithURL:[NSURL URLWithString:[_finalResult[indexPath.row] posterPath]]
                 placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    CGRect rect=[[UIScreen  mainScreen] bounds];
    img.frame=CGRectMake(img.frame.origin.x, img.frame.origin.y,rect.size.width*.5, 250);
    
    
   // [img initWithImage:[UIImage imageNamed:@"x"]];
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    _vc=[self.storyboard instantiateViewControllerWithIdentifier:@"vc"];
    _vc.myFilm=[_finalResult objectAtIndex:indexPath.row];
    _vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:_vc animated:YES];
  
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize newSize =CGSizeZero;
    newSize.height=250;
    CGRect rect=[[UIScreen  mainScreen] bounds];
    newSize.width =rect.size.width*.5;
    return newSize;
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

- (IBAction)btSort:(id)sender {
      NSString *str = @"https://image.tmdb.org/t/p/w154/";
    _finalResult =[NSMutableArray new];
    
    NSURL *url;
    if(_flag==YES){
        _flag=NO;
        
        // 1
        //NSString *string = [NSString stringWithFormat:@"%@results.php?format=json", @"https://api.themoviedb.org/3/movie/popular?api_key=1a45f741aada87874aacfbeb73119bae&language=en-US&page=1"];
        url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/popular?api_key=1a45f741aada87874aacfbeb73119bae&language=en-US&page=1"];
       
       
    }else{
        _flag=YES;
        // 1
        //NSString *string = [NSString stringWithFormat:@"%@results.php?format=json", @"https://api.themoviedb.org/3/movie/popular?api_key=1a45f741aada87874aacfbeb73119bae&language=en-US&page=1"];
        url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/top_rated?api_key=1a45f741aada87874aacfbeb73119bae&language=en-US&page=1"];
        
        
    }
   //---------------------------------------
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 3
        self.movies = (NSDictionary *)responseObject;
        _array=[_movies objectForKey:@"results"];
        
        for(int i=0 ; i<_array.count ;i++){
            _movies=_array[i];
            _each=[Results new];
            _each.title=[_movies objectForKey:@"title"];
            
            
            NSString *a=[_movies objectForKey:@"id"];
            _each.ID= [a integerValue];
            
            _each.posterPath=[_movies objectForKey:@"poster_path"];
            _each.posterPath = [str stringByAppendingString:_each.posterPath];
            
            _each.releaseDate=[_movies objectForKey:@"release_date"];
            
            
            _each.voteAverage=[[_movies objectForKey:@"vote_average" ] floatValue];
            
            [_finalResult addObject:_each];
            
            NSLog(@"%@",_each.voteAverage);
        }
        
        
        [self.collectionView reloadData];
        printf("%d",_finalResult.count);
        
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
    
}
@end
