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

@end
