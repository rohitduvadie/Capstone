# Capstone

## Background
In cancer drug discovery, researchers may work to identify promising drug candidates by screening large numbers of compounds against a variety of cell lines and then anaylsing the resulting curves to determine the effect of each compound on each individual cell line, choosing the compounds which produce good quality dose response curves for further investigation. A large scale screen such as this can result in millions of datapoints and hundreds of thousands curves that need to be evaluated. This can mean examining the metrics of each curve such as maximum effect of the compound (Amax), the point at which there is 50% of the maximum effect (AC50), and the inflection point of the curve but it also involves visually inspecting the curve images manually. This manual review can be burdensome on the researcher.  

## Project
The goal of our project is to develop an image-based machine learning algorithm that can classify the quality of dose response curves. In this way, curves with poor quality (e.g. high variability between replicate measures, random fluctuations in response that cannot be modelled easily with a curve) can be easily eliminated from further analysis, allowing scientists to focus future validation and research on those compounds that provide the most useful information. 

We implemented a variety of techniques for this project.

![Screenshot 2023-04-14 at 11 52 35 AM](https://user-images.githubusercontent.com/56646278/232093674-57f2c0de-e017-4d1c-938b-0df2ee11d605.png)


## File structure

