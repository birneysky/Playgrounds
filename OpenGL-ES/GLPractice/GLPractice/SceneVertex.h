//
//  SceneVertice.h
//  GLPractice
//
//  Created by birneysky on 2019/7/24.
//  Copyright © 2019 Grocery. All rights reserved.
//

#ifndef SceneVertice_h
#define SceneVertice_h
#import <GLKit/GLKMathTypes.h>

typedef struct {
    GLKVector3 postionCoords; /// x,y,z
} Vertex;


typedef struct {
    GLKVector3 postionCoords;
    GLKVector2 textureCoords;
} TextureVertex;

#endif /* SceneVertice_h */
