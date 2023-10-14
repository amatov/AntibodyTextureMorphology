cellline = {'TMK1','MKN7'};
imgroot = 'C:\ForAlex\GC_IMAGES\';


bins = [256 128 64 32 16 8];
rates = [1];

method.id = 3;
method.resolution = 6.45/40;;
method.celllevel=1;
method.thresmethod = 'lowcommon';

for c=2:2
    for i=2:2%length(cellline)
        dirs = dir([imgroot filesep cellline{i}]);    dirs([1 2]) = [];
        feats = [];
        for j=1:length(dirs)
            method.procfilesmatname = [pwd filesep 'meta' cellline{i} filesep dirs(j).name filesep 'procfiles.mat'];
            method.resultdir = [pwd filesep 'meta' cellline{i} filesep dirs(j).name];
            method.celllevel=1;

            for b=1:1%length(bins)
                for r=1:1%length(rates)
                    method.har_intbins = bins(b);   method.downsamplerate = rates(r);
                    method.c = c;
                    feats = [feats; sc_feat_combine_auto(method)];
                end
            end
            size(feats)
        end

    end

    pwdstr = pwd;
    savestr = ['FeatC' num2str(c) '.mat'];
    save(savestr,'feats');
    fprintf(1,'%s (%d images) is saved ...\n\n', savestr, size(feats,1));
    
    [H, p] = ttest(feats(1:5,:), feats(6:10,:))
    H'
    p'
end


