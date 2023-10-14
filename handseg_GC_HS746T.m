addpath(genpath(['c:\ForAlex\SLIC']));
imgroot = 'C:\ForAlex\GC_IMAGES\HS746T';

dirs = dir([imgroot]);    dirs([1 2]) = [];

for j=1:length(dirs)
    filename = [pwd filesep 'metaHS746T' filesep dirs(j).name filesep 'procfiles.mat'];
    resultdir = [pwd filesep 'metaHS746T' filesep dirs(j).name];
    sc_handseg(filename,resultdir);
end