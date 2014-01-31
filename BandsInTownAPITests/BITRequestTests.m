//
//  BITRequestTests.m
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/30/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BITRequest.h"
#import "BITDateRange.h"
#import "BITLocation.h"
#import "BITArtist.h"



// Category that includes the private methods of the BITRequest class
@interface BITRequest (Test)
- (NSURLRequest *)urlRequestFromString:(NSString *)string;
- (NSString *)artistNameString;
- (NSString *)locationString;
- (NSString *)radiusString;
- (NSString *)dateString;
- (NSString *)onlyRecsString;
@end

@implementation BITRequest (Test)
- (NSURLRequest *)urlRequestFromString:(NSString *)string
{
    string = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    string = [string stringByReplacingOccurrencesOfString:@"(null)"
                                               withString:@""];
    NSLog(@"Request String: %@", string);
    return [NSURLRequest requestWithURL:[NSURL URLWithString:string]];
}

- (NSString *)sanitizeArtistNameString:(NSString *)artistName
{
    artistName = [artistName stringByReplacingOccurrencesOfString:@"/"
                                                       withString:@"%2F"];
    artistName = [artistName stringByReplacingOccurrencesOfString:@"?"
                                                       withString:@"%3F"];
    return artistName;
}

- (NSString *)artistNameString
{
    switch ([[self artist] artistNameType]) {
        case kBITArtistNameTypeString:
            return [self sanitizeArtistNameString:self.artist.name];
            break;
            
        case kBITArtistNameTypeMusicBrainzID:
            return self.artist.mbid;
            break;
            
        case kBITArtistNameTypeFacebookID:
            return self.artist.fbid;
            break;
            
        default:
            break;
    }
}

- (NSString *)locationString
{
    if (![[[self location] string] isEqualToString:@""] && self.location) {
        return [NSString stringWithFormat:@"&location=%@",
                self.location.string];
    } else {
        return @"";
    }
}

- (NSString *)radiusString
{
    if (self.radius &&
        (![[[self location] string] isEqualToString:@""] && self.location)) {
        return [NSString stringWithFormat:@"&radius=%@",
                self.radius];
    } else {
        return @"";
    }
}

- (NSString *)dateString
{
    if (![[[self dates] string] isEqualToString:@""] && self.dates) {
        return [NSString stringWithFormat:@"&date=%@",
                self.dates.string];
    } else {
        return @"";
    }
}

- (NSString *)onlyRecsString
{
    NSString *only_recs;
    if (self.onlyRecommendations) {
        only_recs = @"true";
    } else {
        only_recs = @"false";
    }
    
    return [NSString stringWithFormat:@"&only_recs=%@",
            only_recs];
}
@end




@interface BITRequestTests : XCTestCase

@end

@implementation BITRequestTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

#pragma mark - Initialization tests
- (void)testBaseInitialization
{
    BITArtist *artist = [BITArtist artistNamed:@"You Blew It!"];
    BITDateRange *dateRange = [BITDateRange dateRangeWithStartDate:[NSDate dateWithTimeIntervalSince1970:300000000]
                                                        andEndDate:[NSDate dateWithTimeIntervalSince1970:300050000]];
    BITLocation *location = [BITLocation locationWithPrimaryString:@"New York City" andSecondaryString:@"NY"];
    
    BITRequest *fullInitialization = [[BITRequest alloc] initWithArtist:artist
                                                            requestType:kBITEventSearch
                                                              dateRange:dateRange
                                                               location:location
                                                                 radius:@150];
    XCTAssert(fullInitialization.artist, @"Artist is nil");
    XCTAssert(fullInitialization.dates, @"Date range is nil");
    XCTAssert(fullInitialization.requestType == kBITEventSearch, @"Request type not set");
    
    // Check initialization through setting individual values
    BITRequest *partialInitialization = [[BITRequest alloc] init];
    [partialInitialization setArtist:artist];
    XCTAssert(partialInitialization.requestType == kBITArtistRequest, @"Request type incorrect. Expected kBITArtistRequest");
    [partialInitialization setDates:dateRange];
    XCTAssert(partialInitialization.requestType == kBITEventsRequest, @"Request type incorrect. Expected kBITEventsRequest");
    [partialInitialization setLocation:location];
    XCTAssert(partialInitialization.requestType == kBITEventSearch, @"Request type incorrect. Expected kBITEventSearch");
    [partialInitialization includeRecommendationsExludingArtist:YES];
    XCTAssert(partialInitialization.requestType == kBITRecommendationRequest, @"Request type incorrect. Expected kBITRecommendationRequest");
}

