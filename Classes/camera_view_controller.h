//
//  camera_view_controller.h
//  glitch_camera
//

@interface camera_view_controller : UIViewController
<UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    IBOutlet UIImageView*   _imageView;
}

-(IBAction)launch_camera:(id)sender;
    
@end
