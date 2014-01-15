//
//  BITLocation.h
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/14/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BITLocationType) {
    kStringLocation,
    kCoordinateLocation,
    kCurrentLocation
};

@interface BITLocation : NSObject

@property (strong, nonatomic) NSString *primaryString;
@property (strong, nonatomic) NSString *secondaryString;
@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *lon;

@end
