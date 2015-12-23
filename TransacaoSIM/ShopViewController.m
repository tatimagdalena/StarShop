//
//  ShopViewController.m
//  TransacaoSIM
//
//  Created by Tatiana Magdalena on 17/12/15.
//  Copyright © 2015 Tatiana Magdalena. All rights reserved.
//

#import "ShopViewController.h"

@interface ShopViewController ()

@end



@implementation ShopViewController

static NSString * const reuseIdentifier = @"Cell";



#pragma mark ViewController methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    _productNames = [NSArray arrayWithObjects:@"Salto Sabre de Luz", @"Uva Yoda", @"Chuveiro Crying Vader", @"Sopa Chewie", @"Band-aid Star Wars", nil];
    _productImageNames = [NSArray arrayWithObjects:@"Sapatos StarWars.png", @"Uva StarWars.png", @"Chuveiro StarWars.png", @"Sopa StarWars.png", @"Band-aid StarWars.png", nil];
    //_productPrices = [NSArray arrayWithObjects: [NSNumber numberWithFloat:200.0f], [NSNumber numberWithFloat:10.0f], [NSNumber numberWithFloat:500.0f], [NSNumber numberWithFloat:15.0f], [NSNumber numberWithFloat:5.0f], nil];
    _productPrices = [NSArray arrayWithObjects:@"200.00", @"10.00", @"500.00", @"15.00", @"5.00", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     //Get the new view controller using [segue destinationViewController].
     //Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"buy"]) {
        
        NSLog(@"prepareforsegue");
        
        PaymentTableViewController *buyVC = [segue destinationViewController];
        buyVC.productName = [_productNames objectAtIndex:[sender tag]];
        buyVC.productImageName = [_productImageNames objectAtIndex:[sender tag]];
        buyVC.productPrice = [_productPrices objectAtIndex:[sender tag]];
    }
}



#pragma mark - <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _productNames.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ShopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    UIImage *image = [UIImage imageNamed: [_productImageNames objectAtIndex:indexPath.row]];
    cell.productImage.image = image;
    cell.productImage.layer.borderWidth = 1.0f;
    cell.productImage.layer.masksToBounds = NO;
    cell.productImage.layer.borderColor = [[UIColor clearColor]CGColor];
    cell.productImage.layer.cornerRadius = cell.productImage.frame.size.height/2.1;
    cell.productImage.clipsToBounds = YES;
    
    cell.productName.text = [_productNames objectAtIndex:indexPath.row];
    cell.productValue.text = [@"$" stringByAppendingString:[_productPrices objectAtIndex:indexPath.row]];
    
    cell.buyButton.layer.cornerRadius = 8.0f;
    cell.buyButton.clipsToBounds = YES;
    cell.buyButton.layer.borderWidth = 0.3f;
    cell.buyButton.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    [cell.buyButton setTag:indexPath.row];
    
    return cell;
}



#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
