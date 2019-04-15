//
//  CollectionViewController.h
//  Fox_Movies
//
//  Created by Esraa Mohamed on 4/9/19.
//  Copyright © 2019 Esraa Mohamed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"ViewController.h"
#import "Results.h"

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewController : UICollectionViewController

@property NSMutableArray* finalResult;
@property ViewController *vc;
@property NSDictionary* movies;
@property NSArray* array;
@property Results* each;
@property Boolean flag;

- (IBAction)btSort:(id)sender;


@end

NS_ASSUME_NONNULL_END
