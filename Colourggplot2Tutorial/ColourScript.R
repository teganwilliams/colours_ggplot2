########################################
##                                   ## 
##      Data Visualisation         ##    
##      Colours in ggplot2        ##              
##      by Tegan Williams         ##  
##      last edit 01/12/2022       ##   
##                                   ##
########################################

# Libraries
library(tidyverse)

### Load and explore the data ---
moss <- read_csv("Tutorial/RankAbundance.csv")
view(moss)
str(moss)

# Data Wrangling to get singular relative abundance column
rankabundance <- moss %>% 
  pivot_longer(cols = 2:4, names_to = "microhabitat", values_to = "relativeabundance", values_drop_na = TRUE) %>% 
  rename(rank=Rank)

view(rankabundance) # view our new dataset

### Data Visualisation ---
## 1.1 Key Colour Functions and Uses

# Depending on the type of plot in question, the colour function will be slighlty different, so lets go over the main ones now

# - when using 'colour', we are applying the colours to points, lines and text.
# - when using 'fill' we are applying them to box plots, bar plots, histograms, density plots, etc.

# For groups we first group them using 'colour = VARIABLE TO BE GROUPED' or 'fill = VARIABLE TO BE GROUPED', and then we add:
# - 'scale_colour_manual' and 'scale_fill_manual' followed by '= c("colour1", "colour2", etc) until reaching the desired number of groups
# or for a continous variable, use 'scale_colour_gradient' and 'scale_fill_gradient' followed by (low = "colour1", high = "colour2") to create a gradient between colour1 and colour2

# 1.1.1. Rank Abundance Curves
# a) Scatter with no use of colour functions
(rank_abundance0.1 <-  ggplot(data = rankabundance, 
                              aes(x = rank , 
                                  y = relativeabundance,
                                  group = microhabitat)) +
    geom_point(size = 2.5, shape=18) +
    geom_line(size = 0.7) +
    ylim(0, 0.4) +
    labs(x="Rank", y="Relative Abundance") +
    theme_classic() +
    theme(text = element_text(size = 13),
          legend.position = c(0.8, 0.8),
          axis.title.x = element_text(margin=margin(t=8)), 
          axis.title.y = element_text(margin=margin(r=8))))

ggsave(rank_abundance0.1, filename = "Tutorial/Figures/Recap/rank_abundance0.1.png", device = "png", width= 8, height=5)

# b) Bar plot wih no colour functions
(rank_abundance0.2 <-  ggplot(data = rankabundance, 
                              aes(x = rank , 
                                  y = relativeabundance)) +
    geom_bar(stat = 'identity', 
             position=position_dodge(),
             aes(group = microhabitat)) +
    geom_smooth(se = F, size = 0.6) +
    ylim(0, 0.4) +
    labs(x = "Rank", y = "Relative Abundance") +
    theme_classic() +
    theme(text = element_text(size = 13),
          legend.position = c(0.8, 0.8),
          axis.title.x = element_text(margin=margin(t=8)), 
          axis.title.y = element_text(margin=margin(r=8))))

ggsave(rank_abundance0.2, filename = "Tutorial/Figures/Recap/rank_abundance0.2.png", device = "png", width= 8, height=5)


### 1.1.2 Picking colours

# First select your colours, e.g., using 'Addin -> Colour Picker'
# Then make your own palette (we have 3 factor levels, so we have to select at least 3 colours)

mypalette <- c("#FF9305", "#07BA3A", "#247CFF") # creates a 'vector' or list of 3 colours!

# now we can use this palette to make our colourful plots

# 1.1.3 Adding simple colour functions

# c) Scatter with grouped lines
(rank_abundance1.1 <-  ggplot(data = rankabundance, 
                              aes(x = rank , 
                                  y = relativeabundance ,
                                  colour = microhabitat)) +
    geom_point(size = 2.5, shape=18) +
    geom_line(size = 0.7) +
    scale_colour_manual(values = mypalette) +
    ylim(0, 0.4) +
    labs(x="Rank", y="Relative Abundance") +
    theme_classic() +
    theme(text = element_text(size = 13),
          legend.position = c(0.8, 0.8),
          axis.title.x = element_text(margin=margin(t=8)), 
          axis.title.y = element_text(margin=margin(r=8))))

ggsave(rank_abundance1.1, filename = "Tutorial/Figures/Recap/rank_abundance1.1.png", device = "png", width= 8, height=5)

# d) Bar plot with a single smooth line
(rank_abundance1.2 <-  ggplot(data = rankabundance, 
                              aes(x = rank , 
                                  y = relativeabundance)) +
    geom_bar(aes(fill=microhabitat), 
             stat = 'identity', 
             position=position_dodge()) +
    scale_fill_manual(values = mypalette) +
    geom_smooth(se = F, colour = 1, size = 0.6) +
    ylim(0, 0.4) +
    labs(x = "Rank", y = "Relative Abundance") +
    theme_classic() +
    theme(text = element_text(size = 13),
          legend.position = c(0.8, 0.8),
          axis.title.x = element_text(margin=margin(t=8)), 
          axis.title.y = element_text(margin=margin(r=8))))

