//
//  BITLocation.h
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/14/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef NS_ENUM(NSInteger, BITLocationType) {
    kStringLocation,
    kCoordinateLocation,
    kCurrentLocation
};

@interface BITLocation : NSObject

@property (strong, nonatomic) NSString *primaryString;
@property (strong, nonatomic) NSString *secondaryString;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;

// String to used to represent the BITLocation in the request URL
- (NSString *)string;

// Class initializers
+ (id)locationWithPrimaryString:(NSString *)primaryString
             andSecondaryString:(NSString *)secondaryString;
+ (id)locationWithCoordinate:(CLLocationCoordinate2D)coordinate;
+ (id)locationWithLatitude:(double)latitude
           andLongitude:(double)longitude;
+ (id)currentLocation;

// Instance initializers
- (id)initWithPrimaryString:(NSString *)primaryString
             andSecondaryString:(NSString *)secondaryString;
- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;
- (id)initWithLatitude:(double)latitude
              andLongitude:(double)longitude;
- (id)initForCurrentLocation;

@end
