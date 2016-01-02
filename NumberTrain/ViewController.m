//
//  ViewController.m
//  NumberTrain
//
//  Created by Student FH-Aachen on 29.12.15.
//  Copyright © 2015 David Kurtz. All rights reserved.
//

#import "ViewController.h"
#import "Game.h"
#import "GameArrayCollectionViewController.h"
#import "Player.h"

@interface ViewController () <GameObserver>
@property (weak, nonatomic) IBOutlet UILabel *currentValueLabel;

@property (nonatomic, readwrite) Game* game;
@property (nonatomic, readwrite) GameArrayCollectionViewController* player1;
@property (nonatomic, readwrite) GameArrayCollectionViewController* player2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentValueLabel.text = @"/";
    self.game = [[Game alloc] initWithDefaultNumberBagAndSize];
    [self.game addObserver:self];
    
    Player* player1 = [[Player alloc]initWithSize:self.game.arraySize];
    [self.game addObserver:player1];
    [player1 addObserver:self.player1];
    self.player1.player = player1;
    
    
    Player* player2 = [[Player alloc]initWithSize:self.game.arraySize];
    [self.game addObserver:player2];
    [player2 addObserver:self.player2];
    self.player2.player = player2;

    
    [self.game startGame];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString* segueName = segue.identifier;
    if ([segueName isEqualToString: @"player1"]) {
        self.player1  = (GameArrayCollectionViewController*) [segue destinationViewController];
        self.player1.scoreLabel = self.scoreLabel1;
    }
    else if ([segueName isEqualToString: @"player2"]) {
        self.player2  = (GameArrayCollectionViewController*) [segue destinationViewController];
        self.player2.scoreLabel = self.scoreLabel2;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)Game:(Game *)game DidGetNextValue:(GameValue *)value
{
    self.currentValueLabel.text = [value description];
}

@end
