//
//  Sub.m
//  Milvenan Graphics Project
//
//  Created by Wind on 11/27/14.
//  Copyright (c) 2014 Ryan Milvenan. All rights reserved.
//

#import "Sub.h"
#import "sub_data.h"
#import "Propeller.h"

@implementation Sub {
    Propeller *_prop;
}

- (instancetype) initWithShader:(Shader *)shader {
    if (self = [super initWithName:"sub" shader:shader vertices:(SceneVertex*)Cylinder_sub_data_sub_Vertices vertexCount:sizeof(Cylinder_sub_data_sub_Vertices)/sizeof(Cylinder_sub_data_sub_Vertices[0])]) {
        [self loadTexture:@"sub_data.png"];
        
        self.rotateX = M_PI/2;
        self.rotateY = M_PI;
        self.rotateZ = M_PI;
        
        _prop = [[Propeller alloc]initWithShader:shader];
        [self.children addObject:_prop];
    }
    return self;
}

- (void)updateWithDelta:(NSTimeInterval)dt {
    self.rotateZ += dt;
    for (Node *child in self.children) {
        [child updateWithDelta:dt];
    }
}

@end
