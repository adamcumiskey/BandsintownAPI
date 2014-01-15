//
//  BITRequest.h
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/14/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BITDateRange;

@interface BITRequest : NSObject

@property (strong, nonatomic) NSString *artistName;
@property (strong, nonatomic) BITDateRange *dates;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSNumber *radius;
@property (nonatomic) BOOL onlyRecs;

- (NSURLRequest *)urlRequest;

@end
