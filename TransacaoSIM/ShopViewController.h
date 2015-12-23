//
//  ShopViewController.h
//  TransacaoSIM
//
//  Created by Tatiana Magdalena on 17/12/15.
//  Copyright © 2015 Tatiana Magdalena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCollectionViewCell.h"
#import "PaymentTableViewCell.h"
#import "PaymentTableViewController.h"

@interface ShopViewController : UICollectionViewController

@property (strong, nonatomic) NSArray *productNames;
@property (strong, nonatomic) NSArray *productImageNames;
@property (strong, nonatomic) NSArray *productPrices;

@end