ggsave(rank_abundance1.2, filename = "Tutorial/Figures/Recap/rank_abundance1.2.png", device = "png", width= 8, height=5)

# e) Gradient bar plot
(rank_abundance1.3 <-  ggplot(data = rankabundance, 
                              aes(x = rank , 
                                  y = relativeabundance)) +
    geom_bar(aes(fill=relativeabundance), 
             stat = 'identity', 
             position=position_dodge()) +
    scale_fill_gradient(low = "#FF9305", high =  "#07BA3A") +
    geom_smooth(se = F, colour = 1, size = 0.6) +
    ylim(0, 0.4) +
    labs(x = "Rank", y = "Relative Abundance", fill = "Relative Abundance") +
    theme_classic() +
    theme(text = element_text(size = 13),
          legend.position = c(0.8, 0.8),
          axis.title.x = element_text(margin=margin(t=8)), 
          axis.title.y = element_text(margin=margin(r=8))))

ggsave(rank_abundance1.3, filename = "Tutorial/Figures/Recap/rank_abundance1.3.png", device = "png", width= 8, height=5)

# f) Grouped gradient bar plot
(rank_abundance1.4 <-  ggplot(data = rankabundance, 
                              aes(x = rank , 
                                  y = relativeabundance)) +
    geom_bar(aes(fill=relativeabundance, group = microhabitat), 
             stat = 'identity', 
             position=position_dodge()) +
    scale_fill_gradient(low = "#FF9305", high =  "#07BA3A") +
    geom_smooth(aes(colour = microhabitat), se = F, size = 0.5) +
    scale_colour_manual(values = c("black", "firebrick3", "red")) +
    ylim(0, 0.4) +
    labs(x = "Rank", y = "Relative Abundance", fill = "Relative Abundance", colour = "Microhabitat") +
    theme_classic() +
    theme(text = element_text(size = 13),
          legend.position = c(0.8, 0.6),
          axis.title.x = element_text(margin=margin(t=8)), 
          axis.title.y = element_text(margin=margin(r=8))))

ggsave(rank_abundance1.4, filename = "Tutorial/Figures/Recap/rank_abundance1.4.png", device = "png", width= 8, height=5)

### 2. Adding Complexity to colours using colour packages

## 2.2. Viridis 

# Install and Load the package
install.packages("viridis")  
library("viridis")   

# It can be applied to ggplot2 graphs using the following functions:

# - scale_colour_viridis() , for points, lines and text
# - scale_fill_viridis() , for box plots, bars, histograms etc

# Note: you have to add '(option = )' and choose between the 4 viridis palettes

# magma is 'A'
# inferno is 'B'
# plasma is 'C'
# viridis, aka original, is 'D' (or default)

# To generate 'n' number of colours from each palette, you can use these functions:

viridis(39)
magma(39)
inferno(39)
plasma(39)

# This gives us a list of 39 colours (in HEX format) for each of the palettes

# Let's practice using one, I particularly like plasma (C):
# Since it is a gradient scale, we can apply it similarly to earlier in our bar plots

(viridis1 <-  ggplot(data = rankabundance, 
                     aes(x = rank , 
                         y = relativeabundance ,
                         colour = relativeabundance,
                         group = microhabitat)) +
    geom_point(size = 2.5, shape=18) +
    geom_line(size = 0.7) +
    scale_colour_viridis(option = 'C', direction = -1) +
    ylim(0, 0.4) +
    labs(x = "Rank", y = "Relative Abundance", colour = "Relative Abundance") +
    theme_classic() +
    theme(text = element_text(size = 13),
          legend.position = c(0.8, 0.8),
          axis.title.x = element_text(margin=margin(t=8)), 
          axis.title.y = element_text(margin=margin(r=8))))

ggsave(viridis1, filename = "Tutorial/Figures/Packages/viridis1.png", device = "png", width= 8, height=5)

# Now let's use it for grouping purposes
(viridis2 <-  ggplot(data = rankabundance, 
                     aes(x = rank , 
                         y = relativeabundance ,
                         colour = microhabitat)) +
    geom_point(size = 2.5, shape=18) +
    geom_line(size = 0.7) +
    scale_colour_viridis(option = 'C', discrete = TRUE) +
    ylim(0, 0.4) +
    labs(x = "Rank", y = "Relative Abundance", colour = "Microhabitat") +
    theme_classic() +
    theme(text = element_text(size = 13),
          legend.position = c(0.8, 0.8),
          axis.title.x = element_text(margin=margin(t=8)), 
          axis.title.y = element_text(margin=margin(r=8))))

