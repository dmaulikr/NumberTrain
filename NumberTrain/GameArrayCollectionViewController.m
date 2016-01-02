//
//  GameArrayCollectionViewController.m
//  NumberTrain
//
//  Created by Student FH-Aachen on 31.12.15.
//  Copyright © 2015 David Kurtz. All rights reserved.
//

#import "GameArrayCollectionViewController.h"
#import "ViewController.h"
#import "Player.h"
#import "GameValue.h"

@interface GameArrayCollectionViewController () <PlayerObserver>

@property (nonatomic, readwrite, strong) GameValue* currentValue;


@end

@implementation GameArrayCollectionViewController

-(void)Player:(Player *)player DidChangeValue:(GameValue *)value AtIndex:(NSInteger)index
{
    NSIndexPath* indexPath =[NSIndexPath indexPathForItem:index inSection:0];
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
}

-(void)Player:(Player *)player DidReceiveNextValue:(GameValue *)value
{
    self.currentValue = value;
}

-(void)Player:(Player *)player DidFinishWithScore:(NSInteger)score
{
    self.scoreLabel.text = [NSString stringWithFormat:@"%ld", (long)score];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scoreLabel.text = @"Score: ";
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.currentValue) return;
    
    if ([self.player getValueAtIndex:indexPath.item].valueType != Empty) return;
    
    GameValue* valueToSend = self.currentValue;
    self.currentValue = nil;
    [self.player setValue:valueToSend atIndex:indexPath.item];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifier = @"Cell";
    
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UILabel* label = (UILabel*)[cell viewWithTag:100];
    
    if (self.player)
    {
        label.text = [[self.player getValueAtIndex:indexPath.item]displayText];
    }
    else
    {
        label.text = @"";
    }
    
    return cell;
}

@end
