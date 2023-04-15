# Capstone

## Background
In cancer drug discovery, researchers may work to identify promising drug candidates by screening large numbers of compounds against a variety of cell lines and then anaylsing the resulting curves to determine the effect of each compound on each individual cell line, choosing the compounds which produce good quality dose response curves for further investigation. A large scale screen such as this can result in millions of datapoints and hundreds of thousands curves that need to be evaluated. This can mean examining the metrics of each curve such as maximum effect of the compound (Amax), the point at which there is 50% of the maximum effect (AC50), and the inflection point of the curve but it also involves visually inspecting the curve images manually. This manual review can be burdensome on the researcher.  

## Project
The goal of our project is to develop an image-based machine learning algorithm that can classify the quality of dose response curves. In this way, curves with poor quality (e.g. high variability between replicate measures, random fluctuations in response that cannot be modelled easily with a curve) can be easily eliminated from further analysis, allowing scientists to focus future validation and research on those compounds that provide the most useful information. 

To generate our final results, we utilized a variety of techniques. Initial data collection and preparation was done in python using pandas. Images were generated in R using the dr4pl and ggplot2 packages. Unsupervised clustering was done using tensorflow, the keras VGG19 deep CNN, and sklearn PCA and sklearn KMeans clustering. Analysis of the clusters was performed using sklearn silhouette scoring. A supervised model was generated using sklearn Random Forest. All visualizations were made using matplotlib. In our exploratory work, we also used the simplydrug curve generation package, VGG16 deep CNN, and several supervised learning models including Decision Tree, Voting, Stacking, Extra Tree, and Ada Boost.

![Screenshot 2023-04-14 at 11 52 35 AM](https://user-images.githubusercontent.com/56646278/232093674-57f2c0de-e017-4d1c-938b-0df2ee11d605.png)



## Data source
#### Genomics of Drug Sensitivity in Cancer Project
https://www.cancerrxgene.org/

#### Direct links to data
https://cog.sanger.ac.uk/cancerrxgene/GDSC_release8.4/GDSC1_public_raw_data_24Jul22.csv.zip
https://cog.sanger.ac.uk/cancerrxgene/GDSC_release8.4/GDSC2_public_raw_data_24Jul22.csv.zip

## Directory
* README.md
* LICENSE
* python_requirements.txt
* R_requirements.txt
* Reports
  * Final presentation.pptx
* Final code
  * Data collection.ipynb
    * Import data from GDSC website
  * Data processing.ipynb
    * Clean, normalize, and assemble into triplicates
  * Image_generation.R
    * Generate dose response curves and save as images 
  * Model generation.ipynb
    * Train unsupervised model to cluster images
  * Labeling, visualizations, and analysis.ipynb
    * Analyze clusters and manually label
  * Random Forest.ipynb
    * Train supervised model to predict curve label
* Exploratory notebooks
  * Data collection and processing
    * Capstone triplicates playground.ipynb
      * Data import and processing
    * Data processing - triplicates.ipynb
      * Data import and processing
  * Image generation
    * Capstone_GDSC_Normalized_Curves_silmplydrug_RKD.ipynb
      * Data processing and images of curves made using simplydrug package in python
    * Capstone_GDSC_Normalized_RKD.ipynb
      * 
    * image_generation.R
      * Images of curves made using dr4pl package in R
  * Model generation
    * 699_Images3_VGG16.ipynb
      * 
    * Capstone_deep_learning_curves_images_RKD.ipynb
      * 
    * Unsupervised image classifier functions, pca and kmeans clustering code.ipynb
      * 
  * Labeling, visualizations, and analysis
    * 699 visualisations.ipynb
      * 
    * Labels.ipynb
      * Generate table with curve metrics and labels
    * VGG19 visualizations.ipynb
      * 
  * Supervised learning
    * GDSC_triplicate_batch_Supervised_ML_RKD.ipynb
      * 
    * GDSC_triplicate_batch_Supervised_ML_RKD_Updated.ipynb
      * 
    * Random Forest.ipynb
      * Hyperparameter tuning, training, and testing of Random Forest
