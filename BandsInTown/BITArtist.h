//
//  BITArtist.h
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/14/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^artistImageCompletionHandler)(BOOL success,
                                             UIImage *artistImage,
                                             NSError *error);

@interface BITArtist : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *mbid;
@property (strong, nonatomic) NSURL *imageURL;
@property (strong, nonatomic) NSURL *thumbURL;
@property (strong, nonatomic) NSString *facebookTourDatesURLString;
@property (strong, nonatomic) NSNumber *numberOfUpcomingEvents;

- (id)initWithDictionary:(NSDictionary *)dictonary;

// Uses an NSURLConnection to asynchronously grab the artist image.
// The image is passed back through the completion handler.
- (void)requestImageWithCompletionHandler:(artistImageCompletionHandler)completionHandler;

@end
