//
//  NSString+JCAdaptiveSize.h
//  AfricaLottery
//
//  Created by pingco on 17/2/17.
//  Copyright © 2017年 Pingco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (JCAdaptiveSize)

+(CGSize)labelAdaptiveSizeWithString:(NSString *)textStr withFont:(UIFont *)font withSize:(CGSize)frameSize withMode:(NSLineBreakMode)mode;

+(CGSize)labelSizeWithAttributesWithTitle:(NSString *)title withFont:(UIFont *)font;
//带行间距
+(CGSize)labelAdaptiveSizeWithString:(NSString *)textStr withFont:(UIFont *)font withSize:(CGSize)frameSize withMode:(NSLineBreakMode)mode lineSpacing:(int)lineSpacing;
@end
