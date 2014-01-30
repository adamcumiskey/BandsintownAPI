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
