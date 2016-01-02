//
//  GameValue.m
//  NumberTrain
//
//  Created by Student FH-Aachen on 29.12.15.
//  Copyright © 2015 David Kurtz. All rights reserved.
//

#import "GameValue.h"

@interface GameValue ()

@property (nonatomic, readwrite) GameValueType valueType;
@property (nonatomic, readwrite) NSInteger numericalValue;

@end

@implementation GameValue

static NSMutableDictionary<NSNumber*, GameValue*>* numericalValuesDict = nil;

#pragma initializers

-(instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.numericalValue = -1;
        self.valueType = Undefined;
    }
    return self;
}

-(instancetype)initWithNumericalValue:(NSInteger)numericalValue
{
    self = [self init];
    
    if (self)
    {
        self.numericalValue = numericalValue;
        self.valueType = Numerical;
    }
    return self;
}

-(instancetype)initAsEmpty
{
    self = [self init];
    
    if (self)
    {
        self.valueType = Empty;
    }
    return self;
}

-(instancetype)initAsJoker
{
    self = [self init];
    
    if (self)
    {
        self.valueType = Joker;
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
    return self.numericalValue;
}

-(NSString*)description
{
    switch (self.valueType) {
        case Numerical:
            return [NSString stringWithFormat:@"%ld", (long)self.numericalValue];
            
        case Empty:
            return @"Empty";
            
        case Joker:
            return @"Joker";
            
        default:
            return @"Undefined";
    }
}

-(NSString*)displayText
{
    switch (self.valueType) {
        case Numerical:
            return [NSString stringWithFormat:@"%ld", (long)self.numericalValue];
            
        case Empty:
            return @"";
            
        case Joker:
            return @"*";
            
        default:
            return @"/";
    }
}

@end
