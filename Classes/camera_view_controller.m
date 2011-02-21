//
//  camera_view_controller.m
//  glitch_camera
//

#import "camera_view_controller.h"

@implementation camera_view_controller

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
    
    UIImage*img = [editingInfo objectForKey:UIImagePickerControllerOriginalImage];
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