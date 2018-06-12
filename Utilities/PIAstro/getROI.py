import struct
import cv2
import numpy as np

refPt = []

WIDTH=101
HEIGHT=67
SCALE=3.0

def nothing(x):
    pass

def click_and_crop(event, x, y, flags, param):

        global refPt, WIDTH, HEIGHT

        if event == cv2.EVENT_LBUTTONDOWN:
                if x <WIDTH:
                  x = WIDTH
                if y < HEIGHT:
                  y = HEIGHT
                refPt = [(x-WIDTH, y-HEIGHT), (x+WIDTH,y+HEIGHT)]
                img = clone.copy()
                cv2.rectangle(img, refPt[0], refPt[1], 255, 2)
                cv2.imshow("img", img)


f = open('indi_record.ser','rb')
file_id, lu_id, color_id, little_endian, image_width, image_height, pixel_depth, frame_count, observer, instrument, telescope, local_date, utc_date = struct.unpack('<14s 7I 40s 40s 40s 2Q',f.read(178))
img = np.fromfile(f, dtype=np.uint8, count=image_width*image_height*3)
img = np.reshape(img, (image_height, image_width,3))
img = cv2.cvtColor(img, cv2.COLOR_RGB2GRAY)
img = cv2.equalizeHist(img)
img = cv2.resize(img,None,fx=1/SCALE, fy=1/SCALE)
WIDTH = int(image_width/10/SCALE)
HEIGHT = int(image_height/10/SCALE)
clone = img.copy()
cv2.namedWindow('img')
cv2.setMouseCallback('img', click_and_crop)
cv2.imshow('img', img)
while True:
        key = cv2.waitKey(1000) & 0xFF
        # if the 'r' key is pressed, reset the cropping region
        if key == ord("r"):
                img = clone.copy()
                cv2.imshow('img', img)
        # if the 'c' key is pressed, break from the loop
        elif key == ord("c"):
                break

if len(refPt) == 2:
        roi = clone[refPt[0][1]:refPt[1][1], refPt[0][0]:refPt[1][0]]
        print str(int(refPt[0][0]*5*SCALE))+","+str(int(refPt[0][1]*5*SCALE))
cv2.destroyAllWindows()
