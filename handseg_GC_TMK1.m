addpath(genpath(['c:\ForAlex\SLIC']));
imgroot = 'C:\ForAlex\GC_IMAGES\TMK1';

dirs = dir([imgroot]);    dirs([1 2]) = [];

for j=1:length(dirs)
    filename = [pwd filesep 'metaTMK1' filesep dirs(j).name filesep 'procfiles.mat'];
    resultdir = [pwd filesep 'metaTMK1' filesep dirs(j).name];
    sc_handseg(filename,resultdir);
end