- (void)testArtistRequestInstanceInitializers
{
    BITArtist *stringArtist = [BITArtist artistNamed:@"You Blew It!"];
    BITArtist *mbidArtist = [BITArtist artistForMusicBrainzID:@"mbid_65f4f0c5-ef9e-490c-aee3-909e7ae6b2ab"];
    BITArtist *fbidArtist = [BITArtist artistForFacebookID:@"fbid_6885814958"];
    
    BITRequest *stringArtistRequest = [[BITRequest alloc] initWithRequestForArtist:stringArtist];
    BITRequest *mbidAritstRequest = [[BITRequest alloc] initWithRequestForArtist:mbidArtist];
    BITRequest *fbidArtistRequest = [[BITRequest alloc] initWithRequestForArtist:fbidArtist];
    
    // Make sure the request type property is correctly set
    XCTAssertTrue(stringArtistRequest.requestType == kBITArtistRequest, @"Incorrect request type");
    XCTAssertTrue(mbidAritstRequest.requestType == kBITArtistRequest, @"Incorrect request type");
    XCTAssertTrue(fbidArtistRequest.requestType == kBITArtistRequest, @"Incorrect request type");
    
    // Make sure the artist name types are correct
    XCTAssertTrue(stringArtistRequest.artist.artistNameType == kBITArtistNameTypeString, @"Incorrect name type");
    XCTAssertTrue(mbidAritstRequest.artist.artistNameType == kBITArtistNameTypeMusicBrainzID, @"Incorrect request type");
    XCTAssertTrue(fbidArtistRequest.artist.artistNameType == kBITArtistNameTypeFacebookID, @"Incorrect request type");
}

- (void)testArtistRequestClassInitializers
{
    BITRequest *stringArtistRequest = [BITRequest artistRequestForName:@"You Blew It!"];
    BITRequest *mbidAritstRequest = [BITRequest artistRequestForMusicBrainzID:@"mbid_65f4f0c5-ef9e-490c-aee3-909e7ae6b2ab"];
    BITRequest *fbidArtistRequest = [BITRequest artistRequestForFacebookID:@"@fbid_6885814958"];
    
    // Make sure the request type property is correctly set
    XCTAssertTrue(stringArtistRequest.requestType == kBITArtistRequest, @"Incorrect request type");
    XCTAssertTrue(mbidAritstRequest.requestType == kBITArtistRequest, @"Incorrect request type");
    XCTAssertTrue(fbidArtistRequest.requestType == kBITArtistRequest, @"Incorrect request type");
    
    // Make sure the artist name types are correct
    XCTAssertTrue(stringArtistRequest.artist.artistNameType == kBITArtistNameTypeString, @"Incorrect name type");
    XCTAssertTrue(mbidAritstRequest.artist.artistNameType == kBITArtistNameTypeMusicBrainzID, @"Incorrect request type");
    XCTAssertTrue(fbidArtistRequest.artist.artistNameType == kBITArtistNameTypeFacebookID, @"Incorrect request type");
}

