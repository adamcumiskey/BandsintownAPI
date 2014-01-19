//
//  BITEvent.h
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/14/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BITVenue;
@class BITLocation;

@interface BITEvent : NSObject

@property (strong, nonatomic) NSNumber *eventID;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSDate *eventDate;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSURL *ticketURL;
@property (strong, nonatomic) NSString *ticketType;
@property (strong, nonatomic) NSString *ticketStatus;
@property (strong, nonatomic) NSDate *ticketOnSaleDate;
@property (strong, nonatomic) NSURL *facebookRSVPURL;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSMutableArray *artists;
@property (strong, nonatomic) BITVenue *venue;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
