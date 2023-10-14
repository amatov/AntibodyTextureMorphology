imgroot = 'C:\ForAlex\GC_IMAGES\HS746T';
dirs = dir([imgroot]);    dirs([1 2]) = [];
dircount = 0;
for j=1:length(dirs)
    dircount = dircount + 1;   fprintf(1,'%2d:',dircount);
    prefix = 'HS746T';
    sc_mkp_GC(imgroot, dirs(j).name, prefix);
end
