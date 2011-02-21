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
        b[arc4random()%[d length]] = (Byte)arc4random()%BYTE_SIZE;
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
    
    UIImage*img = [UIImage imageWithData:
                   [self glitch:
                    UIImageJPEGRepresentation([editingInfo objectForKey:UIImagePickerControllerOriginalImage],
                                              1.0)
                      withRatio:0.00003]
                   ];
    CGSize  size = { 300, 400 };
    UIGraphicsBeginImageContext(size);
    CGRect rect;
    rect.origin = CGPointZero;
    rect.size = size;
    [img drawInRect:rect];
    _imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}
    
- (void)imagePickerControllerDidCancel:(UIImagePickerController*)picker {
    [self dismissModalViewControllerAnimated:YES];
}

@end