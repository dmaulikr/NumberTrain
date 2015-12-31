//
//  Game.h
//  NumberTrain
//
//  Created by Student FH-Aachen on 31.12.15.
//  Copyright © 2015 David Kurtz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameValue.h"
#import "Player.h"

@class Game;

@protocol GameObserver

-(void)Game:(Game*)game DidGetNextValue:(GameValue*)value;

@end

@interface Game : NSObject

-(instancetype)initWithDefaultNumberBagAndSize;

@property (nonatomic, readonly) NSInteger arraySize;
@property (nonatomic, readonly) GameValue* lastValue;

-(void)startGame;
-(void)valuePlacedByPlayer:(Player*)player;

-(void)addObserver:(NSObject<GameObserver>*)observer;
-(void)removeObserver:(NSObject<GameObserver>*)observer;

@end
