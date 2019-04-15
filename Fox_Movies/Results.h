//
//  Results.h
//  Fox_Movies
//
//  Created by Esraa Mohamed on 4/9/19.
//  Copyright © 2019 Esraa Mohamed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RLMObject.h"
#import <Realm/Realm.h>
#import <Realm/RLMObjectBase.h>
#import <Realm/RLMThreadSafeReference.h>

NS_ASSUME_NONNULL_BEGIN

@interface Results : RLMObject
//NSInteger*   //long int
@property long int ID;//

//@property  NSNumber<RLMFloat> *voteAverage;//
@property  float voteAverage;
@property NSString  *title;//

@property NSString *releaseDate;//
@property NSString *posterPath;//
//@property NSString *originalTitle;
@property NSString *overview;//

//-(void)insertData:(Results*)R;

@end

NS_ASSUME_NONNULL_END
//@property NSInteger  *voteCount;

//"results": [
//            {
//                "vote_count": 560,
//                "id": 287947,
//                "video": false,
//                "vote_average": 7.4,
//                "title": "Shazam!",
//                "popularity": 447.577,
//                "poster_path": "/xnopI5Xtky18MPhK40cZAGAOVeV.jpg",
//                "original_language": "en",
//                "original_title": "Shazam!",
//                "genre_ids": [
//                              28,
//                              35,
//                              12,
//                              14
//                              ],
//                "backdrop_path": "/bi4jh0Kt0uuZGsGJoUUfqmbrjQg.jpg",
//                "adult": false,
//                "overview": "A boy is given the ability to become an adult superhero in times of need with a single magic word.",
//                "release_date": "2019-03-23"
//                },
