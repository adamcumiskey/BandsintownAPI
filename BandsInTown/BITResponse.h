//
//  BITResponse.h
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/15/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BITArtist;

@interface BITResponse : NSObject

@property (strong, nonatomic) NSString *rawResponse;
@property (strong, nonatomic) BITArtist *artist;
@property (strong, nonatomic) NSArray *events;

- (id)initWithArtist:(BITArtist *)artist fromResponse:(NSString *)rawResponse;
- (id)initWithEvents:(NSArray *)events fromResponse:(NSString *)rawResponse;

@end
