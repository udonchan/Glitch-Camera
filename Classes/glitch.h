//
//  glitch.h
//  glitch_camera
//

#define _SIMPLE_GLITCH 0
#define _SEGMENT_GLITCH 1
#define _DATA_DROP_GLITCH 2

@interface glitch : NSObject

+ (NSData*)simple_glitch:(NSData*)d withRatio:(float)rat;
+ (NSData*)segment_glitch:(NSData*)d withRatio:(float)rat;
+ (NSData*)data_drop_glitch:(NSData*)d withRatio:(float)rat;

@end
