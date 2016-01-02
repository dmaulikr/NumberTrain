//
//  GameArrayCollectionViewController.h
//  NumberTrain
//
//  Created by Student FH-Aachen on 31.12.15.
//  Copyright © 2015 David Kurtz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"

@interface GameArrayCollectionViewController : UICollectionViewController

@property (nonatomic, readwrite) Player* player;
@property (nonatomic, readwrite) UILabel *scoreLabel;

@end
