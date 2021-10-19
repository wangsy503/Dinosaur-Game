import cv2 as cv
import numpy as np

# img_path = 'C:/Users/Sam_She/Desktop/dinasaur.jpg'
img_path = './yun.png'


# img = np.reshape(cv.imread(img_path), (80, 80, 3))
img = cv.imread(img_path, -1) 
mBackground = img[:,:,3] == 0
img[mBackground] = (255,255,255,255)

img = img[:,:,0:3]


# fix rgba color, refer to stackoverflow.com/questions/3803888/how-to-load-png-images-with-4-channels
h, w = img.shape[0:2]
h = h//2
w = w//2

# img = np.reshape(img, (h//2, w//2, 3))
# h, w = img.shape[0:2]
# img = np.reshape(img, (h//2, w//2, 3))
# h, w = img.shape[0:2]

result_array = [0 for i in range(h*w)]
demo = np.zeros([h,w,3],dtype='uint8')


for i in range(h*w):
    y = (i//w) * 2
    x = (i%w) * 2
    bgr = img[y, x]
    u16 = (int(bgr[2]/255*31)<<11) + (int(bgr[1]/255*63)<<5) +( int(bgr[0]/255*31))
    result_array[i] = u16 # draw point
    demo[i//w, i%w] = bgr
    # result_array[x+y*80] = u16
    # print(y,x)
result_array = [str(hex(i)) for i in result_array]
result = ','.join(result_array)
print(result)


cv.imwrite('img.png', demo)
for i in range(h):
	for j in range(w):
		if (result_array[j + w * i]) == result_array[0]:
			print("-", end="")
		else:
			print("0", end="")
	print("")
cv.imwrite('img.png', demo)

# for i in range(img.shape[0]):
# 	for j in range(img.shape[1]):
# 		if (img[i,j,1]) >= 100:
# 			print("-", end="")
# 		else:
# 			print("0", end="")
# 	print("")
