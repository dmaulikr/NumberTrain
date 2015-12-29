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

-(void)insertValue:(GameValue *)value AtIndex:(NSInteger)index
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
    
    if (index >= self.array.count)
        return [GameValue valueAsEmpty];
    
    return [self.array objectAtIndex:index];
}

@end
