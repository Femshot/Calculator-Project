//
//  Untitled.h
//  Calculator Project
//
//  Created by MAC on 28/08/2025.
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExceptionCatcher : NSObject

+ (nullable NSExpression *)catchExceptionWithFormat:(NSString *)format;

@end

NS_ASSUME_NONNULL_END
