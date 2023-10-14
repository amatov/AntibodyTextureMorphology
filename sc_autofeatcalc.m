function sc_autofeatcalc(method)
%function sc_yeastfeatcalc(har_intbins, downsamplerate,featset)
%SC_YEASTFEATCALC  A function for cell/field feature calculation 
%   22-Nov-2005 Initial write T. Zhao
%   09-Aug-2006 Modified S.C. Chen

count = 1
while license('checkout','statistics_toolbox')==0
    fprintf(1,'The statistics_toolbox is not avaiable...  Waiting(%d)...', count);  count = count + 1 ;
    pause(30);
end

imglist = load(method.procfilesmatname);
nprocfiles = length(imglist.procfiles{1});

if method.celllevel == 1
    resultdir180feat = [method.resultdir filesep method.thresmethod 'feat_b256_d1'];
    resultdir = [method.resultdir filesep method.thresmethod 'feat_b' num2str(method.har_intbins) '_d' num2str(method.downsamplerate)]; 
    segdirpath = [method.resultdir filesep 'autoseg'];
else
    fprintf(1,'error\n');
end


for n=1:nprocfiles
  segImagePath = imglist.procfiles{1}{n};

    for c=3:3:6
%    for c=2:3:6
    featFileName = ['feat' num2str(n) '_c' num2str(c)];
    
    controlDirectory = [resultdir filesep featFileName];
    [s,msg] = mkdir(resultdir,featFileName);
    %% Check if the job has been taken over
    if strfind(msg,'exist')
        continue;
    end
    
    fprintf(1, 'Processing %dth image(%s)...\n',n,segImagePath);
    resultfile = [resultdir filesep featFileName '.mat'];

    if ~exist(resultfile,'file') & method.celllevel == 1
        if ~exist([segdirpath filesep 'mask' num2str(n) '.mat'],'file')            
            fprintf(1,'The segmentation file does not exist\n');	    
            continue;
        else
            tmp = load([[segdirpath filesep 'mask' num2str(n) '.mat']]);         

            fprintf(1,'Reading segmentation file...');      

            normreg=tz_normreg(tmp.segimg);
            if sum(tmp.segimg(:)) == 0
                fprintf(1, 'No feature can be calculated from empty masks\n');
                continue;
            end
        end

        gfpimgname = imglist.procfiles{c}{n};
        if ~exist(gfpimgname,'file')
            fprintf(1,'GFP image %s does not exist. Skip it...\n',gfpimgname);
            continue;
	else
            fprintf(1,'Reading GFP image...');
	    gfpimg=readcdib(gfpimgname);            
        end

        dnaimgname = imglist.procfiles{1}{n};
	if ~exist(dnaimgname,'file')
            fprintf(1,'DNA image %s does not exist. Skip it...\n',dnaimgname);
            continue;  
	else
            fprintf(1,'Reading DNA image...');
            dnaimg=readcdib(dnaimgname);           
        end	

        feats = [];        
        if method.har_intbins == 256
            feats=sc_regionfeatmat(gfpimg,dnaimg,normreg,'all180',method.har_intbins,method.downsamplerate,method.thresmethod);
        else	  
   	    resultfile180feat = [resultdir180feat filesep featFileName '.mat'];
            if ~exist(resultfile180feat,'file')
                feats=sc_regionfeatmat(gfpimg,dnaimg,normreg,'all180',method.har_intbins,method.downsamplerate,method.thresmethod);
	    else
    	        harfeats=sc_regionfeatmat(gfpimg,dnaimg,normreg,'har',method.har_intbins,method.downsamplerate,method.thresmethod);
                load(resultfile180feat);
                feats(:,73:85) = harfeats;
            end
        end

        save(resultfile,'feats');
        fprintf(1,'%s saved\n\n', resultfile);
     end  
     unix(['rm -rf ' controlDirectory]);
  end
end
