% Forces the generation of keypoints files for all images in a given
% directory (or the individual image given)

function genkps(imsdir)

% Loop over images in imsdir
imslist = dir(imsdir);
for imf = imslist'
    % Ignore directories and hidden folders
    if imf.isdir || imf.name(1) == '.'
        continue
    end

    % Get full path
    if imf.isdir
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
    sift(impath, true);
end