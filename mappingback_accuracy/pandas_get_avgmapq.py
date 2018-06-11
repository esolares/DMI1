import numpy as np
import pandas as pd
import sys

try:
    sys.argv[1]
except:
    print 'Invalid sam job file or sam job file missing'
    quit()
else:
    if sys.argv[1] == '':
        myfile = sys.argv[1]
    else:
	myfile = sys.argv[1]


mypd = pd.read_csv(myfile, sep='\t', header=None)
print str(np.mean(mypd[1]))
