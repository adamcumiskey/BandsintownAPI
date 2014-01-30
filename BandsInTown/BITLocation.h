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
};

@interface BITLocation : NSObject

@property (nonatomic) BITLocationType type;
@property (strong, nonatomic, readonly) NSString *primaryString;
@property (strong, nonatomic, readonly) NSString *secondaryString;
@property (strong, nonatomic, readonly) NSString *latitude;
@property (strong, nonatomic, readonly) NSString *longitude;

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
