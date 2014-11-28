//
//  Minisub.m
//  Milvenan Graphics Project
//
//  Created by Wind on 11/27/14.
//  Copyright (c) 2014 Ryan Milvenan. All rights reserved.
//

#import "Minisub.h"
#import "minisub_data.h"

@implementation Minisub

- (instancetype)initWithShader:(Shader *)shader {
    if (self = [super initWithName:"minisub" shader:shader vertices:(SceneVertex*) minisub_hull_minisub_data_minisub_Vertices vertexCount:sizeof(minisub_hull_minisub_data_minisub_Vertices)/sizeof(minisub_hull_minisub_data_minisub_Vertices[0])]) {
        [self loadTexture:@"minisub_data.png"];
        self.rotateX = 2*M_PI;
    }
    return self;
}
@end
