% Generates SIFT features for the image in imfile. Uses cached copy if
% available unless forcegen is set to true.

function [image, descriptors, locs] = sift(imfile, forcegen)

if ~exist('forcegen', 'var')
    forcegen = false;
end

% Load image
image = imread(imfile);
if size(image, 3) == 3
    image = rgb2gray(image);
end

[rows, cols] = size(image);

kpfile = [imfile '.kps'];

% Generate kpfile if it doesn't exist
if exist(kpfile, 'file') ~= 2 || forcegen
    % Convert into PGM imagefile, readable by "keypoints" executable
    f = fopen('tmp.pgm', 'w');
    if f == -1
        error('Could not open file tmp.pgm');
    end
    fprintf(f, 'P5\n%d\n%d\n255\n', cols, rows);
    fwrite(f, image', 'uint8');
    fclose(f);
    
    % Call keypoints executable
    if isunix
        command = '!./sift';
    else
        command = '!siftWin32';
    end
    command = [command ' < tmp.pgm > ' kpfile];
    eval(command);
    
    delete('tmp.pgm');
end

% Open kpfile and check its header
g = fopen(kpfile, 'r');
if g == -1
    error(['Could not open file ' kpfile]);
end
[header, count] = fscanf(g, '%d %d', [1 2]);
if count ~= 2
    fclose(g);
    error('Invalid keypoint file header');
end
num = header(1);
len = header(2);
if len ~= 128
    fclose(g);
    error('Keypoint descriptor length invalid (should be 128)');
end

% Creates the two output matrices (use known size for efficiency)
locs = double(zeros(num, 4));
descriptors = double(zeros(num, 128));

% Parse kpfile
for i = 1:num
    [vector, count] = fscanf(g, '%f %f %f %f', [1 4]); %row col scale ori
    if count ~= 4
        fclose(g);
        error('Invalid keypoint file format');
    end
    locs(i, :) = vector(1, :);
    
    [descrip, count] = fscanf(g, '%d', [1 len]);
    if (count ~= 128)
        fclose(g);
        error('Invalid keypoint file value');
    end
    % Normalize each input vector to unit length
    descrip = descrip / sqrt(sum(descrip.^2));
    descriptors(i, :) = descrip(1, :);
end
fclose(g);