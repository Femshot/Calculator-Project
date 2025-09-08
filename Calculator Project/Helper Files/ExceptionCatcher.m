//
//  ExceptionCatcher.m
//  Calculator Project
//
//  Created by MAC on 28/08/2025.
//

#import "ExceptionCatcher.h"

@implementation ExceptionCatcher

+ (nullable NSExpression *)catchExceptionWithFormat:(NSString *)format {
    NSExpression *expression = nil;
    @try {
        expression = [NSExpression expressionWithFormat:format];
    } @catch (NSException *exception) {
        // NSLog(@"Caught Objective-C exception: %@", exception.reason);
        // The exception has been caught, so we can return nil
        // instead of letting the app crash.
        return nil;
    }
    return expression;
}

@end
