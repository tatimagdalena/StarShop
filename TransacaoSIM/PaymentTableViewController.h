//
//  PaymentTableViewController.h
//  TransacaoSIM
//
//  Created by Tatiana Magdalena on 18/12/15.
//  Copyright © 2015 Tatiana Magdalena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "PaymentTableViewCell.h"

@interface PaymentTableViewController : UITableViewController<UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) NSString *productName;
@property (strong, nonatomic) NSString *productImageName;
@property (strong, nonatomic) NSString *productPrice;

@end
