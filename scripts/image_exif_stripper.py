import os
import Image

files = [ f for f in os.listdir('.') if os.path.isfile(f) and f.endswith('.jpg') ]

image_set = 1
image_number = 1

for file in files:
    print('stripping ' + str(file))
    image = Image.open(file)

    # next 3 lines strip exif
    data = list(image.getdata())
    image_without_exif = Image.new(image.mode, image.size)
    image_without_exif.putdata(data)

    image_without_exif.save(file)

