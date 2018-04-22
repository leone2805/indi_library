#!/usr/bin/python -u

import os
import time
from picamera import PiCamera
from time import sleep
from fractions import Fraction

with open("/run/shm/camera_params.txt", "w") as text_file:
    text_file.write("%s %s %s %s %s" % (0,0,1,1,1500))
camera = PiCamera(sensor_mode=3)
#camera.resolution = (640,480)
camera.resolution = (1296,972)
camera.framerate=Fraction(1, 6)
camera.shutter_speed = 8000
old_speed = 8000
camera.iso = 800
camera.awb_mode = 'off'
camera.awb_gains = (1.5, 1.5)
camera.exposure_mode = 'night'
inputFile = open('/run/shm/camera_params.txt', 'r')     
zoom = inputFile.readline().rstrip()
inputFile.close()
args = zoom.split(" ")
camera.zoom = (float(args[0]),float(args[1]),float(args[2]),float(args[3])) 
#print camera.zoom
print (time.strftime("%H:%M:%S"))
while True :
    try:
        for i, filename in enumerate(camera.capture_continuous('/run/shm/image{timestamp:%H-%M-%S}.jpg',burst=True)):
        #print(filename)
            os.rename(filename,'/run/shm/image.jpg') 
            inputFile = open('/run/shm/camera_params.txt', 'r')     
            params = inputFile.readline().rstrip()
            inputFile.close()
            args = params.split(" ")
            new_speed = int(args[4])
            if old_speed != new_speed :
                camera.shutter_speed = new_speed
                old_speed = new_speed
            print camera.shutter_speed
            sleep(0.5)
    except (KeyboardInterrupt):
       print "well, ok, if you don't really want to.."
       break
    except:
       print "Some other error happened here"
    sleep(5)

