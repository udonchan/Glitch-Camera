//
//  camera_view_controller.m
//  glitch_camera
//

#import "camera_view_controller.h"

@implementation camera_view_controller

- (NSData*) glitch:(NSData*)d {
    return d;
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
                                              1.0)]
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