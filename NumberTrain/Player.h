//
//  Player.h
//  NumberTrain
//
//  Created by Student FH-Aachen on 31.12.15.
//  Copyright © 2015 David Kurtz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameValue.h"

@class Player;

@protocol PlayerObserver

-(void)Player:(Player*)player DidChangeValue:(GameValue*)value AtIndex:(NSInteger)index;
-(void)Player:(Player*)player DidReceiveNextValue:(GameValue*)value;
-(void)Player:(Player*)player DidFinishWithScore:(NSInteger)score;

@end

@interface Player : NSObject

-(instancetype)initWithSize:(NSInteger)size;
-(instancetype)initWithDefaultSize;

@property (nonatomic, readonly) NSInteger size;

-(GameValue*)getValueAtIndex:(NSInteger)index;
-(void)setValue:(GameValue*)value atIndex:(NSInteger)index;

-(void)addObserver:(NSObject<PlayerObserver>*)observer;
-(void)removeObserver:(NSObject<PlayerObserver>*)observer;

@end
