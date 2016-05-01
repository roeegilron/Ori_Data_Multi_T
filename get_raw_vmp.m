function rawvmp = get_raw_vmp()
vmpfn = findFilesBVQX(fullfile('..','results'),'blank_vmp_tal_3x3res.vmp');
rawvmp = BVQXfile(vmpfn{1});

end