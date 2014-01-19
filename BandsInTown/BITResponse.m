//
//  BITResponse.m
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/15/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import "BITResponse.h"

@implementation BITResponse

- (id)initWithArtist:(BITArtist *)artist
{
    if (self = [super init]) {
        _artist = artist;
    }
    
    return self;
}

- (id)initWithEvents:(NSArray *)events
{
    if (self = [super init]) {
        _events = events;
    }
    
    return self;
}

@end
