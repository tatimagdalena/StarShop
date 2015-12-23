//
//  TransactionsTableViewController.m
//  TransacaoSIM
//
//  Created by Tatiana Magdalena on 22/12/15.
//  Copyright © 2015 Tatiana Magdalena. All rights reserved.
//

#import "TransactionsTableViewController.h"

@interface TransactionsTableViewController ()
{
    PFUser *user;
}
@end



#pragma mark -

@implementation TransactionsTableViewController



#pragma mark ViewController methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    user = [PFUser currentUser];
    _thisUserTransactions = [[NSMutableArray alloc] init];
    [self getTransactions];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }
    else {
        return _thisUserTransactions.count;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = @"Informações básicas:";
            break;
        case 1:
            sectionName = @"Pagamentos:";
            break;
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        TransactionsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basicData"];
        cell.userName.text = [user username];
        cell.userBalance.text = [NSString stringWithFormat:@"$%.2f", [user[@"bankBalance"] floatValue]];
        return cell;
    }
    else {
        TransactionsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"transaction"];
        NSDictionary *transaction = [_thisUserTransactions objectAtIndex:indexPath.row];
        
        NSString *cardNumber = [transaction objectForKey:@"CardNumber"];
        NSString *lastFourDigits = [cardNumber substringFromIndex:[cardNumber length] - 4];
        cell.cardNumber.text = [NSString stringWithFormat:@"XXXX-XXXX-XXXX-%@", lastFourDigits];
        
        cell.cardHolderName.text = [transaction objectForKey:@"HolderName"];
        cell.cardFlag.text = [transaction objectForKey:@"CardFlag"];
        
        NSNumber *transactionValue = [transaction objectForKey:@"Value"];
        cell.transactionValue.text = [NSString stringWithFormat:@"$%.2f", [transactionValue floatValue]];
        
        NSDate *expDate = [transaction objectForKey:@"CardExpDate"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        NSString *expDateFormatter = [NSDateFormatter dateFormatFromTemplate:@"MM/yyyy" options:0 locale:[NSLocale currentLocale]];
        formatter.dateFormat = expDateFormatter;
        cell.cardExpDate.text = [formatter stringFromDate:expDate];
        
        NSDate *acceptedDate = [transaction objectForKey:@"Day"];
        NSString *acceptedDateFormatter = [NSDateFormatter dateFormatFromTemplate:@"dd/MM/yyyy" options:0 locale:[NSLocale currentLocale]];
        formatter.dateFormat = acceptedDateFormatter;
        cell.transactionDate.text = [formatter stringFromDate:acceptedDate];
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 75;
    }
    else {
        return 111;
    }
}



#pragma mark - Database (plist)

-(void)getTransactions {

    NSString *pathAux = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [pathAux stringByAppendingPathComponent:@"Transactions.plist"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        path = [[NSBundle mainBundle] pathForResource:@"Transactions" ofType:@"plist"];
    }
    
    
    NSMutableDictionary *data = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
    NSLog(@"NSMUTABLEDICTIONARY: %@", data);
    
    for(NSString *key in [data allKeys]) {
        
        NSLog(@"Key %@: %@",key, [data objectForKey:key]);
        NSString *transactionUserName = [[data objectForKey:key] objectForKey:@"UserName"];
        if ([transactionUserName isEqualToString:[[PFUser currentUser] username]]) {
            
            NSLog(@"adicionou essa transacao");
            [_thisUserTransactions addObject:[data objectForKey:key]];
        }
    }
    
    NSLog(@"Objetos na plist deste usuario");
    NSLog(@"%@", _thisUserTransactions);
}


@end
