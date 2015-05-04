# CITS4402
Computer Vision Project - Object Recognition in Cluttered Scenes

**Thursday 28th May 2015:** Presentation of the projects from 2:00PM to 3:50PM

**Thursday 28th May 2015 4:00PM:** Final deadline for submitting your project on cssubmit. This is the 2nd last day of the teching semester so no extensions are possible.

## The Project

You are required to develop an object recognition system for a robot. The idea is that a robot can get images or video of its surrounding environment but needs an intelligent computer vision software to process the images and find out what objects are present in the scene. In practice, the scene will have unwanted objects (clutter) and occlusions (objects of interest hidden behind other objects). Your system should account for these. A recognition system can be useful for example if you tell your robot to go to the classroom and bring your hat or your water bottle. The robot can also find its lcoation and navigate based on known locations of fixed objects. 

### Learning Phase/ Training Phase
- Collect 20 objects that you want the robot to be able to recognize. We will call them objects of interest.
- Take multiple images of each object in isolation. Take the images from different directions.
- Extract features from each image of each object.
- See if you can compress the images by projecting them into the PCA space.
- Train a classifier using the original or compressed features

### Testing Phase
- Put a few random objects of interest along with others that are not of interest to form a "scene".
- Take an image of the scene. The scene should have clutter and some objects of interest should be partially occluded.
- Extract similar features from the scene as above.
- Compress the features if you did compression in the learning phase e.g. project them in to the same PCA space.
- Match all the features from the scene to the features of the objects of interest one by one. [You can do indexing here to speed up your search]
- Based on quality and consistency of matches, decide which objects of interest are present in the scene and find their locations.
- Repeat the above steps 30 times (i.e. generate 30 different scenes) and calculate the recognition rate of your system.

Develop a simple GUI for testing your algorithm. The GUI should load a scene image one by one, find objects of interest in it and display the results. The recognition should be fully automatic and you may only specify the directory where the scene images are present. Your code should already know where to find the training data.

**Note:** You are not allowed to use the Matlab Computer Vision Systems Toolbox. The reason is that it is not available in your lab.

## Tools and Tips
You will be given SIFT (Scale Invariant Feature Transform) code to extract features but you are welcome to use other features (alone or in combination with SIFT).

You are allowed to share your objects but not the images of the objects or the scenes. 

You may find the [presentation](http://www.cse.psu.edu/~rtc12/CSE486/lecture31_6pp.pdf) helpful.

Use the matching point pairs to find a transform between the two images.

Copyright: [SIFT](http://www.cs.ubc.ca/~lowe/keypoints/) was developed by David Lowe. It is free only for educational purpose and commercial use requires a license.


## Distribution of Marks
Data collection: At lease 6 images each of 20 objects and 30 scene images (150 in total). [5 marks]

GUI to test your code, the testing phase only: [3 marks]

Feature extraction and organization. [3 marks]

Matching and display of correct matches. [10 marks]

Localization of object (to be shown visually). [4 marks]


####Taken From
http://undergraduate.csse.uwa.edu.au/units/CITS4402/labs/project/project2014.html Some information may be missing
