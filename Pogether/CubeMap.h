//
//  CubeMap.h
//  Pogether
//
//  Created by KiraMelody on 2017/3/5.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

#ifndef CubeMap_h
#define CubeMap_h

struct CubeMap {
    int length;
    float dimension;
    float *data;
};

void rgbToHSV(float *rgb, float *hsv);
struct CubeMap createCubeMap();

#endif /* CubeMap_h */
