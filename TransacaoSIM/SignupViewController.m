//
//  SignupViewController.m
//  TransacaoSIM
//
//  Created by Tatiana Magdalena on 17/12/15.
//  Copyright © 2015 Tatiana Magdalena. All rights reserved.
//

#import "SignupViewController.h"

@interface SignupViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property UIActivityIndicatorView *activityIndicator;

@end


#pragma mark -

@implementation SignupViewController



#pragma mark ViewController methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.passwordField.secureTextEntry = YES;
    
    self.doneButton.layer.cornerRadius = 8.0f;
    self.doneButton.clipsToBounds = YES;
    self.doneButton.layer.borderWidth = 0.3f;
    self.doneButton.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
    UITapGestureRecognizer *closeKeyboardGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard:)];
    closeKeyboardGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:closeKeyboardGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark Keyboard

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

-(void)closeKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    
    [self.view endEditing:YES];
}



#pragma mark Buttons' actions

- (IBAction)doneTapped:(id)sender {
    [self.view endEditing:YES];
    self.doneButton.backgroundColor = [UIColor colorWithRed:116/255.0 green:235/255.0 blue:177/255.0 alpha:1.0];
    [self setActivityIndicator];
    
    PFUser *user = [PFUser user];
    user.username = self.usernameField.text;
    user.password = self.passwordField.text;
    user.email = self.emailField.text;
    user[@"bankBalance"] = [NSNumber numberWithFloat:10000.0];
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        self.doneButton.backgroundColor = [UIColor colorWithRed:67/255.0 green:255/255.0 blue:167/255.0 alpha:1.0];
        [self.activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        
        if (!error) {
            
            UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"Cadastro efetuado com sucesso!"  message:@"Faça seu login para continuar"  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else {
            NSString *errorString = [error userInfo][@"error"];
            
            [self setAlert:@"Erro ao concluir cadastro." withMessage:@"Por favor, tente novamente."];
            
            NSLog(@"%@", errorString);
        }
    }];
    
}

- (IBAction)cancelTapped:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark UI

-(void)setAlert: (NSString*)title withMessage:(NSString*)message {
    
    UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:title  message:message  preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)setActivityIndicator {
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, self.doneButton.frame.size.height*0.9, self.doneButton.frame.size.height*0.9)];
    self.activityIndicator.center = CGPointMake(self.doneButton.center.x, self.doneButton.center.y);
    self.activityIndicator.hidesWhenStopped = YES;
    self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    
    [self.view addSubview:self.activityIndicator];
    
    [self.activityIndicator startAnimating];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
}


@end
