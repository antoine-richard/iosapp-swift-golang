// Objective-C API for talking to github.com/antoine-richard/iosapp-swift-golang/golang-lib Go package.
//   gobind -lang=objc -prefix=Go github.com/antoine-richard/iosapp-swift-golang/golang-lib
//
// File is generated by gobind. Do not edit.

#ifndef __GoWeather_H__
#define __GoWeather_H__

#include <Foundation/Foundation.h>
#include "GoUniverse.h"

@class GoWeatherCityWeather;

@interface GoWeatherCityWeather : NSObject {
}
@property(strong, readonly) id _ref;

- (id)initWithRef:(id)ref;
- (NSString*)name;
- (void)setName:(NSString*)v;
- (NSString*)desc;
- (void)setDesc:(NSString*)v;
- (NSString*)temp;
- (void)setTemp:(NSString*)v;
@end

FOUNDATION_EXPORT BOOL GoWeatherFetchCustomCity(NSString* city, NSData** ret0_, NSError** error);

FOUNDATION_EXPORT BOOL GoWeatherFetchDefaultCities(NSData** ret0_, NSError** error);

#endif
