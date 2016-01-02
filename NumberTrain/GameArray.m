//
//  GameArray.m
//  NumberTrain
//
//  Created by Student FH-Aachen on 29.12.15.
//  Copyright © 2015 David Kurtz. All rights reserved.
//

#import "GameArray.h"

static NSInteger const DefaultSize = 20;

@interface GameArray ()

@property (nonatomic, readwrite) NSInteger size;
@property (nonatomic, readwrite) NSMutableArray<GameValue*>* array;

@end

@implementation GameArray

-(instancetype)initWithDefaultSize
{
    self = [super init];
    if (self) {
        self.size = DefaultSize;
    }
    return self;
}

-(instancetype)initWithSize:(NSInteger)size
{
    self = [super init];
    if (self) {
        if (size <= 0)
            self.size = DefaultSize;
        else
            self.size = size;
    }
    return self;
}

-(NSMutableArray<GameValue*>*)array
{
    if (!_array) {
        _array = [[NSMutableArray alloc] initWithCapacity:self.size];
    }
    return _array;
}

-(void)setValue:(GameValue *)value AtIndex:(NSInteger)index
{
    if (index < 0 || index >= self.size)
        return;
    
    if (index >= self.array.count)
    {
        while (self.array.count <= index) {
            [self.array addObject:[GameValue valueAsEmpty]];
        }
    }
    
    [self.array replaceObjectAtIndex:index withObject:value];
}

-(GameValue*)getValueAtIndex:(NSInteger)index
{
    if (index < 0 || index >= self.size)
        return nil;
    
    if (!_array || index >= self.array.count)
        return [GameValue valueAsEmpty];
    
    return [self.array objectAtIndex:index];
}

-(NSInteger)calculateScore
{
    static NSArray<NSNumber*>* scores = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        scores = @[
                   @0, // 0
                   @0,
                   @0,
                   @1,
                   @2,
                   @4, // 5
                   @6,
                   @8,
                   @10,
                   @12,
                   @14, // 10
                   @17,
                   @20,
                   @23,
                   @27,
                   @31, // 15
                   @35,
                   @39,
                   @44,
                   @49,
                   @56  // 20
                   ];
    });
    
    int score = 0;
    int streak = 0;
    GameValue* lastValue = [GameValue valueAsEmpty];
    GameValue* lastValueBeforeJoker = [GameValue valueAsEmpty];
    
    for (GameValue* value in self.array)
    {
        if (value.valueType == Empty || value.valueType == Undefined) return -1;
        
        switch (value.valueType) {
            case Numerical:
                if ((lastValue.valueType == Joker
                        && [value getNumericalValue] >= [lastValueBeforeJoker getNumericalValue])
                    || (lastValue.valueType == Numerical
                        && [value getNumericalValue] >= [lastValue getNumericalValue]))
                {
                    ++streak;
                }
                else
                {
                    score += scores[streak].integerValue;
                    streak = 1;
                }
                break;
                
            case Joker:
                // ToDo: for ambigous joker placements calculate the streak in favor of the player
                // eg. 123*2457 would seperate it like 123|*2457 instead of 123*|2457
                ++streak;
                if (lastValue.valueType != Joker)
                    lastValueBeforeJoker = lastValue;
                break;
                
            case Undefined:
            default:
                return -1;
        }
        
        lastValue = value;
    }
    
    score += scores[streak].integerValue;
 
    return score;
}



@end
