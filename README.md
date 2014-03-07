#BandsInTownAPI
Objective-C API wrapper for the BandsInTown API (http://www.bandsintown.com/api/overview).
##Installation
Intstall using Cocoapods! Just add `pod 'BandsintownAPI', '~> 0.1.0'` to your Podfile and run `pod install` on the command line.

__REQUIRED__: In the app delegate, register a name for your app in the application:didFinishLaunchingWithOptions: method

    #import "MyAppNameDelegate.h"
    #import <BandsintownAPI/Bandsintown.h>
    
    @implementation MyAppNameDelegate
    
    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
    {
        [BITAuthManager provideAppName:@"MyAppName"];
        
        // Override point for customization after application launch.
        return YES;
    }

##Creating Requests
Requests are divided into 4 categories.

- __Artist__ requests provide basic information about an artist along with links to the Facebook events page.
- __Event__ requests provide all events for an artist within a given date range
- __Event search__ requests provide all events for an artist within a date range and location
- __Recommendations__ requests provide the same information as the event search, but also allow for recommended artists to be included. The original artist can also be filtered out.

###Artist Request
Artists can be found using either a name, Music Brainz ID, or Facebook ID. There are several class methods will return an artist request object. To not mutate these objects after creating them, as they are designed to only be used for artist requests.

    + (instancetype)artistRequestForName:(NSString *)artistName;
    + (instancetype)artistRequestForFacebookID:(NSString *)facebookID;
    + (instancetype)artistRequestForMusicBrainzID:(NSString *)mbid;
    
###Event request
Events can be searched for within a given BITDateRange. There are several methods that simplify this process

    + (instancetype)allEventsForArtist:(BITArtist *)artist;
    + (instancetype)upcomingEventsForArtist:(BITArtist *)artist;
    + (instancetype)eventsForArtist:(BITArtist *)artist
                        inDateRange:(BITDateRange *)dateRange;
                        
To manually search a date range for an artist,

    // Create artist
    BITArtist *artist = [BITArtist artistNamed:@"Tera Melos"];
    
    // Date range for the next 30 days
    BITDateRange *dateRange = [BITDateRange dateRangeWithStartDate:[NSDate date]
                                                        andEndDate:[NSDate dateWithTimeIntervalSinceNow:2592000]];
                                                        
    // Create the request
    BITRequest *request = [BITRequest eventsForArtist:artist
                                          inDateRange:dateRange];
                                          
###Event search
Event searches are created by adding a BITLocation to an Event request. BITLocations can be created using strings (city/state in the US and Canada, city/country elsewhere) or with a CLLocationCoordinate2d. The setSearchLocation:andRadius instance method is useful for changing a event request into an event search.

      // Create the location
    BITLocation *location = [BITLocation locationWithPrimaryString:@"New York"
                                                andSecondaryString:@"NY"];
    
    // Create events request
    BITRequest *request = [BITRequest eventsForArtist:[BITArtist artistNamed:@"You Blew It!"]
                                          inDateRange:[BITDateRange upcomingEvents]];
    
    // Add the location to the search
    [request setSearchLocation:location
                     andRadius:@150];
  
###Recommendation search
Recommendation searches are created by calling the instance method includeRecommendationsExcludingArtist: on an event search request. The when the excludingArtist parameter is set to YES, the original artist in the search will not be listed in the results. Continuing from the previous example

    // Only get events from recommended artists
    [request includeRecommendationsExcludingArtist:YES];

##Sending requests
To send a request, simply call the [BITRequestManager sendRequest:withCompletionHandler:] method. The response is passed back in a block. If the request is successful, the block will have a BITResponse object parameter. If the request was for an artist, the artist paremeter of the BITResponse will be set with the data from the API. All other requests will have an array of BITEvent objects as the events parameter. If you want to manually parse the JSON response, the rawData parameter contains the JSON string the response was parsed from.

    // Send an event request
    [BITRequestManager sendRequest:request
             withCompletionHandler:^(BOOL success,
                                     BITResponse *response,
                                     NSError *error) {
                 if (!success) {
                     NSLog(@"Error: %@", error.localizedDescription);
                 } else {
                     NSLog(@"Raw Data: %@", [response rawResponse]);
                     
                     for (BITEvent *event in [response events]) {
                         NSLog(@"Event Name: %@", [event title]);
                     }
                 }
             }];

##Legal
This work is licenced under the LGPL. Please refer to the LICENCE.md file for more information.
