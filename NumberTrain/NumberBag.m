//
//  NumberBag.m
//  NumberTrain
//
//  Created by Student FH-Aachen on 31.12.15.
//  Copyright © 2015 David Kurtz. All rights reserved.
//

#import "NumberBag.h"

@interface NumberBag ()

@property (nonatomic, readwrite) NSMutableArray<GameValue*>* array;
@property (nonatomic, readwrite) NSInteger countOverall;

@end

@implementation NumberBag

+(NumberBag*)numberBagFromDefault
{
    NSMutableArray<GameValue*>* defaultValues = [[NSMutableArray alloc]init];
    
    for (NSInteger i = 1; i<=30; ++i) {
        [defaultValues addObject:[GameValue valueFromNumericalValue:i]];
    }
    
    for (NSInteger i = 11; i<=19; ++i) {
        [defaultValues addObject:[GameValue valueFromNumericalValue:i]];
    }
    
    for (NSInteger i = 0; i<5; ++i) {
        [defaultValues addObject:[GameValue valueAsJoker]];
    }
    
    return [NumberBag numberBagFromArray:defaultValues];
}

+(NumberBag*)numberBagFromArray:(NSArray<GameValue *> *)values
{
    NumberBag* numberBag = [[NumberBag alloc] init];
    
    numberBag.array = [NSMutableArray arrayWithArray:values];
    numberBag.countOverall = numberBag.array.count;
    
    return numberBag;
}

-(NSInteger)countLeft
{
    return self.array.count;
}

-(NSArray<GameValue*>*)remainingValues
{
    return [self.array copy];
}

-(GameValue*)getNextValue
{
    int randomIndex = arc4random_uniform((u_int32_t)self.array.count);
    GameValue* removedValue = [self.array objectAtIndex:randomIndex];
    [self.array removeObjectAtIndex:randomIndex];
    return removedValue;
}

@end
