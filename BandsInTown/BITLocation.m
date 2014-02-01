/*
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the GNU Lesser General Public License
 * (LGPL) version 2.1 which accompanies this distribution, and is available at
 * http://www.gnu.org/licenses/lgpl-2.1.html
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 */

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

- (instancetype)initForCurrentLocation
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

#pragma mark - Class Initializers
+ (instancetype)locationWithPrimaryString:(NSString *)primaryString
             andSecondaryString:(NSString *)secondaryString
{
    return [[BITLocation alloc] initWithPrimaryString:primaryString
                                   andSecondaryString:secondaryString];
}

+ (instancetype)locationWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    return [[BITLocation alloc] initWithCoordinate:coordinate];
}

+ (instancetype)locationWithLatitude:(double)latitude
              andLongitude:(double)longitude
{
    return [[BITLocation alloc] initWithLatitude:latitude
                                    andLongitude:longitude];
}

+ (instancetype)currentLocation
{
    return [[BITLocation alloc] initForCurrentLocation];
}

#pragma mark -

- (NSString *)description {
	return [NSString stringWithFormat:@"BITLocation[type = %d, primaryString = %@, secondaryString = %@, latitude = %@, longitude = %@]",
			_type, _primaryString, _secondaryString, _latitude, _longitude];
}

@end
