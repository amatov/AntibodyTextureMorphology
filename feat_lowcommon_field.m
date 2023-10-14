addpath(genpath(['c:\ForAlex\SLIC']));

cellline = {'TMK1','MKN7'};
imgroot = 'C:\ForAlex\GC_IMAGES\';

bins = [256 128 64 32 16 8];
rates = [1];

% method.id = 3;
% method.resolution = 6.45/40;;

method.celllevel=0;
method.thresmethod = 'lowcommon';

for i=1:length(cellline)
    dirs = dir([imgroot filesep cellline{i}]);    dirs([1 2]) = [];
    for j=1:length(dirs)
        method.procfilesmatname = [pwd filesep 'meta' cellline{i} filesep dirs(j).name filesep 'procfiles.mat'];
        method.resultdir = [pwd filesep 'meta' cellline{i} filesep dirs(j).name];            
        method.celllevel=1;

	for b=1:1%length(bins)
            for r=1:1%length(rates)
                method.har_intbins = bins(b);   method.downsamplerate = rates(r);
                sc_fieldfeatcalc(method);
            end
        end
    end
end
