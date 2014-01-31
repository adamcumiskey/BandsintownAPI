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

typedef NS_ENUM(NSInteger, BITArtistNameType){
    kBITArtistNameTypeString,
    kBITArtistNameTypeMusicBrainzID,
    kBITArtistNameTypeFacebookID
};

typedef void (^artistImageCompletionHandler)(BOOL success,
                                             UIImage *artistImage,
                                             NSError *error);

@interface BITArtist : NSObject

@property (strong, nonatomic) NSString *name; // Name of the artist
@property (strong, nonatomic) NSString *mbid; // MusicBrainz ID
@property (strong, nonatomic) NSString *fbid; // Facebook ID
@property (strong, nonatomic) NSURL *imageURL; // URL for full size image
@property (strong, nonatomic) NSURL *thumbURL; // URL for thumbnail image
@property (strong, nonatomic) NSURL *facebookTourDatesURL; // URL to the facebook tour page
@property (strong, nonatomic) NSNumber *numberOfUpcomingEvents; // Count of the number of upcoming events
@property (nonatomic) BITArtistNameType artistNameType;

// When parsing data from the JSON response, use this method to parse into the BITArtist object
- (id)initWithDictionary:(NSDictionary *)dictonary;

// These methods are used to construct a BITArtist object when performing a request
- (id)initWithName:(NSString *)name;
- (id)initWithMusicBrainzID:(NSString *)mbid;
- (id)initWithFacebookID:(NSString *)fbid;

// Class initializers for convience
+ (instancetype)artistNamed:(NSString *)artistName;
+ (instancetype)artistForMusicBrainzID:(NSString *)mbid;
+ (instancetype)artistForFacebookID:(NSString *)fbid;

// Uses an NSURLConnection to asynchronously grab the artist image.
// The image is passed back through the completion handler.
- (void)requestImageWithCompletionHandler:(artistImageCompletionHandler)completionHandler;

// Returns a string for the artist_id parameter of the request if it has one
// *** Currently not going to bother trying to support this *** //
//- (NSString *)artistID;

@end
