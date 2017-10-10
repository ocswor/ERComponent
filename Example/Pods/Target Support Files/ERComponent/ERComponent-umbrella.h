#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "Base.h"
#import "ERConst.h"
#import "Sington.h"

FOUNDATION_EXPORT double ERComponentVersionNumber;
FOUNDATION_EXPORT const unsigned char ERComponentVersionString[];

