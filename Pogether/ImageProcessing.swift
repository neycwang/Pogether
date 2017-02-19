//
//  ImageProcessing.swift
//  Pogether
//
//  Created by KiraMelody on 2017/2/19.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import Foundation

class ImageProcessing
{
    
    /**
     *  调整图片饱和度、亮度、对比度
     *
     *  @param image      目标图片
     *  @param brightness 亮度：-1.0 ~ 1.0
     *  @param saturation 饱和度
     *  @param contrast   对比度
     *
     *  @return 完成图片
     */
    static func colorControlsWithOriginalImage(image: UIImage, brightness: CGFloat, saturation: CGFloat, contrast: CGFloat) -> UIImage {
        let context = CIContext(options: nil)
        let inputImage = CIImage(cgImage: image.cgImage!)
        let filter = CIFilter(name: "CIColorControls")
        filter?.setValue(inputImage, forKey: kCIInputImageKey)
        filter?.setValue(brightness, forKey: "inputBrightness")
        filter?.setValue(saturation, forKey: "inputSaturation")
        filter?.setValue(contrast, forKey: "inputContrast")
        let result = filter?.value(forKey: kCIOutputImageKey) as! CIImage
        let cgImage = context.createCGImage(result, from: result.extent)
        let resultImage = UIImage(cgImage: cgImage!)
        return resultImage
    }
    
}

/*
#pragma mark _____对图片进行滤镜处理_______
//  怀旧
/**
 *  对图片进行滤镜处理
 *
 *  @param image 目标图片
 *  @param name  滤镜名称
 *
 *  @return 完成图片
 */
+ (UIImage *)filerWithOriginalImage:(UIImage *)image fileterName:(NSString *)name{
    CIContext * context = [CIContext contextWithOptions:nil];
    CIImage * inputImage = [[CIImage alloc] initWithImage:image];
    CIFilter * filter = [CIFilter filterWithName:name];
    [filter setValue:inputImage forKey:kCIInputEVKey];
    CIImage * result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage * resultImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return resultImage;
}
    /**
     *  截取一张 view 生成图片
     *
     *  @param view 目标View
     *
     *  @return 生成的图片
     */
    + (UIImage *)shotWithView:(UIView *)view{
        UIGraphicsBeginImageContext(view.bounds.size);
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
        }
        
        /**
         *  截取view中某个区域生成一张图片(先截取View)
         *
         *  @param view  目标View
         *  @param scope 目标大小
         *
         *  @return 生成的图片
         */
        + (UIImage *)shotWithView:(UIView *)view scope:(CGRect)scope{
            CGImageRef imageRef = CGImageCreateWithImageInRect([self shotWithView:view].CGImage, scope);
            UIGraphicsBeginImageContext(scope.size);
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGRect rect = CGRectMake(0, 0, scope.size.width, scope.size.height);
            CGContextTranslateCTM(context, 0, rect.size.height);//  下移
            CGContextScaleCTM(context, 1.0f, -1.0f);
            CGContextDrawImage(context, rect, imageRef);
            UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            CGContextRelease(context);
            return image;
 
 /**
 *  创建一张实时模糊效果 View (毛玻璃效果)
 *
 *  @param frame frame
 *
 *  @return effectView
 */
 + (UIVisualEffectView *)effectViewWithFrame:(CGRect)frame{
 UIBlurEffect * effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
 UIVisualEffectView * effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
 effectView.frame = frame;
 return effectView;
 }
}
*/