- (void)testAllEventsForArtistInitialization
{
    BITArtist *artist = [BITArtist artistNamed:@"You Blew It!"];
    BITRequest *request = [BITRequest allEventsForArtist:artist];
    
    XCTAssertTrue(request.dates.type == kAllDates, @"Request has wrong date range");
    XCTAssertTrue(request.requestType == kBITEventsRequest, @"Request has wrong request type");

    // Test to see if the request type changes when appropriate
    [request setSearchLocation:[BITLocation locationWithPrimaryString:@"New York City" andSecondaryString:@"NY"]
                     andRadius:@150];
    XCTAssert(request.requestType == kBITEventSearch, @"Request type did not change");
    
    [request includeRecommendationsExludingArtist:YES];
    XCTAssert(request.requestType == kBITRecommendationRequest, @"Request type did not change");
}

- (void)testUpcomingEventsForArtistInitialization
{
    BITArtist *artist = [BITArtist artistNamed:@"You Blew It!"];
    BITRequest *request = [BITRequest upcomingEventsForArtist:artist];
    
    XCTAssertTrue(request.dates.type == kUpcomingDates, @"Request has wrong date range");
    XCTAssertTrue(request.requestType == kBITEventsRequest, @"Request has wrong request type");
    
    // Test to see if the request type changes when appropriate
    [request setSearchLocation:[BITLocation locationWithPrimaryString:@"New York City" andSecondaryString:@"NY"]
                     andRadius:@150];
    XCTAssert(request.requestType == kBITEventSearch, @"Request type did not change");
    
    [request includeRecommendationsExludingArtist:YES];
    XCTAssert(request.requestType == kBITRecommendationRequest, @"Request type did not change");
}

- (void)testEventsForArtistInDateRangeInitialization
{
    BITArtist *artist = [BITArtist artistNamed:@"You Blew It!"];
    BITDateRange *dateRange = [BITDateRange dateRangeWithStartDate:[NSDate dateWithTimeIntervalSince1970:300000000]
                                                        andEndDate:[NSDate dateWithTimeIntervalSince1970:300050000]];
    
    BITRequest *request = [BITRequest eventsForArtist:artist
                                          inDateRange:dateRange];
    XCTAssertTrue(request.dates.type == kDatesInRange, @"Request has wrong date range");
    XCTAssertTrue(request.requestType == kBITEventsRequest, @"Request has wrong request type");
    
    // Test to see if the request type changes when appropriate
    [request setSearchLocation:[BITLocation locationWithPrimaryString:@"New York City" andSecondaryString:@"NY"]
                     andRadius:@150];
    XCTAssert(request.requestType == kBITEventSearch, @"Request type did not change");
    
    [request includeRecommendationsExludingArtist:YES];
    XCTAssert(request.requestType == kBITRecommendationRequest, @"Request type did not change");
}

#pragma mark - URLRequestTests
- (void)testRequestURL
{
    BITRequest *artistRequest = [BITRequest artistRequestForName:@"You Blew It!"];
    BITRequest *mbidAritstRequest = [BITRequest artistRequestForMusicBrainzID:@"mbid_65f4f0c5-ef9e-490c-aee3-909e7ae6b2ab"];
    BITRequest *fbidArtistRequest = [BITRequest artistRequestForFacebookID:@"@fbid_6885814958"];
    
    BITArtist *artist = [BITArtist artistNamed:@"You Blew It!"];
    BITDateRange *dateRange = [BITDateRange dateRangeWithStartDate:[NSDate dateWithTimeIntervalSince1970:300000000]
                                                        andEndDate:[NSDate dateWithTimeIntervalSince1970:300050000]];
    BITLocation *location = [BITLocation locationWithPrimaryString:@"New York City" andSecondaryString:@"NY"];
    BITRequest *fullInitialization = [[BITRequest alloc] initWithArtist:artist
                                                            requestType:kBITEventSearch
                                                              dateRange:dateRange
                                                               location:location
                                                                 radius:@150];
    
    NSString *artistRequestString = [[[artistRequest urlRequest] URL] absoluteString];
    NSString *mbidRequestString = [[[mbidAritstRequest urlRequest] URL] absoluteString];
    NSString *fbidRequestString = [[[fbidArtistRequest urlRequest] URL] absoluteString];
    NSString *fullInitRequestString = [[[fullInitialization urlRequest] URL] absoluteString];
    
    // Check for characters that will screw up the http request
    XCTAssert([artistRequestString rangeOfString:@"(null)"].location == NSNotFound, @"String is null");
    XCTAssert([mbidRequestString rangeOfString:@"(null)"].location == NSNotFound, @"String is null");
    XCTAssert([fbidRequestString rangeOfString:@"(null)"].location == NSNotFound, @"String is null");
    XCTAssert([fullInitRequestString rangeOfString:@"(null)"].location == NSNotFound, @"String is null");

}

