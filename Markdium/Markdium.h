//
//  Markdium.h
//  Markdium
//
//  Created by v on 2019/11/15.
//  Copyright © 2019 lvv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MarkdiumTypes.h"

@interface Markdium : NSObject

@property(nonatomic, assign) NSUInteger width;  // Specify wrap width (default 0 = nowrap)

- (nullable instancetype)initWithString:(nonnull NSString *)string enableGFM:(BOOL)gfm;

@end

@interface Markdium (render)

- (nullable NSString *)renderAsHTML;

- (nullable NSString *)renderAsXML;

- (nullable NSString *)renderAsMAN;

- (nullable NSString *)renderAsLatex;

- (nullable NSString *)renderAsCommonMark;

- (nullable NSString *)renderAsPlaintext;

@end

@interface Markdium (version)

+ (nonnull NSString *)versionString;

+ (NSInteger)version;

@end
