//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExceptionCatcher : NSObject

+ (nullable NSExpression *)catchExceptionWithFormat:(NSString *)format;

@end

NS_ASSUME_NONNULL_END
