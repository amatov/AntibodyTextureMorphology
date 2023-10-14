imgroot = 'C:\ForAlex\GC_IMAGES\MKN45';
dirs = dir([imgroot]);    dirs([1 2]) = [];
dircount = 0;
for j=1:length(dirs)
    dircount = dircount + 1;   fprintf(1,'%2d:',dircount);
    prefix = 'MKN45';
    sc_mkp_GC(imgroot, dirs(j).name, prefix);
end