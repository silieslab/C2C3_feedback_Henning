# C2C3_feedback_Henning
This repository contains main code and data from the C2C3 feedback manuscript (Henning et al, unpublished)
All Matlab code, except for the code analyzing behavior data, was written by Miriam Henning. The code for behavior data analysis was written by Madhura Ketkar.
Python Code was written by Deniz Yüzak.


## Code 

##NOTE: to use this code download the circular statistics toolbox from Philipp Berens 
P. Berens, CircStat: A Matlab Toolbox for Circular Statistics, Journal of Statistical Software, Volume 31, Issue 10, 2009 

### ConnectivityC2C3:
Plots the counts of pre- and post-synaptic contacts for C2 and C3 extracted were extracted from the FAFB EM dataset (Dorkenwald et al., 2024)(**Fig.2**) 

### Plot_ONOFF_FlashAnalysis_5sec_C2_C3_gh:
Plots C2 and C3 responses to a full field ON/OFF stimulus (**Fig.3a** and **Suppl.Fig.2**)

### Plot_ONOFF_FlashAnalysis_5sec_Mi1_gh:
Plots Mi1 responses to a full field ON/OFF stimulus (**Fig.4a**)

### Plot_ONOFF_FlashAnalysis_5sec_T4T5_CA_BG_sub_SIMA_gh:
Analyzes T4T5 responses to a full field ON/OFF stimulus for control and C2, C3 and C2C3 double silencing conditions  (**Fig.5a,b,c** and **Suppl.Fig. 3** )

### read_npy_RFData_to_Mat_C2C3:
Analyzes C2 and C3 STRFs that were extracted using Python (**Fig.3c-e**)

### read_npy_RFData_to_Mat_Mi1:
Analyzes Mi1 STRFs that were extracted using Python (**Fig.4b**)

### explore_CA_DATA_DriftingStripes_Polarplots_Kir_C2C3_gh:
Analyzes T4T5 direction selectivity from responses to drifting stripes moving into 8 different directions (**Fig.4** and **Suppl.Fig. 4** )

### explore_8dirEdges_Polarplots_C2C3_mh_gh:
Analyzes C2and C3 direction selectivity from responses to drifting stripes moving into 8 different directions (**Fig.5b**)



## Python Code for STRF Analysis 
To run this Code, raw pdata are required. Please contact mhenning@uni-mainz.de

## behavior analysis code for fig 7, supp. fig 5
The sections of the master scripts aiming to plot the raw traces additionally require raw data, which are not uploaded here. Please contact mhenning@uni-mainz.de.
Processed data required to run the rest of the sections are available in the folder 'Data'.
