//
//  BITLocation.m
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/14/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import "BITLocation.h"

@implementation BITLocation

- (NSString *)string
{
    switch (_type) {
        case kStringLocation:
            return [NSString stringWithFormat:@"%@,%@",
                    _primaryString,
                    _secondaryString];
            break;
            
        case kCoordinateLocation:
            return [NSString stringWithFormat:@"%@,%@",
                    _latitude,
                    _longitude];
            break;
            
        default:
            return nil;
            break;
    }
}

#pragma mark - Class Initializers
+ (id)locationWithPrimaryString:(NSString *)primaryString
             andSecondaryString:(NSString *)secondaryString
{
    return [[BITLocation alloc] initWithPrimaryString:primaryString
                                   andSecondaryString:secondaryString];
}

+ (id)locationWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    return [[BITLocation alloc] initWithCoordinate:coordinate];
}

+ (id)locationWithLatitude:(double)latitude
              andLongitude:(double)longitude
{
    return [[BITLocation alloc] initWithLatitude:latitude
                                    andLongitude:longitude];
}

+ (id)currentLocation
{
    return [[BITLocation alloc] initForCurrentLocation];
}

#pragma mark - Instance Initializers
- (id)initWithPrimaryString:(NSString *)primaryString
         andSecondaryString:(NSString *)secondaryString
{
    if (self = [super init]) {
        _primaryString = primaryString;
        _secondaryString = secondaryString;
        _type = kStringLocation;
    }
    
    return self;
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    if (self = [super init]) {
        _latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
        _longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
        _type = kCoordinateLocation;
    }
    
    return self;
}

- (id)initWithLatitude:(double)latitude
          andLongitude:(double)longitude
{
    if (self = [super init]) {
        _latitude = [NSString stringWithFormat:@"%f", latitude];
        _longitude = [NSString stringWithFormat:@"%f", longitude];
        _type = kCoordinateLocation;
    }
    
    return self;
}

- (id)initForCurrentLocation
{
    if (self = [super init]) {
        // Strong feeling that this won't work
        CLLocationManager *locationManager = [[CLLocationManager alloc] init];
        [locationManager startUpdatingLocation];
        
        _latitude = [NSString stringWithFormat:@"%f", locationManager.location.coordinate.latitude];
        _longitude = [NSString stringWithFormat:@"%f", locationManager.location.coordinate.longitude];
        _type = kCoordinateLocation;
    }
    
    return self;
}

@end
