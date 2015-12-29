//
//  GameValue.m
//  NumberTrain
//
//  Created by Student FH-Aachen on 29.12.15.
//  Copyright © 2015 David Kurtz. All rights reserved.
//

#import "GameValue.h"

@interface GameValue ()

@property (nonatomic, readwrite) GameValueType ValueType;
@property (nonatomic, readwrite) NSInteger NumericalValue;

@end

@implementation GameValue

static NSMutableDictionary<NSNumber*, GameValue*>* numericalValuesDict = nil;

#pragma initializers

-(instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.NumericalValue = -1;
        self.ValueType = Undefined;
    }
    return self;
}

-(instancetype)initWithNumericalValue:(NSInteger)numericalValue
{
    self = [self init];
    
    if (self)
    {
        self.NumericalValue = numericalValue;
        self.ValueType = Numerical;
    }
    return self;
}

-(instancetype)initAsEmpty
{
    self = [self init];
    
    if (self)
    {
        self.ValueType = Empty;
    }
    return self;
}

-(instancetype)initAsJoker
{
    self = [self init];
    
    if (self)
    {
        self.ValueType = Joker;
    }
    return self;
}


+(GameValue*)valueFromNumericalValue:(NSInteger)numericalValue
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        numericalValuesDict = [[NSMutableDictionary alloc] init];
    });
    
    // tries to get a singleton instance for the given numerical value
    // creates one if no instance exists
    GameValue* value = [numericalValuesDict objectForKey:[NSNumber numberWithInteger:numericalValue]];
    if (!value) {
        value = [[GameValue alloc] initWithNumericalValue:numericalValue];
        [numericalValuesDict setObject:value forKey:[NSNumber numberWithInteger:numericalValue]];
    }
    return value;
}

+(GameValue*)valueAsEmpty
{
    static GameValue* emptyGameValue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        emptyGameValue = [[self alloc] initAsEmpty];
    });
    return emptyGameValue;
}

+(GameValue*)valueAsJoker
{
    static GameValue* jokerGameValue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        jokerGameValue = [[self alloc] initAsJoker];
    });
    return jokerGameValue;
}

#pragma implementation

-(NSInteger)getNumericalValue
{
    return self.NumericalValue;
}

@end
