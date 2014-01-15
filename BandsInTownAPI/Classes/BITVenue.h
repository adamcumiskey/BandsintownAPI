//
//  BITVenue.h
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/14/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface BITVenue : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *region;
@property (strong, nonatomic) NSString *country;
@property (nonatomic)         CLLocationCoordinate2D coordinate;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
