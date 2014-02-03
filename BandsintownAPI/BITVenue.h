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
//  BITVenue.h
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/14/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void (^BITGeocodeCompletionHandler)(BOOL success,
                                         NSString *fullAddress,
                                         NSError *error);

@interface BITVenue : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *region;
@property (strong, nonatomic) NSString *country;
@property (nonatomic) CLLocationCoordinate2D coordinate;

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (void)reverseGeocodeLocationWithcompletionHandler:(BITGeocodeCompletionHandler)completionHandler;

@end
