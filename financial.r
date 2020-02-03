install.packages("igraph")
library(igraph)
install.packages("tidyverse")
library(tidyverse)
install.packages("readr")
library(readr)
install.packages("dplyr")
library(dplyr)
install.packages("tidyverse")
library(tidyverse)
fraud  <- read_csv("C:/Users/User/Downloads/bsNET140513_032310.csv")
fraud <- fraud[1:100,1:5]
fraud
#to create a single dataframe with a column with the unique values
sources <- fraud %>%
  distinct(Source) %>%
  rename(label = Source)

destinations <- fraud %>%
  distinct(Target) %>%
  rename(label = Target)
nodes <- full_join(sources, destinations, by = "label")
nodes
# adding an "id" column to the nodes
nodes <- nodes %>% rowid_to_column("id")
nodes

per_route <- fraud %>%  
  group_by(Source, Target) %>%
  summarise(weight = n()) %>% 
  ungroup()
per_route

edges <- per_route %>% 
  left_join(nodes, by = c("Source" = "label")) %>% 
  rename(from = id)

edges <- edges %>% 
  left_join(nodes, by = c("Target" = "label")) %>% 
  rename(to = id)

edges <- select(edges, from, to, weight)
edges

install.packages("network")
library(network)

routes_network <- network(edges, vertex.attr = nodes, matrix.type = "edgelist", ignore.eval = FALSE)
class(routes_network)
routes_network
plot(routes_network, vertex.cex = 3)
plot(routes_network, vertex.cex = 3, mode = "circle")
detach(package:network)
rm(routes_network)
library(igraph)
routes_igraph <- graph_from_data_frame(d = edges, vertices = nodes, directed = TRUE)
routes_igraph
plot(routes_igraph, edge.arrow.size = 0.2)

plot(routes_igraph, layout = layout_with_graphopt, edge.arrow.size = 0.2)
degree(routes_igraph, mode="all")
closeness(routes_igraph, mode="all", weights=NA, normalized=T)
betweenness(routes_igraph, directed=F, weights=NA, normalized = T)

