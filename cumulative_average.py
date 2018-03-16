import pandas as pd
#uncomment below if using in jupyter notebook so figure prints inline 
#%matplotlib inline 
from matplotlib import pyplot as plt
import seaborn as sns

# Note: exec command allows you to insert variables into a entire command line to allow for looping 
sns.set(font_scale=2) # doubles the font size of the entire figure 
sns.set_style("ticks") # default seaborn is ugly so I prefer ticks

#######################

for pep in ['STXBP4']:

    # intialize dataframe
    cavg = pd.DataFrame()
    
    # begin figure, mod figsize and dpi as desired
    fig1 = plt.figure(figsize=(12, 9), dpi=500)
    ax1 = fig1.add_subplot(111)
    
    # loops through 3 simulations of the same complex
    for i in range(1,4):
        
        # use the command (grep -nr "DELTA TOTAL" filename.csv) and subtract one from that number, insert that number into skiprows
        # loading csv file from mmpbsa output
        exec("f%s = pd.read_csv('/Users/vyduong/cloudv/WW/ST3/mmpbsa_%s_015_indi4_radi0/mmpbsa_%s_%s.csv',skiprows=3011)" %(i,pep,pep,i))
        
        # calculates cumulative average of just the column labeled "DELTA TOTAL"
        exec("fn%s = f%s['DELTA TOTAL'].expanding().mean()" %(i,i))
        
        # appends cumulative average of single traj to cavg dataframe
        exec("cavg = cavg.append(f%s['DELTA TOTAL'].expanding().mean(), ignore_index=True)" %(i)) 
        
        # standard deviation of cumul. avg. , I don't really plot this
        exec("e%s = f%s['DELTA TOTAL'].expanding().std()" %(i,i))
        
        # PLOT individual cumul. avg. 
        exec("plt.plot(range(1000),fn%s,label='%s')" %(i,i))
        plt.legend()
        exec("plt.title('%s Convergence MMPBSA Calculations')" %(pep))
        plt.ylabel('$\Delta$G')
        plt.xlabel('Frames')
        ax1.get_xaxis().tick_bottom()   # remove top and right ticks
        ax1.get_yaxis().tick_left() # remove top and right ticks

    fig1 = plt.figure(figsize=(12, 9), dpi=500)
    ax1 = fig1.add_subplot(111)
    
    # PLOT average of cumul. avgs. 
    plt.plot(range(1000),cavg.mean())
    plt.ylabel('$\Delta$G')
    plt.xlabel('Frames')
    ax1.get_xaxis().tick_bottom()   # remove top and right ticks
    ax1.get_yaxis().tick_left()
    exec("plt.title('%s Average Convergence MMPBSA Calculations')" %(pep))
