//
//  GameValue.h
//  NumberTrain
//
//  Created by Student FH-Aachen on 29.12.15.
//  Copyright © 2015 David Kurtz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, GameValueType)
{
    Undefined,
    Empty,
    Numerical,
    Joker
};

@interface GameValue : NSObject

+(GameValue*)valueFromNumericalValue:(NSInteger)numericalValue;

+(GameValue*)valueAsEmpty;

+(GameValue*)valueAsJoker;

@property (nonatomic, readonly) GameValueType ValueType;

-(NSInteger)getNumericalValue;

@end
