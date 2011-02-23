//
//  glitch.h
//  glitch_camera
//

@interface glitch : NSObject

+ (NSData*)simple_glitch:(NSData*)d withRatio:(float)rat;
+ (NSData*)segment_glitch:(NSData*)d withRatio:(float)rat;

@end
