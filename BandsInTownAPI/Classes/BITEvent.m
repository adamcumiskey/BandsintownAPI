//
//  BITEvent.m
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/14/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import "BITEvent.h"
#import "BITArtist.h"
#import "BITVenue.h"


static const NSString *kEventIDKey = @"id";
static const NSString *kEventTitleKey = @"title";
static const NSString *kEventDateKey = @"datetime";
static const NSString *kEventFormattedDateKey = @"formatted_datetime";
static const NSString *kEventFormattedLocationKey = @"formatted_location";
static const NSString *kEventTicketURLKey = @"ticket_url";
static const NSString *kEventTicketTypeKey = @"ticket_type";
static const NSString *kEventTicketStatusKey = @"ticket_status";
static const NSString *kEventOnSaleDateKey = @"on_sale_datetime";
static const NSString *kEventFacebookURLKey = @"facebook_rsvp_url";
static const NSString *kEventDescriptionKey = @"description";
static const NSString *kEventArtistsKey = @"artists";
static const NSString *kEventVenueKey = @"venue";

@implementation BITEvent

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        _eventID = [dictionary objectForKey:kEventIDKey];
        _title = [dictionary objectForKey:kEventTitleKey];
        _eventDate = [self dateFromDateString:[dictionary objectForKey:kEventDateKey]];
        _location = [dictionary objectForKey:kEventFormattedLocationKey];
        _ticketURL = [NSURL URLWithString:[dictionary objectForKey:kEventTicketURLKey]];
        _ticketType = [dictionary objectForKey:kEventTicketTypeKey];
        _ticketStatus = [dictionary objectForKey:kEventTicketStatusKey];
        _ticketOnSaleDate = [self dateFromDateString:[dictionary objectForKey:kEventOnSaleDateKey]];
        _facebookRSVPURL = [NSURL URLWithString:[dictionary objectForKey:kEventFacebookURLKey]];
        _description = [dictionary objectForKey:kEventDescriptionKey];
        
        // Parse the BITArtist objects out of the JSON array
        NSArray *artistDictionaries = [dictionary objectForKey:kEventArtistsKey];
        for (NSDictionary *artistDictionary in artistDictionaries) {
            BITArtist *artist = [[BITArtist alloc] initWithDictionary:artistDictionary];
            [_artists addObject:artist];
        }
        
        // Parse the BITVenue object from the JSON dictionary
        NSDictionary *venueDictionary = [dictionary objectForKey:kEventVenueKey];
        _venue = [[BITVenue alloc] initWithDictionary:venueDictionary];
    }
    
    return self;
}

// This method takes the formatted date strings from the json and converts them into NSDate
- (NSDate *)dateFromDateString:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-mm-ddThh:mm:ss"];
    
    return [dateFormatter dateFromString:dateString];
}

@end
