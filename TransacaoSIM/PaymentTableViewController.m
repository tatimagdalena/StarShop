//
//  PaymentTableViewController.m
//  TransacaoSIM
//
//  Created by Tatiana Magdalena on 18/12/15.
//  Copyright © 2015 Tatiana Magdalena. All rights reserved.
//

#import "PaymentTableViewController.h"

@interface PaymentTableViewController ()
{
    UIActivityIndicatorView *activityIndicator;
    
    NSArray *_flagPickerData;
    
    NSString *cardFlag;
    NSString *cardNumber;
    NSString *cardHolderName;
    NSInteger expMonth;
    NSInteger expYear;
    NSDate *cardExpDate;
    NSString *cardCvv;
    //NSInteger transactionValue;
}
@end


#pragma mark -

@implementation PaymentTableViewController



#pragma mark ViewController methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    _flagPickerData = @[@"Bandeira", @"Visa", @"Master"];
    
    expYear = 0;
    expMonth = 0;
    
    UITapGestureRecognizer *closeKeyboardGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard:)];
    closeKeyboardGesture.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:closeKeyboardGesture];
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
        return 5;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        PaymentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"productCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.productName.text = _productName;
        cell.productPrice.text = [@"$" stringByAppendingString:_productPrice];
        cell.productImageView.image = [UIImage imageNamed:_productImageName];
        cell.productImageView.layer.borderWidth = 1.0f;
        cell.productImageView.layer.masksToBounds = NO;
        cell.productImageView.layer.borderColor = [[UIColor clearColor]CGColor];
        cell.productImageView.layer.cornerRadius = cell.productImageView.frame.size.height/2.5;
        cell.productImageView.clipsToBounds = YES;
    
        return cell;
    }
    else {
        if (indexPath.row == 0) {
            PaymentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nameCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.backgroundColor = [UIColor clearColor];
            cell.imageView.image = [UIImage imageNamed:@"Name"];
            
            cell.nameField.delegate = self;
            cell.nameField.placeholder = @"Nome do portador do cartão";
            cell.nameField.font = [UIFont fontWithName:@"Futura" size:14];
            
            return cell;
        }
        else if (indexPath.row == 1) {
            PaymentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"numberCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.backgroundColor = [UIColor clearColor];
            cell.imageView.image = [UIImage imageNamed:@"CreditCard"];
            cell.imageView.frame = CGRectMake(16.0f, cell.center.y - cell.frame.size.height/4, 10.0f, cell.frame.size.height/2);
            cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
            cell.numberField.delegate = self;
            cell.numberField.placeholder = @"Número do cartão";
            cell.numberField.font = [UIFont fontWithName:@"Futura" size:14];
            
            return cell;
        }
        else if (indexPath.row == 2) {
            PaymentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cvvCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.backgroundColor = [UIColor clearColor];
            cell.imageView.image = [UIImage imageNamed:@"CVV"];
            cell.cvvField.delegate = self;
            cell.cvvField.placeholder = @"Código de verificação";
            cell.cvvField.font = [UIFont fontWithName:@"Futura" size:14];
            
            return cell;
        }
        else if (indexPath.row == 3) {
            PaymentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"expCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.backgroundColor = [UIColor clearColor];
            cell.imageView.image = [UIImage imageNamed:@"Calendar"];
            
            cell.expMonthField.delegate = self;
            cell.expMonthField.placeholder = @"mm";
            cell.expMonthField.font = [UIFont fontWithName:@"Futura" size:14];
            cell.expYearField.delegate = self;
            cell.expYearField.placeholder = @"aaaa";
            cell.expYearField.font = [UIFont fontWithName:@"Futura" size:14];
            
            return cell;
        }
        else {
            PaymentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"flagCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.backgroundColor = [UIColor clearColor];
            cell.imageView.image = [UIImage imageNamed:@"CreditCardFlag"];
            
            cell.flagPicker.dataSource = self;
            cell.flagPicker.delegate = self;
            cell.flagPicker.tag = 1;
            
            return cell;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 130;
    }
    else if (indexPath.row == 4) {
        return 100;
    }
    else {
        return 45;
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



#pragma mark - PickerView delegate

// The number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _flagPickerData.count;
}

// The data to return for the row and component (column) that's being passed in
//- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    return _flagPickerData[row];
//}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* tView = (UILabel*)view;
    if (!tView)
    {
        tView = [[UILabel alloc] init];
        [tView setFont:[UIFont fontWithName:@"Futura" size:14]];
        if (row == 0) {
            [tView setTextColor:[UIColor lightGrayColor]];
        }
        //tView.numberOfLines=3;
    }
    // Fill the label text here
    tView.text=[_flagPickerData objectAtIndex:row];
    return tView;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
    
    if (row != 0) {
        cardFlag = [_flagPickerData objectAtIndex:row];
    }
    else {
        cardFlag = nil;
    }
}




