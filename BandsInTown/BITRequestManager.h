//
//  BITRequestManager.h
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/15/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BITRequest;
@class BITResponse;


typedef void (^requestCompletionHandler)(BOOL success,
                                         BITResponse *response,
                                         NSError *error);



@interface BITRequestManager : NSObject

+ (void)sendRequest:(BITRequest *)request
    withCompletionHandler:(requestCompletionHandler)completionHandler;

@end
