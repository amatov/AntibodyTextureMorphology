function sc_mkp_GC(rootdir, dirsj, prefix)
% generate procfiles.mat for the GUS STYRYL SCREEN data set
% usage: 
%   sc_makeprocfiles('');

if isempty(rootdir)
    fprintf(1,'Please specify the rootdir');
    return;
end
file1 = dir([rootdir filesep dirsj filesep '*DAPI.tif']);
file2 = dir([rootdir filesep dirsj filesep '*Tubulin.TIF']);

procfiles = cell(2, 1);
filenum = length(file2);

for i=1:filenum
     procfiles{1}{i} = [rootdir filesep dirsj filesep file1(i).name];
     procfiles{2}{i} = [rootdir filesep dirsj filesep file2(i).name];
end

if exist([pwd filesep 'meta' prefix filesep dirsj filesep 'procfiles.mat'], 'file')
   unix(['rm -r ' pwd filesep 'meta' prefix dirsj filesep 'procfiles.mat']);
end

[s, msg] = mkdir([pwd filesep 'meta' prefix filesep dirsj]);

filename = [pwd filesep 'meta' prefix filesep dirsj filesep 'procfiles.mat'];
save(filename,'procfiles','rootdir');
fprintf(1, 'Created %s for %d image sets\n', filename, filenum);