ggsave(viridis2, filename = "Tutorial/Figures/Packages/viridis2.png", device = "png", width= 8, height=5)

# The default group colours the package defines include a very pale yellow, which doesn't look great..
# But we can pick our own colours from the palette:

plasma(10)

# It should look something like this:
# Output: [1] "#0D0887FF", [2] "#47039FFF", [3] "#7301A8FF", [4] "#9C179EFF", [5] "#BD3786FF", 
#         [6] "#D8576BFF", [7] "#ED7953FF", [8] "#FA9E3BFF", 
#         [9] "#FDC926FF", [10] "#F0F921FF"

# To keep them relatively different, we selected [2, 6, 9]
myviridispalette <- c( "#47039FFF", "#D8576BFF","#FDC926FF")

(viridis3 <-  ggplot(data = rankabundance, 
                     aes(x = rank , 
                         y = relativeabundance ,
                         colour = microhabitat)) +
    geom_point(size = 2.5, shape=18) +
    geom_line(size = 0.7) +
    scale_colour_manual(values = myviridispalette) +
    ylim(0, 0.4) +
    labs(x = "Rank", y = "Relative Abundance", colour = "Microhabitat") +
    theme_classic() +
    theme(text = element_text(size = 13),
          legend.position = c(0.8, 0.8),
          axis.title.x = element_text(margin=margin(t=8)), 
          axis.title.y = element_text(margin=margin(r=8))))

ggsave(viridis3, filename = "Tutorial/Figures/Packages/viridis3.png", device = "png", width= 8, height=5)

## 2.3. RColorBrewer

# Load the package
library(RColorBrewer)

# Display the palettes and their names
display.brewer.all()
# Note: Refer back to the exact spelling of the names from this display when calling the palette in functions

# There are 3 types of palettes produced by RColorBrewer:
# - sequential: gradient from light to dark (best for continuous variables)
# - qualitative: set of different colours (best for categorical data)
# - diverging: emphasises extreme highs and lows (generally for continuous data)

# Functions:
# 1. Get colour HEX numbers using brewer.pal(n, 'name')

brewer.pal(3, 'Set2')

# Output: "#66C2A5" "#FC8D62" "#8DA0CB"

# 2. Display 'n' colours from the chosen palette in the viewer
display.brewer.pal(3, 'Set2')

# 3. Colour-Blind friendly palettes:
display.brewer.all(type = "all", colorblindFriendly = TRUE)

# Set the type of palette using 'div', 'qual', 'seq', or 'all'.
# We chose to only display colour-blind friendly palettes of any type.
# The output gives us 27 palettes to choose from.

# Using ColorBrewer in plots
# Just like all colour functions, there are 2 options depending on the type of graph:
# scale_fill_brewer(palette = 'x') and scale_colour_brewer(palette = 'x')

# Let's use them on our data!

# Scatter by group using 'Set2' palette:
(colorbrewer1 <-  ggplot(data = rankabundance, 
                     aes(x = rank , 
                         y = relativeabundance ,
                         colour = microhabitat)) +
    geom_point(size = 2.5, shape=18) +
    geom_line(size = 0.7) +
    scale_colour_brewer(palette = "Set2") +
    ylim(0, 0.4) +
    labs(x = "Rank", y = "Relative Abundance", colour = "Microhabitat") +
    theme_classic() +
    theme(text = element_text(size = 13),
          legend.position = c(0.8, 0.8),
          axis.title.x = element_text(margin=margin(t=8)), 
          axis.title.y = element_text(margin=margin(r=8))))

ggsave(colorbrewer1, filename = "Tutorial/Figures/Packages/colorbrewer1.png", device = "png", width= 8, height=5)

# Bar plot grouped using 'Greens' and 'YlOrRd' palettes:
(colorbrewer2 <-  ggplot(data = rankabundance, 
                              aes(x = rank , 
                                  y = relativeabundance,
                                  fill = microhabitat)) +
    geom_bar(stat = 'identity', 
             position = position_dodge()) +
    scale_fill_brewer(palette = "Greens", direction = -1) +
    geom_smooth(aes(colour = microhabitat), size = 0.5, se = F) +
    scale_colour_brewer(palette = "YlOrRd", direction = -1) +
    ylim(0, 0.4) +
    labs(x = "Rank", y = "Relative Abundance", fill = "Microhabitat", colour = "Microhabitat") +
    theme_classic() +
    theme(text = element_text(size = 13),
          legend.position = c(0.8, 0.8),
          axis.title.x = element_text(margin=margin(t=8)), 
          axis.title.y = element_text(margin=margin(r=8))))

ggsave(colorbrewer2, filename = "Tutorial/Figures/Packages/colorbrewer2.png", device = "png", width= 8, height=5)


