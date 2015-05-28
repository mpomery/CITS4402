% Generates descriptor database from all files in imsdir and saves in
% filename

function gendb(filename, imsdir)
    f = fopen(filename, 'w');
    [descs, locs, imgids, imgnames] = loadkps(imsdir);
    fwrite(f, size(descs,1), 'uint32');
    fwrite(f, descs, 'double');
    fwrite(f, locs, 'double');
    fwrite(f, imgids, 'double');
    fwrite(f, numel(imgnames), 'uint32');
    for i = 1:numel(imgnames)
        fprintf(f, '%s\n', imgnames{i});
    end
    fclose(f);
end