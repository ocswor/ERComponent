//
//  ERSessionManager.h
//  ERComponent_Example
//
//  Created by eric on 2017/10/10.
//  Copyright © 2017年 jialianghappy1314@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    RequestTypeGet,
    RequestTypePost
}RequestType;

@interface ERSessionManager : NSObject
    
- (void)setValue:(NSString *)value forHttpField:(NSString *)field;
- (void)request:(RequestType)requestType urlStr: (NSString *)urlStr parameter: (NSDictionary *)param resultBlock: (void(^)(id responseObject, NSError *error))resultBlock;
@end
