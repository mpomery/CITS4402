% Attempts to find images in imsdir that match the given scene image

function match(scnfn, imsdir)
    % Find SIFT keypoints for scene image
    [scnimg, scndes, scnloc] = sift(scnfn);
    scndest = scndes';

    dist_ratio = 0.6;   

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
        [objimg, objdes, objloc] = sift(impath);
        
        [dists, inds] = pdist2(scndes, objdes, 'euclidean', 'Smallest', 2);
        match = zeros(size(objdes,1),1);
        for i = 1:size(objdes,1)
            if (dists(1,i) < dist_ratio * dists(2,i))
                match(i) = inds(1,i);
            end
        end
        
        objpts = zeros(0,2);
        scnpts = zeros(0,2);
        for i = 1:size(match)
            if (match(i) > 0)
                objpts(end+1,:) = objloc(i, 1:2);
                scnpts(end+1,:) = scnloc(match(i), 1:2);
            end
        end
        
        maxcon = -1;
        for i = 1:10
            try
                randi = randperm(size(objpts,1), 3);
                trans = fitgeotrans(objpts(randi,:), scnpts(randi,:), 'affine');
                moved = transformPointsForward(trans, objpts);
                pterr = sqrt(sum((moved - scnpts).^2,2));
                cons = pterr < mean(pterr);
                if sum(cons) > maxcon
                    maxcon = sum(cons);
                    keep = cons;
                    besttf = trans;
                end
            catch
                continue
            end
        end
        
        if maxcon < 6
            continue
        end
        
        objpts = objpts(keep,:);
        scnpts = scnpts(keep,:);
        
        hullpts = convhull(scnpts);

        plot(scnpts(:,2), scnpts(:,1), 'r.', 'MarkerSize', 5);
        line(scnpts(hullpts([end 1:end]),2), scnpts(hullpts([end 1:end]),1));
    end
end
