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
//  BITAuthManager.m
//  BandsInTownAPI
//
//  Created by Adam Cumiskey on 1/14/14.
//  Copyright (c) 2014 Adam Cumiskey. All rights reserved.
//

#import "BITAuthManager.h"

static NSString *appName = @"";

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

+ (NSString *)appID
{
    return appName;
}

@end
