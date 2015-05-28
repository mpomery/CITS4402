% Load keypoints for all images in a given
% directory (or the individual image given)

function [descriptors, locations, imageids, imagenames] = loadkps(imsdir)

descs = []; locs = []; imgids = []; imgnames = {};
totaldescs = 0;
% Loop over images in imsdir
imslist = dir(imsdir);
for imf = imslist'
    % Ignore directories and hidden folders
    if imf.isdir || imf.name(1) == '.'
        continue
    end

    % Get full path
    if exist(imsdir, 'file') == 2
        impath = imsdir;
    else
        impath = fullfile(imsdir, imf.name);
    end
    
    % Only consider images
    try
        imfinfo(impath);
    catch
        continue;
    end
    
    % Compute SIFT keypoints
    [~, desc, loc] = sift(impath);
    descs = vertcat(descs, desc);
    locs = vertcat(locs, loc);
    imgnames{end+1} = impath;
    imgids = vertcat(imgids, repmat(size(imgnames,2), size(desc,1), 1));
end

descriptors = descs;
locations = locs;
imagenames = imgnames;
imageids = imgids;