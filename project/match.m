% Attempts to find images in imsdir that match the given scene image

function match(scnfn, imsdir)

% Find SIFT keypoints for scene image
[scnimg, scndes, scnloc] = sift(scnfn);
scndest = scndes';

dist_ratio = 0.7;   

imshow(scnimg);
hold on;

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
    [objimg, objdes, objloc] = sift(impath);
    
    [dists, inds] = pdist2(scndes, objdes, 'euclidean', 'Smallest', 2);
    match = zeros(size(objdes,1),1);
    for i = 1:size(objdes,1)
        if (dists(1,i) < dist_ratio * dists(2,i))
            match(i) = inds(1,i);
        end
    end
    
    points = zeros(0,2);
    for i = 1:size(objdes,1)
        if (match(i) > 0)
            points(end+1,:) = scnloc(match(i), [2 1]);
            plot(scnloc(match(i), 2), scnloc(match(i), 1), 'r.', 'MarkerSize', 5);
        end
    end
end