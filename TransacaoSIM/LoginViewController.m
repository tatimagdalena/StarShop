//
//  LoginViewController.m
//  TransacaoSIM
//
//  Created by Tatiana Magdalena on 17/12/15.
//  Copyright © 2015 Tatiana Magdalena. All rights reserved.
//

#import "LoginViewController.h"
#import "ShopViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *goToSignupButton;

@property UIActivityIndicatorView *activityIndicator;

@end


#pragma mark -

@implementation LoginViewController



#pragma mark ViewController methods

- (void)viewDidLoad {
    [super viewDidLoad];

    self.passwordField.secureTextEntry = YES;
    
    self.loginButton.layer.cornerRadius = 8.0f;
    self.loginButton.clipsToBounds = YES;
    self.loginButton.layer.borderWidth = 0.3f;
    self.loginButton.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
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

- (IBAction)loginTapped:(id)sender {
    [self.view endEditing:YES];
    
    self.loginButton.backgroundColor = [UIColor colorWithRed:116/255.0 green:235/255.0 blue:177/255.0 alpha:1.0];
    [self setActivityIndicator];
    
    [PFUser logInWithUsernameInBackground:self.usernameField.text password:self.passwordField.text
                                    block:^(PFUser *user, NSError *error) {
                                        
                                        self.loginButton.backgroundColor = [UIColor colorWithRed:67/255.0 green:255/255.0 blue:167/255.0 alpha:1.0];
                                        [self.activityIndicator stopAnimating];
                                        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                                        
                                        if (user) {
                                            // Successful login.
                                            
                                            NSLog(@"Login com sucesso");
                                            
                                            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                            UIViewController *shopVC = [sb instantiateViewControllerWithIdentifier:@"nav"];
                                            [self presentViewController:shopVC animated:YES completion:nil];
                                        }
                                        else {
                                            // The login failed. Check error to see why.
                                            
                                            [self setAlert:@"O login falhou." withMessage:@"Não foi possível fazer o login com o usuário/senha fornecidos."];
                                        }
                                    }];
}

- (IBAction)goToSignupTapped:(id)sender {
}



#pragma mark UI

-(void)setAlert: (NSString*)title withMessage:(NSString*)message {
    
    UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:title  message:message  preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)setActivityIndicator {
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, self.loginButton.frame.size.height*0.9, self.loginButton.frame.size.height*0.9)];
    self.activityIndicator.center = CGPointMake(self.loginButton.center.x, self.loginButton.center.y);
    self.activityIndicator.hidesWhenStopped = YES;
    self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    
    [self.view addSubview:self.activityIndicator];
    
    [self.activityIndicator startAnimating];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
}

@end
