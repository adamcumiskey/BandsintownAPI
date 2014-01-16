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

@property (strong, nonatomic) BITArtist *artist;
@property (strong, nonatomic) NSArray *events;

- (id)initWithArtist:(BITArtist *)artist;
- (id)initWithEvents:(NSArray *)events;

@end
