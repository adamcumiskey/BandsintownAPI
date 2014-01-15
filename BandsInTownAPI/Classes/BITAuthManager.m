//
//  BITAuthManager.m
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/14/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import "BITAuthManager.h"

@implementation BITAuthManager

+ (id)sharedManager
{
    static BITAuthManager *sharedInstance = nil;
    
    if (sharedInstance != nil) {
        return sharedInstance;
    }
    
    static dispatch_once_t allocator;
    dispatch_once(&allocator, ^{
        sharedInstance = [[BITAuthManager alloc] init];
    });
    
    return sharedInstance;
}

+ (void)provideAppName:(NSString *)name
{
    // Make sure the name is valid
    NSAssert(name, @"App name cannot be nil");
    NSAssert(![name isEqualToString:@""], @"Name cannot be an empty string");
    NSAssert(![name isEqualToString:appName], @"Must provide unique app name for BandsInTownAPI");
    
    appName = name;
    [[self sharedManager] setAuthorized:YES];
}

- (NSString *)appName
{
    return appName;
}

@end
