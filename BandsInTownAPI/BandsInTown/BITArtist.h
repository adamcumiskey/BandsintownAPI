//
//  BITArtist.h
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/14/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BITArtist : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *mbid;
@property (strong, nonatomic) NSURL *imageURL;
@property (strong, nonatomic) NSURL *thumbURL;
@property (strong, nonatomic) NSURL *facebookTourDatesURL;
@property (strong, nonatomic) NSNumber *numberOfUpcomingEvents;

- (id)initWithDictionary:(NSDictionary *)dictonary;

@end
