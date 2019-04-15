//
//  FavouriteCollectionView.m
//  Fox_Movies
//
//  Created by Esraa Mohamed on 4/13/19.
//  Copyright © 2019 Esraa Mohamed. All rights reserved.
//

#import "FavouriteCollectionView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Results.h"

@interface FavouriteCollectionView ()

@end

@implementation FavouriteCollectionView


- (void)viewDidLoad {
    [super viewDidLoad];
   self.navigationController.title=@"Favourits";
   self.title=@"Favourits";
    

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)viewWillAppear:(BOOL)animated{
    _allFavourits=[Results allObjects];
   // NSLog(@"%@", [[_allFavourits objectAtIndex:0] title]);
    
    [self.collectionView reloadData];
    
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger* n=1;
//#warning Incomplete implementation, return the number of items
//    if (_allFavourits.count ==0) {
//        n=0;
//    }else n=_allFavourits.count;
    return _allFavourits.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell
   // if (_allFavourits.count!=0) {
        
        UIImageView *img =[cell viewWithTag:1];
        [img sd_setImageWithURL:[NSURL URLWithString:[_allFavourits[indexPath.row] posterPath]]
               placeholderImage:[UIImage imageNamed:@"placeholder.png"] ];
        
        CGRect rect=[[UIScreen  mainScreen] bounds];
        img.frame=CGRectMake(img.frame.origin.x, img.frame.origin.y,rect.size.width*.5, 250);
        
   // }
    
   
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    _vc=[self.storyboard instantiateViewControllerWithIdentifier:@"vc"];
    _vc.myFilm=[_allFavourits objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:_vc animated:YES];
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize newSize =CGSizeZero;
    newSize.height=250;
    CGRect rect=[[UIScreen  mainScreen] bounds];
    newSize.width =rect.size.width*0.5;
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

@end
