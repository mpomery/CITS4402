% Load descriptor database from filename

function [descriptors, locations, imageids, imagenames] = loaddb(filename)
    f = fopen(filename, 'r');
    count = fread(f, 1, 'uint32');
    desc = fread(f, [count 128], 'double');
    locs = fread(f, [count 4], 'double');
    imid = fread(f, count, 'double');
    count = fread(f, 1, 'uint32');
    names = cell(1, count);
    for i = 1:count
        names{i} = fgetl(f);
    end
    fclose(f);
    descriptors = desc;
    locations = locs;
    imageids = imid;
    imagenames = names;
end