//
//  BITAuthManager.h
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/14/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BITAuthManager : NSObject

@property (nonatomic, getter = isAuthorized) BOOL authorized;

+ (id)sharedManager;
+ (void)provideAppName:(NSString *)name;

+ (NSString *)appID;

@end
