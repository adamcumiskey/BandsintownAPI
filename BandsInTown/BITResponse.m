//
//  BITResponse.m
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/15/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import "BITResponse.h"

@implementation BITResponse

- (id)initWithArtist:(BITArtist *)artist fromResponse:(NSString *)rawResponse
{
    if (self = [super init]) {
        _artist = artist;
		_rawResponse = rawResponse;
    }
    
    return self;
}

- (id)initWithEvents:(NSArray *)events fromResponse:(NSString *)rawResponse
{
    if (self = [super init]) {
        _events = events;
		_rawResponse = rawResponse;
    }
    
    return self;
}

@end
