//
//  TransactionsTableViewController.h
//  TransacaoSIM
//
//  Created by Tatiana Magdalena on 22/12/15.
//  Copyright © 2015 Tatiana Magdalena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "TransactionsTableViewCell.h"

@interface TransactionsTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *thisUserTransactions;

@end