## 2.4. ggsci palettes

# NPG

# Install and Load
install.packages("ggsci")
library(ggsci)

# Scatter by group using NPG package:
(NPGscatter <-  ggplot(data = rankabundance, 
                         aes(x = rank , 
                             y = relativeabundance ,
                             colour = microhabitat)) +
    geom_point(size = 2.5, shape=18) +
    geom_line(size = 0.7) +
    scale_colour_npg() +
    ylim(0, 0.4) +
    labs(x = "Rank", y = "Relative Abundance", colour = "Microhabitat") +
    theme_classic() +
    theme(text = element_text(size = 13),
          legend.position = c(0.8, 0.8),
          axis.title.x = element_text(margin=margin(t=8)), 
          axis.title.y = element_text(margin=margin(r=8))))

ggsave(NPGscatter, filename = "Tutorial/Figures/Packages/NPGscatter.png", device = "png", width= 8, height=5)


# Material Design colours

# These colours require an extra package installed 
install.packages("shiny")
library(shiny)

# Bar plot using Material Design colour 
(MaterialDesign <-  ggplot(data = rankabundance, 
                         aes(x = rank , 
                             y = relativeabundance,
                             group = microhabitat)) +
    geom_bar(stat = 'identity', 
             position = position_dodge(),
             aes(fill = relativeabundance)) +
    scale_fill_material("light-blue") +
    geom_smooth(aes(colour = microhabitat), size = 0.8, se = F) +
    scale_colour_manual(values = c("#D41357", "#029149", "#990697")) +
    ylim(0, 0.4) +
    labs(x = "Rank", y = "Relative Abundance", fill = "Relative abundance", colour = "Microhabitat") +
    theme_classic() +
    theme(text = element_text(size = 13),
          legend.position = c(0.8, 0.6),
          axis.title.x = element_text(margin=margin(t=8)), 
          axis.title.y = element_text(margin=margin(r=8))))

ggsave(MaterialDesign, filename = "Tutorial/Figures/Packages/materialdesign.png", device = "png", width= 8, height=5)


## 2.5. Wes Anderson

# Install and Load
devtools::install_github("karthik/wesanderson")
library(wesanderson)
names(wes_palettes)

# Function:
# wes_palette('name', n, type = c("discrete", "continuous"))
# where name is the palette, n is the number of colours desired and type is either discrete or continuous.

# Applying wes palettes in ggplot2 is quite straightforward:
# scale_fill_manual(values = wes_palette("name", n = n)) (or using 'scale_colour_manual')

# Lets look at 2 final examples using our data:

(WesAnderson1 <-  ggplot(data = rankabundance, 
                       aes(x = rank , 
                           y = relativeabundance ,
                           colour = microhabitat)) +
    geom_point(size = 2.5, shape=18) +
    geom_line(size = 0.7) +
    scale_colour_manual(values = wes_palette("Moonrise3")) +
    ylim(0, 0.4) +
    labs(x = "Rank", y = "Relative Abundance", colour = "Microhabitat") +
    theme_classic() +
    theme(text = element_text(size = 13),
          legend.position = c(0.8, 0.8),
          axis.title.x = element_text(margin=margin(t=8)), 
          axis.title.y = element_text(margin=margin(r=8))))

ggsave(WesAnderson1, filename = "Tutorial/Figures/Packages/WesAnderson1.png", device = "png", width= 8, height=5)

# For a gradient scale, we first have to make a palette:

gradientpalette <- wes_palette("Moonrise3", 100, type = "continuous")

(WesAnderson2 <-  ggplot(data = rankabundance, 
                           aes(x = rank , 
                               y = relativeabundance,
                               group = microhabitat)) +
    geom_bar(stat = 'identity', 
             position = position_dodge(),
             aes(fill = relativeabundance)) +
    scale_fill_gradientn(colours = gradientpalette) +
    geom_smooth(aes(colour = microhabitat), size = 0.8, se = F) +
    scale_colour_manual(values = wes_palette("Royal2")) +
    ylim(0, 0.4) +
    labs(x = "Rank", y = "Relative Abundance", fill = "Relative abundance", colour = "Microhabitat") +
    theme_classic() +
    theme(text = element_text(size = 13),
          legend.position = c(0.8, 0.6),
          axis.title.x = element_text(margin=margin(t=8)), 
          axis.title.y = element_text(margin=margin(r=8))))

ggsave(WesAnderson2, filename = "Tutorial/Figures/Packages/WesAnderson2.png", device = "png", width= 8, height=5)

# Now you have completed the tutorial and should be able to use whatever colour function you please!
# Test your new skill by trying to find your own personal favourite colour scheme among the many options, so that in the future you won't need to spend so much time deciding on colours!
# Good luck and have fun colouring :)
