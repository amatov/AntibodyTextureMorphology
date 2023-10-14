imgroot = 'C:\ForAlex\GC_IMAGES\AZ521';
dirs = dir([imgroot]);    dirs([1 2]) = [];
dircount = 0;
for j=1:length(dirs)
    dircount = dircount + 1;   fprintf(1,'%2d:',dircount);
    prefix = 'AZ521';
    sc_mkp_GC(imgroot, dirs(j).name, prefix);
end
