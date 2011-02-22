//
//  camera_view_controller.m
//  glitch_camera
//

#import "camera_view_controller.h"

@implementation camera_view_controller

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

@end