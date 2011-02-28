//
//  camera_view_controller.h
//  glitch_camera
//

#import <QuartzCore/QuartzCore.h>
#import "glitch.h"

@interface camera_view_controller : UIViewController
<UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    BOOL _current_bars_visibility;
    IBOutlet UIImageView*_imageView;
    IBOutlet UIImageView*_logoView;
    IBOutlet UIToolbar*_toolbar;
    IBOutlet UIBarItem*_save_button;
    IBOutlet UIActivityIndicatorView*_indicator;
}

- (IBAction)launch_camera:(id)sender;
- (IBAction)save_image:(id)sender;
    
@end
