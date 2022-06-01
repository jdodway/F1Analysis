def DriversChamp(year):
    #Function to ouptut and graph desired F1 Season

    #read in file with either file path to csv or raw file url lunk
    url = 'https://raw.githubusercontent.com/jdodway/F1Analysis/main/F1QueryResults/F1EveryRace.csv'
    df=pd.read_csv(url)
    df=df[df['year']==year]

    #Combine names into one full-name
    df['Driver Names'] = df['forename']+' '+df['surname']
    
    #Create Pivot table to graph data from
    races= pd.pivot_table(df,index=['raceId'], columns='Driver Names',values='points')
    races.fillna(0,inplace=True)
    races.insert(0,'Grand Prix',df['name'].unique())
    races.set_index('Grand Prix',inplace=True)

    #Create a copy data frame
    graph=races.copy()
    
    #Creating a rolling sum from race points
    #Each race will add points onto previous sum
    i=1
    while i != len(races.index):
        graph.iloc[i]=graph.iloc[i]+graph.iloc[i-1]
        i=i+1
    graph=graph.astype(int)
    
    #Grab name of last row
    #Last row shows the total sum of all the race points
    name=graph.iloc[[-1]].index[0]
    
    #Sort driver columns by end-of-season points
    graph=graph.sort_values(by=name, ascending=False,axis=1)
    
    #Table of end-of-season points
    EndingPoints=graph.iloc[[-1]].transpose()
    name=graph.iloc[[-1]].index[0]
    EndingPoints.rename({name:'Season Finishing Points'},axis=1,inplace=True)
    EndingPoints.columns.name = None
    EndingPoints.sort_values('Season Finishing Points',ascending=False,inplace=True)
    print(EndingPoints)

    #Create a list of 9 colors, minus gray
    colors=[]
    for key, value in mcolors.BASE_COLORS.items():
        if key!='tab:gray':
            colors.append(value)
    
    #We are assigning colors to the top 9 drivers in terms of points
    #As well as assigning gray to the other drivers
    #POSSIBLE CHANGE FOR FUTURE: Assign colors to only those competing for championship at last race
    c=[]
    graph.iloc[-1]
    for points in graph.iloc[-1]:
        if points < graph.iloc[-1].nlargest(n=5)[4]:
            c.append('#7f7f7f')
        else:
            c.append(colors.pop(0))
    
    #Graphing
    graph.plot(figsize=(12,12),color=c)

    plt.title(f"{year} Driver's Championship",fontsize=15)
    plt.legend(bbox_to_anchor = (1.05, 1),title='Drivers in order of points')
    plt.xticks(np.arange(len(graph)),graph.index,rotation=90)
    plt.ylabel('Championship Points')
    plt.margins(x=0)
    plt.grid()

    plt.savefig(f'{year} Driver Points.jpeg',bbox_inches='tight')
    plt.show()

    #Points Data
    print(EndingPoints.describe())