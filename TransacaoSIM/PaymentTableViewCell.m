//
//  PaymentTableViewCell.m
//  TransacaoSIM
//
//  Created by Tatiana Magdalena on 19/12/15.
//  Copyright © 2015 Tatiana Magdalena. All rights reserved.
//

#import "PaymentTableViewCell.h"

@implementation PaymentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(5,5,30,25);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
