addpath(genpath(['c:\ForAlex\SLIC']));
imgroot = 'c:\ForAlex\IMAGES';

dirs = dir([imgroot]);    dirs([1 2]) = [];
imgroot = 'c:\ForAlex\IMAGES';
for j=1:length(dirs)
    filename = [pwd filesep 'meta' filesep dirs(j).name filesep 'procfiles.mat'];
    resultdir = [pwd filesep 'meta' filesep dirs(j).name];
    sc_handseg(filename,resultdir);
end
