#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Nov  9 18:05:22 2018

@author: deniz
"""

# TO USE THIS SCRIPT, YOU HAVE TO RUN IT AS A WHOLE (NOT IN INTERACTIVE MODE)


import sys
modulepath = '/Users/Miri/Documents/Python/rf_analysis'
if modulepath not in sys.path:
    sys.path.append(modulepath)
import rf_tools as rt

# Get the
#pdataf, savef, stimpath = config_set.main()

pdataf = '/Users/Miri/Documents/2photon'
#pdataf = '/Users/mhennin2/Documents/2p-imaging-Deniz'

savef = '/Users/Miri/Documents/2photon/Processed_Data/RF-Validation_Method/Tm9'
#savef = '/Users/mhennin2/Documents/2p-imaging/RF-Analysis_Results/Mi1'
#savef = '/Users/mhennin2/Documents/2p-imaging-Deniz/RF-Analysis_Results'
stimpath = '/Users/Miri/Documents/Python/rf_analysis/StimulusData_Discrete_1_12_100000_Seed_735723.mat'

pdatapath = rt.get_fileloc('Select the pData file you want to extract and save',
                           pdataf)
#%%
# rt.saveprocesseddata(pdatapath,savef,stimpath,pick=True,filt=True)



rt.save_rf(savef, 40 ,[1,2], stimpath, dataloc = pdatapath, manualSelectLayer=False)
    

