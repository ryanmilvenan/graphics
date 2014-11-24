//
//  SceneVertex.h
//  Milvenan Graphics Project
//
//  Created by Wind on 11/24/14.
//  Copyright (c) 2014 Ryan Milvenan. All rights reserved.
//

typedef enum {
    SceneVertexAttribPosition = 0,
    SceneVertexAttribColor
} SceneVertexAttributes;

typedef struct {
    float Position[3];
    float Color[4];
} SceneVertex;