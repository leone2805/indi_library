# import the necessary packages
import argparse
import cv2

# initialize the list of reference points and boolean indicating
# whether cropping is being performed or not
refPt = []

def nothing(x):
    pass

def click_and_crop(event, x, y, flags, param):
	# grab references to the global variables
	global refPt

	# if the left mouse button was clicked, record the starting
	# (x, y) coordinates and indicate that cropping is being
	# performed
	if event == cv2.EVENT_LBUTTONDOWN:
                if x <150:
                  x = 150
                if y < 100:
                  y = 100
		refPt = [(x-150, y-100), (x+150,y+100)]

	# check to see if the left mouse button was released
	#elif event == cv2.EVENT_LBUTTONUP:
		# record the ending (x, y) coordinates and indicate that
		# the cropping operation is finished
#		refPt.append((x, y))
#		cropping = False

		# draw a rectangle around the region of interest
                image = clone.copy()
		cv2.rectangle(image, refPt[0], refPt[1], (0, 255, 0), 2)
		cv2.imshow("image", image)

# construct the argument parser and parse the arguments
ap = argparse.ArgumentParser()
ap.add_argument("-i", "--image", required=True, help="Path to the image")
args = vars(ap.parse_args())

# load the image, clone it, and setup the mouse callback function
image = cv2.imread(args["image"])
clone = image.copy()
cv2.namedWindow("image")
# create trackbars for color change
cv2.createTrackbar('R','image',0,255,nothing)
cv2.createTrackbar('G','image',0,255,nothing)
cv2.createTrackbar('B','image',0,255,nothing)
switch = '0 : OFF \n1 : ON'
cv2.createTrackbar(switch, 'image',0,1,nothing)

cv2.setMouseCallback("image", click_and_crop)
cv2.imshow("image", image)
# keep looping until the 'q' key is pressed
while True:
	# display the image and wait for a keypress
	#cv2.imshow("image", image)
	key = cv2.waitKey(1000) & 0xFF

	# if the 'r' key is pressed, reset the cropping region
	if key == ord("r"):
		image = clone.copy()
                cv2.imshow("image", image)

	# if the 'c' key is pressed, break from the loop
	elif key == ord("c"):
		break

# if there are two reference points, then crop the region of interest
# from teh image and display it
if len(refPt) == 2:
	roi = clone[refPt[0][1]:refPt[1][1], refPt[0][0]:refPt[1][0]]
	cv2.imshow("ROI", roi)
	cv2.waitKey(0)

# get current positions of four trackbars
r = cv2.getTrackbarPos('R','image')
g = cv2.getTrackbarPos('G','image')
b = cv2.getTrackbarPos('B','image')
s = cv2.getTrackbarPos(switch,'image')
# close all open windows
cv2.destroyAllWindows()
print refPt
print r,g,b,s
