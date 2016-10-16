//
//  BRBirthdayEditViewController.m
//  BirthdayReminder
//
//  Created by Nick Kuh on 05/07/2012.
//  Copyright (c) 2012 Nick Kuh. All rights reserved.
//

#import "BRBirthdayEditViewController.h"

@interface BRBirthdayEditViewController ()

@property (nonatomic, strong) UIImagePickerController *imagePicker;

@end

@implementation BRBirthdayEditViewController
@synthesize saveButton;
@synthesize nameTextField;
@synthesize includeYearLabel;
@synthesize includeYearSwitch;
@synthesize datePicker;
@synthesize photoContainerView;
@synthesize picPhotoLabel;
@synthesize photoView;

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSString *name = self.birthday [@"name"];
    NSDate *birthdate = self.birthday[@"birthdate"];
    UIImage *image = self.birthday[@"image"];
    
    self.nameTextField.text = name;
    self.datePicker.date = birthdate;
    if (image == nil) {
        //default to the birthday cake pic if there's no birthday image
        self.photoView.image = [UIImage imageNamed:@"icon-birthday-cake.png"];
    }
    else {
        self.photoView.image = image;
    }
    
    [self updateSaveButton];
}

-(void) updateSaveButton
{
    self.saveButton.enabled = self.nameTextField.text.length > 0;
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.nameTextField resignFirstResponder];
    return NO;
}


- (IBAction)didChangeNameText:(id)sender {
    NSLog(@"The text was changed: %@",self.nameTextField.text);
    self.birthday[@"name"] = self.nameTextField.text;
    [self updateSaveButton];
}

- (IBAction)didToggleSwitch:(id)sender {
    if (self.includeYearSwitch.on) {
        NSLog(@"Sure, I'll share my age with you!");
    }
    else {
        NSLog(@"I'd prefer to keep my birthday year to myself thank you very much!");
    }
}

- (IBAction)didChangeDatePicker:(id)sender {
    NSLog(@"New Birthdate Selected: %@",self.datePicker.date);
    self.birthday[@"birthdate"] = self.datePicker.date;
}

- (IBAction)didTapPhoto:(id)sender {
    NSLog(@"Did Tap Photo!");
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"No camera detected!");
        [self pickPhoto];
        return;
    }
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take a Photo",@"Pick from Photo Library", nil];
    [actionSheet showInView:self.view];
}

-(UIImagePickerController *) imagePicker
{
    if (_imagePicker == nil) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
    }
    return _imagePicker;
}

-(void) takePhoto
{
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self.navigationController presentViewController:self.imagePicker animated:YES completion:nil];
}

-(void) pickPhoto
{
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    if (self.imagePicker == nil) {
        NSLog(@"It's nil!");
    }
    else
    {
        NSLog(@"Not nil!");
    }
    
    [self.navigationController presentViewController:self.imagePicker animated:YES completion:nil];
}

#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
     
    self.photoView.image = image;
    
    self.birthday[@"image"] = image;
}

#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) return;
    
    switch (buttonIndex) {
        case 0:
            [self takePhoto];
            break;
        case 1:
            [self pickPhoto];
            break;
    }
}

@end