#pragma mark - Textfield delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([textField.placeholder isEqualToString:@"mm"]) {

        NSLog(@"%@", textField.text);
        
        if (textField.text.length >= 2 && range.length == 0)
            return NO;
        return YES;
    }
    else if ([textField.placeholder isEqualToString:@"aaaa"]) {
        
        NSLog(@"%@", textField.text);
        
        if (textField.text.length >= 4 && range.length == 0)
            return NO;
        return YES;
    }
    else if ([textField.placeholder isEqualToString:@"Nome do portador do cartão"]) {
        
        return YES;
    }
    else if ([textField.placeholder isEqualToString:@"Número do cartão"]) {
        
        NSLog(@"%@", textField.text);
        
        if (textField.text.length >= 16 && range.length == 0)
            return NO;
        return YES;
    }
    else if ([textField.placeholder isEqualToString:@"Código de verificação"]) {
        
        NSLog(@"%@", textField.text);
        
        if (textField.text.length >= 3 && range.length == 0)
            return NO;
        return YES;
    }
    else {
        return YES;
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 100) {
        cardHolderName = textField.text;
    }
    else if (textField.tag == 101) {
        cardNumber = textField.text;
    }
    else if (textField.tag == 102) {
        cardCvv = textField.text;
    }
    else if (textField.tag == 103) {
        expMonth = [textField.text integerValue];
    }
    else if (textField.tag == 104) {
        expYear = [textField.text integerValue];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField becomeFirstResponder];
    [textField resignFirstResponder];
    
    return true;
}


#pragma mark Keyboard

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    [self.tableView endEditing:YES];
    
    [super touchesBegan:touches withEvent:event];
}

-(void)closeKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    
    [self.view endEditing:YES];
}


#pragma mark - Buttons' actions

- (IBAction)cancelTapped:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)doneTapped:(UIBarButtonItem *)sender {
    
    [self.view endEditing:YES];
    [self setActivityIndicator];
    
    if ([[[PFUser currentUser] username] isEqualToString:@"adm"]) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [self setAlert:@"Login de administrador." withMessage:@"Não é possível realizar transações com login de administrador."];
    }
    else if (cardHolderName == nil || cardNumber == nil || cardCvv == nil || expMonth == 0 || expYear == 0 || cardFlag == nil) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [self setAlert:@"Por favor, preencha todos os campos!" withMessage:@""];
    }
    else if ([cardNumber length] < 16) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [self setAlert:@"Número de cartão inválido." withMessage:@""];
    }
    else if ([cardCvv length] < 3) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [self setAlert:@"Código de verificação inválido." withMessage:@""];
    }
    else if (expMonth > 12 || expMonth < 1) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [self setAlert:@"Data de vencimento inválida." withMessage:@""];
    }
    else {
        NSDate *today = [[NSDate alloc] init];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [[NSDateComponents alloc] init];
        
        [components setDay:30];
        [components setMonth:expMonth];
        [components setYear:expYear];
        cardExpDate = [calendar dateFromComponents:components];
        
        if (expMonth == 2) {
            [components setDay:28];
        }
        else {
            //Gets the number of days of given month
            NSRange rng = [calendar rangeOfUnit:NSCalendarUnitDay
                                         inUnit:NSCalendarUnitMonth
                                        forDate:cardExpDate];
            NSUInteger numberOfDaysInMonth = rng.length;
            NSLog(@"\nNumero de dias no mês %d: %d", expMonth, numberOfDaysInMonth);
            
            [components setDay:numberOfDaysInMonth];
        }
        
        cardExpDate = [calendar dateFromComponents:components];
        
        //Checks if the expiration date has already passed.
        if ([today compare:cardExpDate] == NSOrderedDescending) {
            [activityIndicator stopAnimating];
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            [self setAlert:@"Cartão expirado." withMessage:@""];
        }
        else {
            //Everything is ok, can perform transaction.
            float transactionValue = [self.productPrice floatValue];
            //NSNumber *transactionNumber = [NSNumber numberWithFloat:transactionValue];
            
            NSDateComponents *expComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:cardExpDate];
            
            NSLog(@"\nProduto: %@ \n Valor: %.2f \n Nome: %@ \n Cartao: %@ \n CVV: %@ \n ExpDate: %d/%d \n Bandeira: %@ \n", self.productName, transactionValue, cardHolderName, cardNumber, cardCvv, [expComponents month], [expComponents year], cardFlag);
            
            //Trying to save in external database.
            [self generateTransaction:transactionValue /*forCardHolder:cardHolderName forCardNumber:cardNumber withCvv:cardCvv withExpDate:cardExpDate withFlag:cardFlag*/];
            
        }
            
    }
}




#pragma mark - UI

-(void)setAlert: (NSString*)title withMessage:(NSString*)message {
    
    UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:title  message:message  preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)setActivityIndicator {
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
    activityIndicator.center = CGPointMake(screenSize.width/2, screenSize.height/2);
    activityIndicator.hidesWhenStopped = YES;
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    
    [self.view addSubview: activityIndicator];
    
    [activityIndicator startAnimating];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
}


