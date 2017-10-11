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
#import "CALayer+Extension.h"
#import "UIImage+Extension.h"
#import "UIImageView+Extension.h"
#import "UIView+Extension.h"
#import "ERCircleModelProtocol.h"
#import "ERCirclePicView.h"
#import "ERSessionManager.h"
#import "ERAlertTool.h"
#import "ERCacheTool.h"
#import "ERDeviceMessage.h"
#import "ERNoticeLocal.h"

FOUNDATION_EXPORT double ERComponentVersionNumber;
FOUNDATION_EXPORT const unsigned char ERComponentVersionString[];

