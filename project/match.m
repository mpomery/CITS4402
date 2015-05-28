% Attempts to find images in imsdir that match the given scene image

function [sceneimage, scenepointset, objectpointset, objectnames] = match(scnfn, dbfile)

scnptset = {};
objptset = {};
objnames = {};

% Find SIFT keypoints for scene image
[scnimg, scndes, scnloc] = sift(scnfn);
[dbdesc, dblocs, dbimid, dbname] = loaddb(dbfile);

dist_ratio = 0.9;
ransac_iters = 200;

% Find best matching between all features in the scene and in the database
[dists, inds] = pdist2(dbdesc, scndes, 'euclidean', 'Smallest', 2);
keep = dists(1,:) < dist_ratio * dists(2,:);
match = horzcat((1:size(inds,2))', inds(1,:)');
match = match(keep,:);
match = sortrows(match, 2);

for id = 1:numel(unique(dbimid))
    selector = (dbimid(match(:,2)) == id);
    if sum(selector) == 0
        continue
    end
    scnpts = scnloc(match(selector,1),1:2);
    objpts = dblocs(match(selector,2),1:2);
    
    if numel(objpts) < 3
        continue
    end
    
    % Do RANSAC to try find a good transform
    wrng = warning('off', 'all');
    minerr = realmax('double');
    for j = 1:ransac_iters
        try
            randi = randperm(size(objpts,1), 3);
            trans = fitgeotrans(objpts(randi,:), scnpts(randi,:), 'affine');
            moved = transformPointsForward(trans, objpts);
            pterr = sqrt(sum((moved - scnpts).^2,2));
            if sum(pterr) < minerr
                minerr = sum(pterr);
                keep = pterr < mean(pterr);
                besttf = trans;
            end
        catch
            continue
        end
    end
    warning(wrng);
    
    if minerr == realmax('double')
        continue
    end
    
    if (sum(keep) < 5) || (100*sum(keep) < sum(dbimid == id))
        continue
    end
    
    objpts = objpts(keep,:);
    scnpts = scnpts(keep,:);
    
    moved = transformPointsForward(besttf, objpts);
    pterr = sqrt(sum((moved - scnpts).^2,2));
%     disp([dbname{id} 9 num2str(mean(pterr)) 9 num2str(std(pterr))])
%   If the best fit we have found isn't good enough, discard this object
    if mean(pterr) > (numel(scnimg) / 200^2)
        continue
    end
    disp(dbname{id})
    
    scnptset{end+1} = scnpts;
    objptset{end+1} = objpts;
    objnames{end+1} = dbname{id};
end

sceneimage = scnimg;
scenepointset = scnptset;
objectpointset = objptset;
objectnames = objnames;