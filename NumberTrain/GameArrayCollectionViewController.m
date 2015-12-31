//
//  GameArrayCollectionViewController.m
//  NumberTrain
//
//  Created by Student FH-Aachen on 31.12.15.
//  Copyright © 2015 David Kurtz. All rights reserved.
//

#import "GameArrayCollectionViewController.h"

@implementation GameArrayCollectionViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
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
    label.text = @"4";
    
    return cell;
}

@end
