//
//  LocationManager.h
//  JETest
//
//  Created by Trevor Doodes on 12/04/2016.
//  Copyright © 2016 Trevor Doodes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationServicesManager : NSObject

typedef void (^success)(NSString *outCode);
typedef void (^failure)(NSError *error);

- (void)outCodeForLocationWithSuccess:(success)success
                              failure:(failure)failure;
@end