#pragma mark URL Parameter tests
- (void)testArtistNameString
{
    BITRequest *artistRequest = [BITRequest artistRequestForName:@"You Blew It!"];
    BITRequest *mbidAritstRequest = [BITRequest artistRequestForMusicBrainzID:@"mbid_65f4f0c5-ef9e-490c-aee3-909e7ae6b2ab"];
    BITRequest *fbidArtistRequest = [BITRequest artistRequestForFacebookID:@"@fbid_6885814958"];
    
    NSString *artistNameString = [artistRequest artistNameString];
    NSString *mbidNameString = [mbidAritstRequest artistNameString];
    NSString *fbidArtistString = [fbidArtistRequest artistNameString];
    
    // Check for characters that will screw up the http request
    XCTAssert([artistNameString rangeOfString:@"/"].location == NSNotFound, @"String contains illegal character");
    XCTAssert([mbidNameString rangeOfString:@"/"].location == NSNotFound, @"String contains illegal character");
    XCTAssert([fbidArtistString rangeOfString:@"/"].location == NSNotFound, @"String contains illegal character");
    XCTAssert([artistNameString rangeOfString:@"?"].location == NSNotFound, @"String contains illegal character");
    XCTAssert([mbidNameString rangeOfString:@"?"].location == NSNotFound, @"String contains illegal character");
    XCTAssert([fbidArtistString rangeOfString:@"?"].location == NSNotFound, @"String contains illegal character");
    XCTAssert([artistNameString rangeOfString:@"(null)"].location == NSNotFound, @"String is null");
    XCTAssert([mbidNameString rangeOfString:@"(null)"].location == NSNotFound, @"String is null");
    XCTAssert([fbidArtistString rangeOfString:@"(null)"].location == NSNotFound, @"String is null");
}

- (void)testLocationAndRadiusStrings
{
    BITArtist *artist = [BITArtist artistNamed:@"You Blew It!"];
    BITLocation *location = [[BITLocation alloc] initWithPrimaryString:@"New York City"
                                                    andSecondaryString:@"NY"];
    BITRequest *request = [[BITRequest alloc] initWithArtist:artist
                                                 requestType:kBITEventSearch
                                                   dateRange:[BITDateRange allEvents]
                                                    location:location
                                                      radius:@150];
    
    NSString *locationString = [request locationString];
    NSString *radiusString = [request radiusString];
    XCTAssertFalse([locationString isEqualToString:@""], @"No string for location");
    XCTAssertFalse([radiusString isEqualToString:@""], @"No radius for search");
    
    [request setLocation:nil];
    locationString = [request locationString];
    radiusString = [request radiusString];
    XCTAssertTrue([locationString isEqualToString:@""], @"Location still returning a value");
    XCTAssertTrue([radiusString isEqualToString:@""], @"Radius still returning a value");
}

- (void)testDateString
{
    BITRequest *request = [BITRequest artistRequestForName:@"You Blew It!"];
    BITDateRange *dateRange = [BITDateRange dateRangeWithStartDate:[NSDate dateWithTimeIntervalSince1970:300000000]
                                                        andEndDate:[NSDate dateWithTimeIntervalSince1970:300050000]];
    [request setDates:dateRange];
    
    NSString *dateString = [request dateString];
    XCTAssertFalse([dateString isEqualToString:@""], @"Date String is empty");
    
    [request setDates:nil];
    dateString = [request dateString];
    XCTAssertTrue([dateString isEqualToString:@""], @"Date string still returns value");
}

@end