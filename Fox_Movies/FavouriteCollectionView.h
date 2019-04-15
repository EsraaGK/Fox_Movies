//
//  FavouriteCollectionView.h
//  Fox_Movies
//
//  Created by Esraa Mohamed on 4/13/19.
//  Copyright © 2019 Esraa Mohamed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Results.h"
#import "ViewController.h"
#import "AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@interface FavouriteCollectionView : UICollectionViewController
@property RLMResults* allFavourits;
@property ViewController* vc;
@end

NS_ASSUME_NONNULL_END
