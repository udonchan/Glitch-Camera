//
//  camera_view_controller.h
//  glitch_camera
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@interface camera_view_controller : UIViewController
<UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    IBOutlet UIImageView*   _imageView;
}

-(IBAction)launch_camera:(id)sender;
    
@end
