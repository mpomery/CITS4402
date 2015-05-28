% Given the outputs from a call to match(), creates a formatted figure
% showing the matches

function showmatch(scnimg, scnptset, objptset, objnames)

scale_factor = 0.25;

objimgset = cellfun(@(fn) imresize(sift(fn), scale_factor), objnames, 'UniformOutput', false);
objptset = cellfun(@(pts) pts .* scale_factor, objptset, 'UniformOutput', false);
maxheight = max(cellfun(@(im) size(im, 1), objimgset));

objimglocs = [];

% Append all object images below the scene image
finalim = scnimg;
currrow = size(scnimg,1) + 1;
currcol = 1;
for i = 1:numel(objimgset)
    im = objimgset{i};
    objimglocs(end+1,:) = [currrow, currcol];
    brrow = currrow + size(im,1) - 1;
    brcol = currcol + size(im,2) - 1;
    finalim(currrow:brrow, currcol:brcol) = im;
    currcol = brcol + 1;
    if currcol >= size(scnimg,2)
        currrow = currrow + maxheight;
        currcol = 1;
    end
end

colmap = hsv(numel(objimgset));

imshow(finalim);
hold on;

% Draw in all match lines
for i = 1:numel(objimgset)
    scnpts = scnptset{i};
    objpts = objptset{i};
    offset = objimglocs(i,:) - 1;
    objpts = objpts + repmat(offset, size(objpts,1), 1);
    plot([objpts(:,2) scnpts(:,2)]', [objpts(:,1) scnpts(:,1)]', 'Color', colmap(i,:));
end