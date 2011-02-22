//
//  camera_view_controller.h
//  glitch_camera
//

#import <QuartzCore/QuartzCore.h>

@interface camera_view_controller : UIViewController
<UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    BOOL _current_bars_visibility;
    IBOutlet UIImageView*   _imageView;
}

@property (nonatomic, retain) IBOutlet UIToolbar*toolbar;
-(IBAction)launch_camera:(id)sender;
    
@end
