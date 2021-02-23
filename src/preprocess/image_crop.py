import os
import cv2
from glob import glob

# Set your image directory
IMAGE_DIR = 'D:/drug/image'
OUT_DIR = 'D:/drug/cropped'
###

all_image_path = glob(os.path.join(IMAGE_DIR, '*.jpg'))
imageid_path_dict = {int(os.path.splitext(os.path.basename(x))[0]): x for x in all_image_path}

for imageid, path in imageid_path_dict.items():
    imageid = str(imageid)
    img = cv2.imread(path)
    w = img.shape[1] // 2
    left_img = img[:, 0: w]
    right_img = img[:, w: img.shape[1]]
    cv2.imwrite(os.path.join(OUT_DIR, imageid + '_0.jpg'), left_img)
    cv2.imwrite(os.path.join(OUT_DIR, imageid + '_1.jpg'), right_img)
    print(imageid, "done")
