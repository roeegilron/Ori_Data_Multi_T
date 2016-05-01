function tosavevmp = addmapTovmp(tosavevmp,rawvmp,map3d,mapfn,mapnum)
tosavevmp.NrOfMaps = mapnum;
tosavevmp.Map(mapnum) = rawvmp.Map(1); 
tosavevmp.Map(mapnum).VMPData = map3d;
tosavevmp.Map(mapnum).Name = mapfn; 
end