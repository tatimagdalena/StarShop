//
//  TransactionsTableViewCell.h
//  TransacaoSIM
//
//  Created by Tatiana Magdalena on 22/12/15.
//  Copyright © 2015 Tatiana Magdalena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransactionsTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *userBalance;

@property (strong, nonatomic) IBOutlet UILabel *transactionValue;
@property (strong, nonatomic) IBOutlet UILabel *cardHolderName;
@property (strong, nonatomic) IBOutlet UILabel *cardNumber;
@property (strong, nonatomic) IBOutlet UILabel *cardFlag;
@property (strong, nonatomic) IBOutlet UILabel *cardExpDate;

@property (strong, nonatomic) IBOutlet UILabel *transactionDate;

@end
