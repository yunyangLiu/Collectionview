//
//  NSString+JCAdaptiveSize.m
//  AfricaLottery
//
//  Created by pingco on 17/2/17.
//  Copyright © 2017年 Pingco. All rights reserved.
//

#import "NSString+JCAdaptiveSize.h"

@implementation NSString (JCAdaptiveSize)

//（width ，1000）||（1000，height）
+(CGSize)labelAdaptiveSizeWithString:(NSString *)textStr withFont:(UIFont *)font withSize:(CGSize)frameSize withMode:(NSLineBreakMode)mode{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = mode;
    NSDictionary *nameLabelAttr = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize labelSize =[textStr boundingRectWithSize:frameSize options:NSStringDrawingUsesLineFragmentOrigin attributes:nameLabelAttr context:nil].size;
    
    return labelSize;
}
+(CGSize)labelSizeWithAttributesWithTitle:(NSString *)title withFont:(UIFont *)font
{
    NSDictionary *attr = @{NSFontAttributeName : font};
    CGSize titleSize = [title sizeWithAttributes:attr];
    return titleSize;
}

+(CGSize)labelAdaptiveSizeWithString:(NSString *)textStr withFont:(UIFont *)font withSize:(CGSize)frameSize withMode:(NSLineBreakMode)mode lineSpacing:(int)lineSpacing{
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:lineSpacing];
    paragraphStyle.lineBreakMode = mode;
    NSDictionary *nameLabelAttr = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize labelSize =[textStr boundingRectWithSize:frameSize options:NSStringDrawingUsesLineFragmentOrigin attributes:nameLabelAttr context:nil].size;
    
    return labelSize;
}

@end
