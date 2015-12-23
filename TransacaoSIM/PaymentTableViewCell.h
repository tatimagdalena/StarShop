//
//  PaymentTableViewCell.h
//  TransacaoSIM
//
//  Created by Tatiana Magdalena on 19/12/15.
//  Copyright © 2015 Tatiana Magdalena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *productImageView;
@property (strong, nonatomic) IBOutlet UILabel *productName;
@property (strong, nonatomic) IBOutlet UILabel *productPrice;

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *numberField;
@property (weak, nonatomic) IBOutlet UITextField *cvvField;

@property (weak, nonatomic) IBOutlet UITextField *expMonthField;
@property (weak, nonatomic) IBOutlet UITextField *expYearField;


@property (weak, nonatomic) IBOutlet UIPickerView *flagPicker;



@end
