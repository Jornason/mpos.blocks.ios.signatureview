//
//  PWSVViewController.m
//  mpos.ios.blocks.signatureview
//
//  Created by Thomas Pischke on 01.11.13.
//  Copyright (c) 2013 payworks. All rights reserved.
//

#import "PWBViewController.h"
#import "PWBSignatureViewController.h"
#import "PWBTestViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface PWBViewController ()

@property BOOL fieldShown;
@property (strong, nonatomic) UIImageView* backgroundView;

@end

@implementation PWBViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.fieldShown = false;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)showPredefinedScreen:(id)sender {
    [self showModal];
}

- (IBAction)showCustomScreen:(id)sender {
    PWBTestViewController *vc = (PWBTestViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"signature"];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)showModal
{
        
    PWBSignatureViewController* signatureViewController = [[PWBSignatureViewController alloc]init];
        
    signatureViewController.merchantName = @"Fruit Shop";
    signatureViewController.merchantLogo = [UIImage imageNamed:@"merchantFruit.png"];
    signatureViewController.amountText = @"5.99 €";
    signatureViewController.signatureText = @"Hiermit autorisiere ich die Zahlung in Höhe von 5.99 € an Fruit Shop";
    signatureViewController.signatureColor = [UIColor darkGrayColor];
    signatureViewController.payButtonText = @"Bezahlen";
    signatureViewController.cancelButtonText = @"Abbrechen";
        
    [signatureViewController registerOnPay:^{
            
        UIImage* signature = [signatureViewController signature];
        UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(66, 200, 200, 100)];
        imageView.image = signature;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:imageView];
            
        imageView.layer.borderColor = [UIColor yellowColor].CGColor;
        imageView.layer.borderWidth = 2.0f;
            
        [signatureViewController dismissViewControllerAnimated:YES completion:nil];
            
    } onCancel:^{
        
        [signatureViewController dismissViewControllerAnimated:YES completion:nil];
            
    }];
        
    [self presentViewController:signatureViewController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
