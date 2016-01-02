//
//  Player.m
//  NumberTrain
//
//  Created by Student FH-Aachen on 31.12.15.
//  Copyright © 2015 David Kurtz. All rights reserved.
//

#import "Player.h"
#import "GameArray.h"
#import "Game.h"

@interface Player () <GameObserver>

@property (nonatomic) NSMutableArray* observers;
-(void)notifyObserversAboutChangedValue:(GameValue*)value AtIndex:(NSInteger)index;
-(void)notifyObserversAboutNextValue:(GameValue*)value;
-(void)notifyObserversAboutScore;

@property (nonatomic, readwrite) GameArray* gameArray;
@property (nonatomic, readwrite) Game* game;

@end

@implementation Player

-(instancetype)initWithDefaultSize
{
    self = [super init];
    if (self)
    {
        self.gameArray = [[GameArray alloc]initWithDefaultSize];
    }
    return self;
}

-(instancetype)initWithSize:(NSInteger)size
{
    self = [super init];
    if (self)
    {
        self.gameArray = [[GameArray alloc]initWithSize:size];
    }
    return self;
}

-(NSMutableArray*)observers
{
    if (!_observers) {
        _observers = [[NSMutableArray alloc] init];
    }
    return _observers;
}

-(NSInteger)size
{
    return self.gameArray.size;
}

-(GameValue*)getValueAtIndex:(NSInteger)index
{
    return [self.gameArray getValueAtIndex:index];
}

-(void)setValue:(GameValue *)value atIndex:(NSInteger)index
{
    [self.gameArray setValue:value AtIndex:index];
    [self notifyObserversAboutChangedValue:value AtIndex:index];
    [self notifyObserversAboutScore];
    [self.game valuePlacedByPlayer:self];
}

-(void)Game:(Game *)game DidGetNextValue:(GameValue *)value
{
    [self notifyObserversAboutNextValue:value];
    self.game = game;
    // TODO: besser machen
}

-(void)addObserver:(NSObject<PlayerObserver> *)observer
{
    if (observer == nil) return;
    [self.observers addObject:observer];
}

-(void)removeObserver:(NSObject<PlayerObserver> *)observer
{
    if (observer == nil || !_observers) return;
    [self.observers removeObject:observer];
}

-(void)notifyObserversAboutNextValue:(GameValue *)value
{
    if (!_observers) return;
    for (NSObject<PlayerObserver>* observer in self.observers) {
        [observer Player:self DidReceiveNextValue:value];
    }
}

-(void)notifyObserversAboutChangedValue:(GameValue *)value AtIndex:(NSInteger)index
{
    if (!_observers) return;
    for (NSObject<PlayerObserver>* observer in self.observers) {
        [observer Player:self DidChangeValue:value AtIndex:index];
    }
}

-(void)notifyObserversAboutScore
{
    if (!_observers) return;
    for (NSObject<PlayerObserver>* observer in self.observers) {
        [observer Player:self DidFinishWithScore:[self.gameArray calculateScore]];
    }
}

@end
