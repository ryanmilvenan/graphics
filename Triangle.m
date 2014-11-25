//
//  Triangle.m
//  Milvenan Graphics Project
//
//  Created by Wind on 11/24/14.
//  Copyright (c) 2014 Ryan Milvenan. All rights reserved.
//

#import "Triangle.h"

const SceneVertex vertices[] = {
    {{-1, -1, 0}, {1, 0, 0, 1}},
    {{1, -1, 0}, {0, 1, 0, 1}},
    {{0, 0, 0}, {0, 0, 1, 1}},
};

const GLubyte indices[] = {
    0, 1, 2
};

@implementation Triangle {
    float _angle;
}

- (instancetype)initWithShader:(Shader *)shader {
    if (self = [super initWithName:"triangle" shader:shader vertices:(SceneVertex *)vertices vertexCount:sizeof(vertices)/sizeof(vertices[0]) indices:(GLubyte *)indices indexCount:sizeof(indices)/sizeof(indices[0])]) {
        
    }
    _angle = 0;
    return self;
}

- (void)updateWithDelta:(NSTimeInterval)dt {
    _angle += .01;
    _angle = fmod(_angle, 360);
    self.rotateZ = _angle;
}

@end
