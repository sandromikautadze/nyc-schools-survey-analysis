# Quality of NYC Schools - Survey Analysis

## Introduction

This project addresses the following questions: 

* Do student, teacher and parent perceptions of NYC school quality appear to be related to demographic and academic success metrics? 

* Do students, teachers, and parents have similar perceptions of NYC school quality?

This is how the repository is structured:

* **data** contains information on the dataset. Inside of it:

  * **metadata** has descriptions of the datasets
  
  * **raw-data** contains the dataset directly downloaded from the website
  
  * **clean-data** contains the polished dataset used for the analysis

* **output-graphics** contains all plots created during the analysis

* **src** contains all the source code used in the project

* the file **report**, both in *.rmd* and *.pdf*, is a TLDR

If you want to carefully know the data cleaning process, the motivations behind it, the analysis procedure and the reasoning behind the findings, you can read the report instead of this README.

## Exploration and Findings - Summary

The datasets contained information schools' demographics and various indicator of academic performance, like the average SAT score in each school. I also had data on responses to surveys designed to gauge parent, student, and teacher perceptions of the quality of New York City schools.

After cleaning the data and optimizing it for the research question -- see code for more info -- I went on with the analysis.

As far as the first question goes, I concluded that there seems to be some slight correlation, but further investigation would be required.
For the second question, the answer is no. Parents have a better perception than teachers, who have a better perception than students. In simple words, parents love school; students hate it; teacher simply do their job.

## Learning Objectives

* Practicing data cleaning with real-word messy dataset

* Improving the data analysis workflow

* Conducting basic analysis using statistical and graphical methods

* Many other things

## Useful links

[Dataset 1](https://data.cityofnewyork.us/Education/2011-NYC-School-Survey/mnz3-dyi8) - last visited July 7th, 2022

[Dataset 2](https://data.world/dataquest/nyc-schools-data/workspace/file?filename=combined.csv) - last visited July 13th, 2022
