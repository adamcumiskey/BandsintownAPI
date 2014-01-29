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
        _title = [self sanitizedString:[dictionary objectForKey:kEventTitleKey]];
        _location = [self sanitizedString:[dictionary objectForKey:kEventFormattedLocationKey]];
        _ticketType = [self sanitizedString:[dictionary objectForKey:kEventTicketTypeKey]];
        _ticketStatus = [self sanitizedString:[dictionary objectForKey:kEventTicketStatusKey]];
        _description = [self sanitizedString:[dictionary objectForKey:kEventDescriptionKey]];
        _eventDate = [self dateFromDateString:[self sanitizedString:[dictionary objectForKey:kEventDateKey]]];
        _ticketOnSaleDate = [self dateFromDateString:[self sanitizedString:[dictionary objectForKey:kEventOnSaleDateKey]]];
        _facebookRSVPURL = [NSURL URLWithString:[self sanitizedString:[dictionary objectForKey:kEventFacebookURLKey]]];
        _ticketURL = [NSURL URLWithString:[self sanitizedString:[dictionary objectForKey:kEventTicketURLKey]]];
        
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

// Ensures that a string from the JSON is not an instance of NSNull
- (NSString *)sanitizedString:(NSString *)string
{
    if ((id)string == [NSNull null]) {
        return nil;
    } else {
        return string;
    }
}

// This method takes the formatted date strings from the json and converts them into NSDate
- (NSDate *)dateFromDateString:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'hh:mm:ss"];
    
    return [dateFormatter dateFromString:dateString];
}

@end
