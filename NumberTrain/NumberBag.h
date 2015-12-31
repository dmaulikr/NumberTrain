//
//  NumberBag.h
//  NumberTrain
//
//  Created by Student FH-Aachen on 31.12.15.
//  Copyright © 2015 David Kurtz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameValue.h"

@interface NumberBag : NSObject

@property (nonatomic, readonly) NSInteger countOverall;
@property (nonatomic, readonly) NSInteger countLeft;

-(GameValue*)getNextValue;
-(NSArray<GameValue*>*)remainingValues;

+(NumberBag*)numberBagFromDefault;
+(NumberBag*)numberBagFromArray:(NSArray<GameValue*>*)values;

@end
