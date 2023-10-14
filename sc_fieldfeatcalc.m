function sc_fieldfeatcalc(method)
%function sc_yeastfeatcalc(har_intbins, downsamplerate,featset)
%SC_YEASTFEATCALC  A function for cell/field feature calculation
%   22-Nov-2005 Initial write T. Zhao
%   09-Aug-2006 Modified S.C. Chen

% count = 1;
% while license('checkout','statistics_toolbox')==0
%     fprintf(1,'The statistics_toolbox is not avaiable...  Waiting(%d)...', count);  count = count + 1 ;
%     pause(30);
% end

imglist = load(method.procfilesmatname);
nprocfiles = length(imglist.procfiles{1});

resultdir180feat = [method.resultdir filesep method.thresmethod 'feat_b256_d1'];
resultdir = [method.resultdir filesep method.thresmethod 'feat_b' num2str(method.har_intbins) '_d' num2str(method.downsamplerate)];


for n=1:nprocfiles
    segImagePath = imglist.procfiles{1}{n};

    for c=2:2
        featFileName = ['feat' num2str(n) '_c' num2str(c)];

        controlDirectory = [resultdir filesep featFileName];
        [s,msg] = mkdir(resultdir,featFileName);

        %    Check if the job has been taken over
        if strfind(msg,'exist')
            continue;
        end

        fprintf(1, 'Processing %dth image(%s)...\n',n,segImagePath);
        resultfile = [resultdir filesep featFileName '.mat'];

        if ~exist(resultfile,'file')

            gfpimgname = imglist.procfiles{c}{n};
            if ~exist(gfpimgname,'file')
                fprintf(1,'GFP image %s does not exist. Skip it...\n',gfpimgname);
                continue;
            else
                fprintf(1,'Reading GFP image...');
                gfpimg=imread(gfpimgname);
            end

            dnaimgname = imglist.procfiles{1}{n};
            if ~exist(dnaimgname,'file')
                fprintf(1,'DNA image %s does not exist. Skip it...\n',dnaimgname);
                continue;
            else
                fprintf(1,'Reading DNA image...');
                dnaimg=imread(dnaimgname);
            end

            % [featnames,feats,fnames]=ml_featset(double(gfpimg), ones(size(dnaimg)), dnaimg, 'mcell',0,0,'lowcommon');
            [featnames,feats,fnames]=ml_featset(double(gfpimg), ones(size(dnaimg)), dnaimg, 'mcell_mor',0,0,'lowcommon');
            % SCALE is micrometers per pixel. If 0 or [] is given, the default scale
            % of 0.23 um/pixel is used.
            % RADIUS is the cell radius in micrometers. If 0 or [] is given, the
            % default radius of 34.5 um is used

            save(resultfile,'feats','featnames','fnames');
            fprintf(1,'%s saved\n\n', resultfile);
        end
    end
    unix(['rm -rf ' controlDirectory]);
end
