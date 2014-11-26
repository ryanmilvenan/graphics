//
//  Shader.m
//  Milvenan Graphics Project
//
//  Created by Wind on 11/24/14.
//  Copyright (c) 2014 Ryan Milvenan. All rights reserved.
//

#import "Shader.h"
#import "SceneVertex.h"

@implementation Shader {
    GLuint _program;
    GLuint _modelViewMatrixUniform;
    GLuint _projectionMatrixUniform;
    GLuint _textureUniform;
    GLuint _lightColorUniform;
    GLuint _lightAmbientUniform;
    GLuint _lightDiffuseUniform;
    GLuint _lightDirectionUniform;
    GLuint _matSpecularIntensityUniform;
    GLuint _shininessUniform;
}

/************************************
 *                                  *
 *      Configuration Functions     *
 *                                  *
 ************************************/

- (void)compileVertexShader:(NSString *)vertexShader
             fragmentShader:(NSString *)fragmentShader {
    GLuint vertexShaderName = [self compileShader:vertexShader
                                         withType:GL_VERTEX_SHADER];
    GLuint fragmentShaderName = [self compileShader:fragmentShader
                                           withType:GL_FRAGMENT_SHADER];
    
    _program = glCreateProgram();
    glAttachShader(_program, vertexShaderName);
    glAttachShader(_program, fragmentShaderName);
    
    glBindAttribLocation(_program, SceneVertexAttribPosition, "a_Position");
    glBindAttribLocation(_program, SceneVertexAttribColor, "a_Color");
    glBindAttribLocation(_program, SceneVertexTexCoord, "a_TexCoord");
    glBindAttribLocation(_program, SceneVertexNormal, "a_Normal");
    
    glLinkProgram(_program);
    
    self.modelViewMatrix = GLKMatrix4Identity;
    _modelViewMatrixUniform = glGetUniformLocation(_program, "u_ModelViewMatrix");
    _projectionMatrixUniform = glGetUniformLocation(_program, "u_ProjectionMatrix");
    _textureUniform = glGetUniformLocation(_program, "u_Texture");
    _lightColorUniform = glGetUniformLocation(_program, "u_Light.Color");
    _lightAmbientUniform = glGetUniformLocation(_program, "u_Light.AmbientIntensity");
    _lightDiffuseUniform = glGetUniformLocation(_program, "u_Light.DiffuseIntensity");
    _lightDirectionUniform = glGetUniformLocation(_program, "u_Light.Direction");
    _matSpecularIntensityUniform = glGetUniformLocation(_program, "u_MatSpecularIntensity");
    _shininessUniform = glGetUniformLocation(_program, "u_Shininess");
    
    
    GLint linkSuccess;
    glGetProgramiv(_program, GL_LINK_STATUS, &linkSuccess);
    if (linkSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetProgramInfoLog(_program, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messageString);
        exit(1);
    }
}

- (void)useProgram {
    glUseProgram(_program);
    glUniformMatrix4fv(_modelViewMatrixUniform, 1, 0, self.modelViewMatrix.m);
    glUniformMatrix4fv(_projectionMatrixUniform, 1, 0, self.projectionMatrix.m);
    
    glActiveTexture(GL_TEXTURE1);
    glBindTexture(GL_TEXTURE_2D, self.texture);
    glUniform1i(_textureUniform, 1);
    
    glUniform3f(_lightColorUniform, 1, 1, 1);
    glUniform1f(_lightAmbientUniform, 0.1);
    glUniform1f(_lightDiffuseUniform, 0.8);
    glUniform1f(_matSpecularIntensityUniform, 2.0);
    glUniform1f(_shininessUniform, 8.0);
    
    GLKVector3 lightDirection = GLKVector3Normalize(GLKVector3Make(0, 1, -1));
    glUniform3f(_lightDirectionUniform, lightDirection.x, lightDirection.y, lightDirection.z);
    
    
}

- (instancetype)initWithVertexShader:(NSString *)vertexShader fragmentShader:
(NSString *)fragmentShader {
    if ((self = [super init])) {
        [self compileVertexShader:vertexShader fragmentShader:fragmentShader];
    }
    return self;
}


/************************************
 *                                  *
 *          Helper Functions        *
 *                                  *
 ************************************/

- (GLuint)compileShader:(NSString*)shaderName withType:(GLenum)shaderType {
    NSString* shaderPath = [[NSBundle mainBundle] pathForResource:shaderName ofType:@"glsl"];
    NSError* error;
    NSString* shaderString = [NSString stringWithContentsOfFile:shaderPath encoding:NSUTF8StringEncoding error:&error];
    if (!shaderString) {
        NSLog(@"Error loading shader: %@", error.localizedDescription);
        exit(1);
    }
    
    GLuint shader = glCreateShader(shaderType);
    
    const char * shaderStringUTF8 = [shaderString UTF8String];
    int shaderStringLength = (int)[shaderString length];
    glShaderSource(shader, 1, &shaderStringUTF8, &shaderStringLength);
    
    glCompileShader(shader);
    
    GLint compileSuccess;
    glGetShaderiv(shader, GL_COMPILE_STATUS, &compileSuccess);
    if (compileSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetShaderInfoLog(shader, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messageString);
        exit(1);
    }
    
    return shader;
}

@end
