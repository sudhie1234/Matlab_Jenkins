% Demo file to mimic Building MEX File.
copyfile(fullfile(matlabroot,'extern','examples','mex','yprime.c'),'.','f');
mex -v yprime.c