//
//  ShopCollectionViewCell.h
//  TransacaoSIM
//
//  Created by Tatiana Magdalena on 17/12/15.
//  Copyright © 2015 Tatiana Magdalena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *productImage;
@property (strong, nonatomic) IBOutlet UILabel *productName;
@property (strong, nonatomic) IBOutlet UILabel *productValue;
@property (strong, nonatomic) IBOutlet UIButton *buyButton;

@end
