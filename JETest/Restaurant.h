//
//  Restaurant.h
//  JETest
//
//  Created by Trevor Doodes on 06/04/2016.
//  Copyright © 2016 Trevor Doodes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Restaurant : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *rating;
@property (nonatomic, strong, readonly) NSArray *foodTypes;


- (instancetype)initWithName:(NSString *)name rating:(NSString *)rating foodTypes:(NSArray *) foodTypes;


@end
