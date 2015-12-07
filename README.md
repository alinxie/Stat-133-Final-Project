---
title: "README"
author: "Alice Wang"
date: "December 3, 2015"
output: html_document
---

CONTENTS OF THIS FILE
---------------------

 * Introduction
 * Maintainers
 * Organization
 * Libraries

INTRODUCTION
------------
Title: Pokémon, Natural Disasters and Economic Impacts

From what we’ve seen in the Pokemon series, Pokemon have been characterized to be cute, powerful, and humanity’s coolest friend. But would they be cute outside of the animate world? For our project, we’re trying to see the connection between human mortality causes and natural disasters--natural disasters that may occur due to Pokemon abilities. We will collect data about Pokemon, specifically, Pokemon moves and abilities, as well as the natural disasters in some certain period, and causes of deaths in that period. We will also determine the trend between Pokemon caused natural disasters and US economic growth.

  * For a full description of the module, visit the project
  page:
  http://gastonsanchez.com/teaching/stat133/
  * To track changes:
  https://github.com/alinxie/Stat-133-Final-Project

MAINTAINERS
-----------

  * Andrew Linxie, undergrad at UC Berkeley
  * Jerry Haoming Jiang, undergrad at UC Berkeley
  * Alice Wang, undergrad at UC Berkeley
  
ORGANIZATION
------------
  * First extract all raw data.
  * rawdata saved in "rawdata" subdirectory
  * sources
    ~ “pokeapi.co” 
    ~ “emdat.be”
    ~ “research.stlouisfed.org/fred2/”
WARNING: CHANGE DIRECTORY TO THE DIRECTORY "finalproject" IS IN 
  * Run skeleton.R first to create directories.
  * Run cleaningData.R in code folder
  * Knit Modelling.rmd in code folder 
  * Run report.rmd in report file
      * cleaned data saved in "data" subdirectory
      * Scripts and Report saved in "code" subdirectory
      * Graphical modelling images saved in "images"     
      subdirectory
  * Open report.pdf
  
LIBRARIES
---------

  * "readr" - https://cran.r-project.org/web/packages/readr/in
  dex.html
  * "ggplot2" - ggplot2.org
  * "dplyr" - https://cran.r-project.org/web/packages/dplyr/in
  dex.html
    









