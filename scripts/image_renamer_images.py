import os

files = [ f for f in os.listdir('.') if os.path.isfile(f) and f.endswith('.jpg') ]

image_set = 1
image_number = 1

for file in files:
    newname = str(image_set) + '_' + str(image_number) + '.jpg'
    print('renaming ' + str(file) + ' to ' + str(newname))
    os.rename(file, newname)
    image_number += 1
    if image_number == 7:
        image_set += 1
        image_number = 1

