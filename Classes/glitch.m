//
//  glitch.m
//  glitch_camera
//

#import "glitch.h"

@implementation glitch

+ (NSData*)simple_glitch:(NSData*)d withRatio:(float)rat {
    Byte*b = (Byte*)malloc([d length]); 
    memcpy(b, [d bytes], [d length]); 
    for (int i = 0; i < [d length]*rat; ++i)
        b[lrand48()%[d length]] = (Byte)lrand48()%BYTE_SIZE;
    return [NSData dataWithBytes:b length:[d length]];
}

+ (NSData*)segment_glitch:(NSData*)d withRatio:(float)rat {
    Byte*b = (Byte*)malloc([d length]); 
    memcpy(b, [d bytes], [d length]); 
    for (int i = 0; i < [d length]*rat; ++i) {
        int f = lrand48()%[d length];
        int l = lrand48()%24;
        for (int j = 0; j < l && j+f < [d length]; ++j,++i)
            b[j+f] = (Byte)lrand48()%BYTE_SIZE;
    }
    return [NSData dataWithBytes:b length:[d length]];
}

@end
