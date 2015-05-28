% Detects all objects in scenes in imsdir. Puts resulting match images in
% outdir

function allscenes(imsdir, outdir)

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
    
    if exist([fullfile(outdir, imf.name) '.png'], 'file') == 2
        continue;
    end
    
    % Only consider images
    try
        imfinfo(impath);
    catch
        continue;
    end
    
    clf reset;
    
    % Compute SIFT keypoints
    [scnimg, scnptset, objptset, objnames] = match(impath, 'obj.db');
    showmatch(scnimg, scnptset, objptset, objnames);
    
    print([fullfile(outdir, imf.name) '.png'], '-dpng');
end