/**
 * This demo shows a simple 2D car steering algorithm and alignment of
 * the car on the 3D terrain surface. The demo also features a third
 * person camera, following the car and re-orienting itself towards the
 * current direction of movement. The camera ensures it's always positioned
 * above ground level too...
 *
 * <p>Usage: use cursor keys to control car
 * <ul>
 * <li>up: accelerate</li>
 * <li>down: break</li>
 * <li>left/right: steer</li>
 * </ul>
 * </p>
 */

/* 
 * Copyright (c) 2010 Karsten Schmidt
 * 
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 * 
 * http://creativecommons.org/licenses/LGPL/2.1/
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 */
import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.math.*;
import toxi.processing.*;

import processing.opengl.*;

float NOISE_SCALE = 0.08f;
PImage img;

Terrain terrain;
ToxiclibsSupport gfx;
Mesh3D mesh;
Car car;

Vec3D camOffset = new Vec3D(0, 100, 300);
Vec3D eyePos = new Vec3D(0, 1000, 0);

void setup() {
  size(1024, 576, OPENGL);
  // create terrain & generate elevation data
  img=loadImage("pulseDraw_169830.jpg");
  img.loadPixels();
  //
  // 
  int pxSize = 2;
  // largeest size
  int size =0; 
  
  float ratio;
    if (img.width <= img.height) {
    size = img.width;
  }
  else {
    size = img.height;
  }
  
  // ... to set pixel height
  //int pxH = int(pxSize * ratio);
  
  int sizeSmall = size/pxSize ;
 
  float[] el = new float[sizeSmall*sizeSmall];
  noStroke();
  int fx =0;
  int fy=0;
  int c=0;
  int i=0;
  for (int x=0; x<size; x+=pxSize) {
    for (int y=0; y<size; y+=pxSize) {
      float bright = brightness(img.get(x,y));
      el[i++] = map(bright, 0,255, 50, 0);
      fy +=1; 
    }
    println(fy ); 
    fx +=1;
  }
 println("pixles " + fx + "pyxels" + fy);
  //60 40
  terrain = new Terrain(sizeSmall,sizeSmall,10);
  terrain.setElevation(el);
  // create mesh
  mesh = terrain.toMesh();
  // create car
  car = new Car(0, 0);
  // attach drawing utils
  gfx = new ToxiclibsSupport(this);
}

void draw() {
  if (keyPressed) {
    if (keyCode == UP) {
      car.accelerate(1);
    }
    if (keyCode == DOWN) {
      car.accelerate(-1);
    }
    if (keyCode == LEFT) {
      car.steer(0.1f);
    }
    if (keyCode == RIGHT) {
      car.steer(-0.1f);
    }
  }
  // update steering & position
  car.update();
  // adjust camera offset & rotate behind car based on current steering angle
  Vec3D camPos = car.pos.add(camOffset.getRotatedY(car.currTheta + HALF_PI));
  camPos.constrain(mesh.getBoundingBox());
  float y = terrain.getHeightAtPoint(camPos.x, camPos.z);
  if (!Float.isNaN(y)) {
    camPos.y = max(camPos.y, y + 100);
  }
  eyePos.interpolateToSelf(camPos, 0.05f);     
  background(0xffaaeeff);
  camera(eyePos.x, eyePos.y, eyePos.z, car.pos.x, car.pos.y, car.pos.z, 0, -1, 0);
  // setup lights
  
  lights();
  directionalLight(242, 130, 20, 0, -1000, -0.5f);
  directionalLight(236, 28, 136, 0.5f, -0.1f, 0.5f);
  ambientLight(80, 60, 54);
  fill(255);
  noStroke();
  // draw mesh & car
  gfx.mesh(mesh, false);
  car.draw();
}
