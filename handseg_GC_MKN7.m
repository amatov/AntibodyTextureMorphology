addpath(genpath(['c:\ForAlex\SLIC']));
imgroot = 'C:\ForAlex\GC_IMAGES\MKN7';

dirs = dir([imgroot]);    dirs([1 2]) = [];
imgroot = 'C:\ForAlex\GC_IMAGES\MKN7';
for j=1:length(dirs)
    filename = [pwd filesep 'metaMKN7' filesep dirs(j).name filesep 'procfiles.mat'];
    resultdir = [pwd filesep 'metaMKN7' filesep dirs(j).name];
    sc_handseg(filename,resultdir);
end
