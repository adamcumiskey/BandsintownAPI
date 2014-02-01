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
//  BITResponse.m
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/15/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import "BITResponse.h"

#import "BITEvent.h"

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
		
		//The first artist for the event will always be the one from the request
		if (_events && [_events count] > 0 && [[[_events objectAtIndex:0] artists] count] > 0) {
			_artist = [[[_events objectAtIndex:0] artists] objectAtIndex:0];
		}
    }
    
    return self;
}

@end
