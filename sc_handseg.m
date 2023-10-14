function sc_handseg(datafile, resultdir)

if nargin < 1
    error('Exactly 1 arguments are required')
end
mkdir([resultdir filesep 'handseg']);

load(datafile)

for n = 1 : length(procfiles{1})   
    img1 = double(imread(procfiles{1}{n}));
    img2 = double(imread(procfiles{2}{n}));

    img1 = ContrastStretchNorm(img1);
    img2 = ContrastStretchNorm(img2);

    img_show(:,:,1) = mat2gray(img1);
    img_show(:,:,2) = mat2gray(img2);
    img_show(:,:,3) = zeros(size(img1));

    showtitle = procfiles{2}{n}(findstr(procfiles{2}{n}, 'crop'):end);

    figure(1); imshow(img_show);  title(showtitle);

    segimg = zeros(size(img2));

    fprintf('Processing %s...\n',procfiles{2}{n});

    for i = 1:1 % number of cells in the image
        if exist([resultdir filesep 'handseg' filesep 'handmask' num2str(n) '_' num2str(i) '.mat'], 'file')
            continue;
        end

        fprintf('Processing %s...\n',['handmask'  num2str(n) '_' num2str(i) '.mat']);

        mask_cell = roipoly;
%         keyboard
        BWoutline_cell = bwperim(mask_cell);
        segimg = segimg | mask_cell;
        save([resultdir filesep 'handseg' filesep 'handmask' num2str(n) '_' num2str(i) '.mat'], 'mask_cell');
        fprintf(['handmask'  num2str(n) '_' num2str(i) '.mat is saved\n']);
        
        img_show(:,:,1) = mat2gray(segimg);
        img(BWoutline_cell) = 255;
        figure(1); imshow(img_show);    title(procfiles{2}{n});

        fprintf('Click left of the screen to finish up the segmentation for this cell');
        [x, y] = ginput(1);

        if x < 0
            break;
        end
        fprintf('Please segment another cell\n');
    end

    figure(1); imshow(img_show);    title(showtitle);
    fprintf('\nDone with %s...\n\n',showtitle);
    print('-djpeg',[resultdir filesep 'handseg' filesep 'handmask' num2str(n) '.jpg']);

end
