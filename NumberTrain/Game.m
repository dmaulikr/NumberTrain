//
//  Game.m
//  NumberTrain
//
//  Created by Student FH-Aachen on 31.12.15.
//  Copyright © 2015 David Kurtz. All rights reserved.
//

#import "Game.h"
#import "NumberBag.h"

@interface Game ()

@property (nonatomic) NSMutableArray* observers;
-(void)notifyObserversAboutNextValue:(GameValue*)value;

@property (nonatomic, readwrite) NumberBag* numberBag;
@property (nonatomic, readwrite) NSInteger arraySize;
@property (nonatomic, readwrite) GameValue* lastValue;

@property (nonatomic, readwrite) NSInteger round;
@property (nonatomic, readwrite) NSMutableArray* answeredPlayers;

-(void)nextValue;
-(void)checkWhetherAllPlayersHaveAnswered;

@end

@implementation Game

-(instancetype)initWithDefaultNumberBagAndSize
{
    self = [super init];
    if (self) {
        self.numberBag = [NumberBag numberBagFromDefault];
        self.arraySize = 20;
        self.answeredPlayers = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void)startGame
{
    [self nextValue];
}

-(void)nextValue
{
    if (++self.round <= self.arraySize)
    {
        GameValue* value = [self.numberBag getNextValue];
        self.lastValue = value;
        [self.answeredPlayers removeAllObjects];
        [self notifyObserversAboutNextValue:value];
    }
}

#warning TODO: add another Observer protocol that is used by the Game class, while the current one is used for ViewControllers
-(void)valuePlacedByPlayer:(Player *)player
{
    if (player == nil) return;
    
    if (![self.answeredPlayers containsObject:player] && [self.observers containsObject:player])
    {
        [self.answeredPlayers addObject:player];
        [self checkWhetherAllPlayersHaveAnswered];
    }
}

-(void)checkWhetherAllPlayersHaveAnswered
{
    // minus 1 because viewcontroller is an observer too
    if (self.answeredPlayers.count == self.observers.count - 1) {
        [self nextValue];
    }
}

-(NSMutableArray*)observers
{
    if (!_observers) {
        _observers = [[NSMutableArray alloc] init];
    }
    return _observers;
}


-(void)addObserver:(NSObject<GameObserver> *)observer
{
    if (observer == nil) return;
    [self.observers addObject:observer];
}

-(void)removeObserver:(NSObject<GameObserver> *)observer
{
    if (observer == nil || !_observers) return;
    [self.observers removeObject:observer];
}

-(void)notifyObserversAboutNextValue:(GameValue *)value
{
    if (!_observers) return;
    for (NSObject<GameObserver>* observer in self.observers) {
        [observer Game:self DidGetNextValue:value];
    }

}

@end