#pragma mark - Database connection (parse&plist)

-(void)generateTransaction: (float)value /*forCardHolder:(NSString*)holderName forCardNumber:(NSString*)cardNumber withCvv:(NSString*)cardCvv withExpDate:(NSDate*)expDate withFlag:(NSString*)cardFlag*/ {
    
    //In this simulation, only the value is needed to be validated in the database. If there's balance for this user, the transaction is aproved.
    
    PFUser *user = [PFUser currentUser];
    
    if ([user[@"bankBalance"] floatValue] > value) {
        //This user has enough credit. Can now perform transaction.
        NSLog(@"\nSaldo: %.2f \n Valor da compra: %.2f", [user[@"bankBalance"] floatValue], value);
        
        [user incrementKey:@"bankBalance" byAmount:[NSNumber numberWithFloat:-value]];
        
        NSLog(@"Novo saldo: %.2f", [user[@"bankBalance"] floatValue]);
        
        [user saveInBackgroundWithBlock: ^(BOOL succeeded, NSError *error) {
            
            [activityIndicator stopAnimating];
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            
            if (succeeded) {
                NSLog(@"\nAtualizado com sucesso.");
                
                //The object has been successfully saved in external database. Can now save the transaction in internal database.
                [self saveTransactionInternally:value /*forCardHolder:cardHolderName forCardNumber:cardNumber withCvv:cardCvv withExpDate:cardExpDate withFlag:cardFlag*/];
                
                
                NSString *message = [NSString stringWithFormat:@"Seu saldo é de $%.2f", [user[@"bankBalance"] floatValue]];
                
                UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"Compra realizada com sucesso."  message:message  preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                    [self.navigationController popViewControllerAnimated:YES];
                }]];
                [self presentViewController:alertController animated:YES completion:nil];
                
            }
            else {
                [self setAlert:@"Não foi possível completar a transação." withMessage:@"Por favor, tente novamente."];
            }
        }];
    }
    else {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        
        //This user doesn't have enough credit for this purchase.
        NSLog(@"\nSaldo: %.2f \n Valor da compra: %.2f", [user[@"bankBalance"] floatValue], value);
        [self setAlert:@"Operação não autorizada." withMessage:@"Não há saldo suficiente."];
    }
}

-(void)saveTransactionInternally:(float)value /*forCardHolder:(NSString*)holderName forCardNumber:(NSString*)number withCvv:(NSString*)cvv withExpDate:(NSDate*)expDate withFlag:(NSString*)flag*/ {
    
    NSLog(@"Comecando a salvar na plist");
    
    NSString *pathAux = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [pathAux stringByAppendingPathComponent:@"Transactions.plist"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        path = [[NSBundle mainBundle] pathForResource:@"Transactions" ofType:@"plist"];
    }

    NSLog(@"Pegou plist");
    
    NSMutableDictionary *data = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    NSString *transactionsNum;
    NSDate *today = [[NSDate alloc] init]; //The moment the transactin has been accepted.
    
    NSDictionary *transactionInfo = [NSDictionary dictionaryWithObjects:
                               [NSArray arrayWithObjects: [[PFUser currentUser] username], [NSNumber numberWithFloat:value], cardHolderName, cardNumber, cardCvv, cardExpDate, cardFlag, today, nil]
                                                          forKeys:[NSArray arrayWithObjects: @"UserName", @"Value", @"HolderName",@"CardNumber",@"CardCvv",@"CardExpDate",@"CardFlag", @"Day", nil]];
    
    for(NSString *key in [transactionInfo allKeys]) {
        NSLog(@"Info da transacao:");
        NSLog(@"Key %@: %@",key, [data objectForKey:key]);
    }
    
    NSInteger transactionsAmount = data.count;
    transactionsNum = [NSString stringWithFormat:@"Transaction%d", transactionsAmount];
    
    NSLog(@"Quantidade de transacoes: %d", transactionsAmount);
    
    [data setObject:transactionInfo forKey:transactionsNum];
                            
    if(data) {
        [data writeToFile:path atomically:YES];
    }
    else {
        //        NSLog(error);
        //        [error release];
        NSLog(@"Erro ao tentar salvar na plist");
    }
    
    NSLog(@"Objetos na plist");
    for(NSString *key in [data allKeys]) {
        
        NSLog(@"Key %@: %@",key, [data objectForKey:key]);
    }
    
}

-(void)deleteAllTransactions {
    NSString *pathAux = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [pathAux stringByAppendingPathComponent:@"Transactions.plist"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        path = [[NSBundle mainBundle] pathForResource:@"Transactions" ofType:@"plist"];
    }
    
    NSLog(@"Pegou plist");
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    [data writeToFile:path atomically:YES];
}

@end
