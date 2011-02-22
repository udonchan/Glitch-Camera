//
//  camera_view_controller.m
//  glitch_camera
//

#import "camera_view_controller.h"

@implementation camera_view_controller
@synthesize toolbar;

- (void) visible_bars {
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
    [self.toolbar setAlpha:1.0];
    _current_bars_visibility = YES;
}

- (void) hide_bars {
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
    [self.toolbar setAlpha:0.0];
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

- (NSData*)glitch:(NSData*)d withRatio:(float)rat {
    Byte*b = (Byte*)malloc([d length]); 
    memcpy(b, [d bytes], [d length]); 
    for (int i = 0; i < [d length]*rat; ++i)
        b[lrand48()%[d length]] = (Byte)lrand48()%BYTE_SIZE;
    return [NSData dataWithBytes:b length:[d length]];
}

- (IBAction)launch_camera:(id)sender {
    UIImagePickerController*ip = [[UIImagePickerController alloc] init];
    [ip setSourceType:UIImagePickerControllerSourceTypeCamera];
    [ip setAllowsEditing:YES];
    [ip setDelegate:self];
    [self presentModalViewController:ip animated:YES];
    [ip release];
}

- (void)imagePickerController:(UIImagePickerController*)picker 
        didFinishPickingImage:(UIImage*)image 
                  editingInfo:(NSDictionary*)editingInfo {
    [self dismissModalViewControllerAnimated:YES];
    [_imageView setImage:
     [UIImage imageWithData:
      [self glitch:
       UIImageJPEGRepresentation([editingInfo objectForKey:UIImagePickerControllerOriginalImage],
                                 [[[NSUserDefaults standardUserDefaults]stringForKey:@"jpeg quality"]floatValue])
         withRatio:0.0001*[[[NSUserDefaults standardUserDefaults]stringForKey:@"glitch ratio"]floatValue]]]];
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

    [super viewWillAppear:animated];
}

@end