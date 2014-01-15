//
//  BITAuthManager.h
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/14/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *appName = @"YOUR_APP_NAME";

@interface BITAuthManager : NSObject

@property (nonatomic, getter = isAuthorized) BOOL authorized;

+ (id)sharedManager;
+ (void)provideAppName:(NSString *)name;

- (NSString *)appName;

@end
