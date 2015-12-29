//
//  GameArray.h
//  NumberTrain
//
//  Created by Student FH-Aachen on 29.12.15.
//  Copyright © 2015 David Kurtz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameValue.h"

@interface GameArray : NSObject

-(instancetype)initWithSize:(NSInteger)size;

@property (nonatomic, readonly) NSInteger size;

-(void)insertValue:(GameValue*)value AtIndex:(NSInteger)index;

-(GameValue*)getValueAtIndex:(NSInteger)index;

@end
