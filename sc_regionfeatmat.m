function [feats,names,slfnames] = sc_regionfeatmat(img,dnaimg,masks,featset,har_intbins,downsamplerate, thresmethod)
%SC_REGIONFEATMAT Calculate feature matrix of regions in an image.
%   FEATS = SC_REGIONFEATMAT(IMG,DNAIMG,MASKS) returns a feature matrix of 
%   the regions in IMG. DNAIMG is an image from dna channel and used in 
%   feature calculation. See TZ_MASKIMGS for more information about the two
%   parameters IMG and MASKS.
%   
%   [FEATS,NAMES,SLFNAMES] = TZ_REGIONFEATMAT(...) also returns feature
%   names and SLF names.
%
%   See also

%   11-Nov-2005 Initial write T. Zhao
%   14-Mar-2007 Modified by S.-C. Chen
%   Copyright (c) Center for Bioimage Informatics, CMU



if masks == -1
    % Calculate field level features
    regions{1} = img;   dnas{1} = dnaimg;
else
    regions = tz_maskimgs(img,masks);

    if ~isempty(dnaimg)
        dnas = tz_maskimgs(dnaimg,masks);
    end
end

feats = [];
names = [];
slfnames = [];

for k=1:length(regions)
    fprintf(1,'[%d]',k);

    if ~isempty(dnas)
        dnaRegion = dnas{k};
    else
        dnaRegion = [];
    end


    [names, features, slfnames]=ml_featset(double(regions{k}), ...
				  [], double(dnaRegion), featset,0,0,'lowcommon');
    
    feats = [feats; features];
end

fprintf(1,'\n');
