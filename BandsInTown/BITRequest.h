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
//  BITRequest.h
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/14/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BITDateRange;
@class BITLocation;

@interface BITRequest : NSObject

@property (strong, nonatomic) NSString *artistName;
@property (strong, nonatomic) BITDateRange *dates;
@property (strong, nonatomic) BITLocation *location;
@property (strong, nonatomic) NSNumber *radius;
@property (nonatomic) BOOL onlyRecs;

+ (id)requestWithArtist:(NSString *)artist;
+ (id)requestWithArtist:(NSString *)artist
              dateRange:(BITDateRange *)dateRange
               location:(BITLocation *)location
                 radius:(NSNumber *)radius
               onlyRecs:(BOOL)onlyRecs;

- (id)initWithArtist:(NSString *)artist;
- (id)initWithArtist:(NSString *)artist
           dateRange:(BITDateRange *)dateRange
            location:(BITLocation *)location
              radius:(NSNumber *)radius
            onlyRecs:(BOOL)onlyRecs;

- (NSURLRequest *)urlRequest;
- (BOOL)isArtistRequest;

@end
