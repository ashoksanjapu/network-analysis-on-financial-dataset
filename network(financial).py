# -*- coding: utf-8 -*-
"""
Created on Wed Jan  8 16:27:59 2020

@author: User
"""
import pandas as pd
import networkx as nx
import matplotlib as plt
fraud = pd.read_csv("C:\\Users\\User\\Downloads\\bsNET140513_032310.csv")
fraud = fraud.iloc[0:100,0:5]
#create nodes from columns
g = nx.from_pandas_edgelist(fraud, 'Target', 'fraud')
g
nx.draw_networkx(g)
degree_centrality = nx.degree(g)
#average clustering coefficient 
nx.average_clustering(g)
#closeness centrality 
CLOSENESS_CENTRALITY = nx.closeness_centrality(g)
#node size with Betweenness Centrality
pos = nx.spring_layout(g)
betCent = nx.betweenness_centrality(g, normalized=True, endpoints=True)
node_color = [20000.0 * g.degree(v) for v in g]
node_size =  [v * 10000 for v in betCent.values()]
nx.draw_networkx(g, pos=pos, with_labels=False,
                 node_color=node_color,
                 node_size=node_size )
plt.axis('off')
# labels of the nodes with the highest betweenness centrality
sorted(betCent, key=betCent.get, reverse=True)[:5]
