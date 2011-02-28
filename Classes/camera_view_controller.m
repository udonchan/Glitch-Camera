//
//  camera_view_controller.m
//  glitch_camera
//

#import "camera_view_controller.h"

@implementation camera_view_controller

- (void) visible_bars {
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
    [_toolbar setAlpha:1.0];
    _current_bars_visibility = YES;
}

- (void) hide_bars {
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
    [_toolbar setAlpha:0.0];
    _current_bars_visibility = NO;
}

- (void)change_bars_visibility {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.7];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(void)];
    if (_current_bars_visibility)
        [self hide_bars];
    else
        [self visible_bars];
    [UIView commitAnimations];
}

- (void) touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
    CGPoint location = [[touches anyObject] locationInView:self.view];
    CALayer *hitLayer = [[self.view layer] hitTest:[self.view convertPoint:location fromView:nil]];
    if (hitLayer == _imageView.layer && _imageView.image!=nil)
        [self change_bars_visibility];
}

- (void)image:(UIImage *)image 
didFinishSavingWithError:(NSError *)error 
  contextInfo: (void *) contextInfo {
    for(id item in [_toolbar items]) 
        [(UIBarItem*)item setEnabled:YES];
    [_indicator stopAnimating];
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc] 
                                  initWithTitle:@"Save Faild"
                                  message:@"Some problems occurred. "
                                  delegate:self
                                  cancelButtonTitle:nil
                                  otherButtonTitles:@"OK",nil];
        [alertView show];
        [alertView release];
    }
    
}

- (IBAction)save_image:(id)sender {
    for(id item in [_toolbar items]) 
        [(UIBarItem*)item setEnabled:NO];
    [_indicator startAnimating];
    UIImageWriteToSavedPhotosAlbum([UIImage imageWithData:UIImagePNGRepresentation(_imageView.image)], 
                                   self,
                                   @selector(image:didFinishSavingWithError:contextInfo:), 
                                   nil);
}

- (IBAction)launch_camera:(id)sender {
    UIImagePickerController*ip = [[UIImagePickerController alloc] init];
    [ip setSourceType:UIImagePickerControllerSourceTypeCamera];
    [ip setAllowsEditing:YES];
    [ip setDelegate:self];
    [self presentModalViewController:ip animated:YES];
    [ip release];
}

-(NSData*)glitch:(NSData*)d {
    switch ([[[NSUserDefaults standardUserDefaults]stringForKey:@"glitch type"]intValue]) {
        case _SEGMENT_GLITCH:
            return [glitch segment_glitch:d 
                                withRatio:0.0001*[[[NSUserDefaults standardUserDefaults]stringForKey:@"glitch ratio"]floatValue]];
        case _DATA_DROP_GLITCH:
            return [glitch data_drop_glitch:d 
                                withRatio:0.00008*[[[NSUserDefaults standardUserDefaults]stringForKey:@"glitch ratio"]floatValue]];
        default:
            return [glitch simple_glitch:d 
                               withRatio:0.0001*[[[NSUserDefaults standardUserDefaults]stringForKey:@"glitch ratio"]floatValue]];
    }
}

- (void)imagePickerController:(UIImagePickerController*)picker 
        didFinishPickingImage:(UIImage*)image 
                  editingInfo:(NSDictionary*)editingInfo {
    [self dismissModalViewControllerAnimated:YES];
    [_imageView setImage:
     [UIImage imageWithData:
      [self glitch:
       UIImageJPEGRepresentation([editingInfo objectForKey:UIImagePickerControllerOriginalImage],
                                 [[[NSUserDefaults standardUserDefaults]stringForKey:@"jpeg quality"]floatValue])]]];
    /* PNG vertion
    [_imageView setImage:
     [UIImage imageWithData:
      [self glitch:
       UIImagePNGRepresentation([editingInfo objectForKey:UIImagePickerControllerOriginalImage])]]];
     */
}
    
- (void)imagePickerControllerDidCancel:(UIImagePickerController*)picker {
    [self dismissModalViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated {
    _current_bars_visibility = YES;
    /*
    [_logoView setAnimationImages:
     [NSArray arrayWithObjects:
      [UIImage imageNamed:@"1.png"],
      [UIImage imageNamed:@"2.png"],
      [UIImage imageNamed:@"3.png"],
      [UIImage imageNamed:@"4.png"],
      nil]];
    [_logoView setAnimationDuration:0.4];
    [_logoView startAnimating];
     */
    [_logoView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",arc4random()%4+1]]];
    [_save_button setEnabled:_imageView.image!=nil];
    [super viewWillAppear:animated];
}

@end