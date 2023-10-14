function feats = sc_feat_combine(method)
%function sc_yeastfeatcalc(har_intbins, downsamplerate,featset)
%SC_YEASTFEATCALC  A function for cell/field feature calculation 
%   22-Nov-2005 Initial write T. Zhao
%   09-Aug-2006 Modified S.C. Chen

imglist = load(method.procfilesmatname);
nprocfiles = length(imglist.procfiles{1});

if method.celllevel == 1
    resultdir180feat = [method.resultdir filesep method.thresmethod 'feat_b256_d1'];
    resultdir = [method.resultdir filesep method.thresmethod 'feat_b' num2str(method.har_intbins) '_d' num2str(method.downsamplerate)]; 
    segdirpath = [method.resultdir filesep 'handseg'];
else
    fprintf(1,'error\n');
end

feats = [];
c = method.c;
for n=1:nprocfiles   
        featFileName = ['feat' num2str(n) '_c' num2str(c)];
        resultfile = [resultdir filesep featFileName '.mat'];
        if exist(resultfile) 
            tmp = load(resultfile);
            feats = [feats; tmp.feats];
        end
end
