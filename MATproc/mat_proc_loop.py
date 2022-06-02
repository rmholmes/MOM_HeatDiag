# /usr/bin/env python3

import numpy as np
import os
import fileinput

bname = 'P_MOM025_'
outputs = range(15,20)

reg = 0

if reg==0:
    # Global:
    regions = ['Global']*len(outputs)
    types = ['']*len(outputs)
    names = ['%02dG' % x for x in outputs]
elif reg==1:
    # Indo-Pacific:
    regions = ['IndoPacific2BAS']*len(outputs)
    types = ['_ZAREG']*len(outputs)
    names = ['%02dP' % x for x in outputs]
elif reg==2:
    # Atlantic:
    regions = ['Atlantic2BAS']*len(outputs)
    types = ['_ZAREG']*len(outputs)
    names = ['%02dA' % x for x in outputs]
elif reg==3:
    # SO_Atlantic:
    regions = ['SO_Atlantic']*len(outputs)
    types = ['_ZAREG']*len(outputs)
    names = ['%02dSA' % x for x in outputs]
elif reg==4:
    # SO_IndoPacific:
    regions = ['SO_IndoPacific']*len(outputs)
    types = ['_ZAREG']*len(outputs)
    names = ['%02dSP' % x for x in outputs]

for i in range(len(outputs)):
    fname = bname + names[i] + '.qsub'
    os.system('cp Process_MOM_template ' + fname)
    with fileinput.FileInput(fname, inplace=True) as file:
        for line in file:
            line_out = line.replace('XXNAMEXX', bname + names[i]).replace('XXOUTPUTXX', '%01d' % outputs[i]).replace('XXREGIONXX', regions[i]).replace('XXTYPEXX', types[i])
            print(line_out, end='')
    os.system('qsub ' + fname)
            
                    
