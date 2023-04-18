# Capstone

## Background
In cancer drug discovery, researchers may work to identify promising drug candidates by screening large numbers of compounds against a variety of cell lines and then anaylsing the resulting curves to determine the effect of each compound on each individual cell line, choosing the compounds which produce good quality dose response curves for further investigation. A large scale screen such as this can result in millions of datapoints and hundreds of thousands curves that need to be evaluated. This can mean examining the metrics of each curve such as maximum effect of the compound (Amax), the point at which there is 50% of the maximum effect (AC50), and the inflection point of the curve but it also involves visually inspecting the curve images manually. This manual review can be burdensome on the researcher.  

## Project
The goal of our project is to develop an image-based machine learning algorithm that can classify the quality of dose response curves. In this way, curves with poor quality (e.g. high variability between replicate measures, random fluctuations in response that cannot be modelled easily with a curve) can be easily eliminated from further analysis, allowing scientists to focus future validation and research on those compounds that provide the most useful information. 

To generate our final results, we utilized a variety of techniques. Initial data collection and preparation was done in python using pandas. Images were generated in R using the dr4pl and ggplot2 packages. Unsupervised clustering was done using tensorflow, the keras VGG19 model, and sklearn PCA and sklearn KMeans clustering. Analysis of the clusters was performed using sklearn silhouette scoring. A supervised model was generated using sklearn Random Forest. All visualizations were made using matplotlib.

![Screenshot 2023-04-14 at 11 52 35 AM](https://user-images.githubusercontent.com/56646278/232093674-57f2c0de-e017-4d1c-938b-0df2ee11d605.png)

## Data source
#### Genomics of Drug Sensitivity in Cancer Project
https://www.cancerrxgene.org/

#### Direct links to data
https://cog.sanger.ac.uk/cancerrxgene/GDSC_release8.4/GDSC1_public_raw_data_24Jul22.csv.zip
https://cog.sanger.ac.uk/cancerrxgene/GDSC_release8.4/GDSC2_public_raw_data_24Jul22.csv.zip

## How to use this repository
Jupyter notebooks and R code can be found in the "Final" folder. Run in the following order to complete the project from start to finish: Data collection; Data processing; Image generation; Model generation; Labeling, visualizations, and analysis; Supervised learning. An brief explantation of each notebook can be found under "Directory" below. See "Code input and outputs.txt" for a full list of required input and generated output for all code. For the "Final/Labeling, visualizations, and analysis" notebook, users will manually label the clusters according to quality of the curves within. 

The format of the project is Jupyter Notebooks with the exception of one R script. This format provides the most flexibility to users. If using this project as a framework to analyze another raw data source, there are multiple parameters that can be optimized as well as the manually labeling clusters. These parameters include number of features for PCA, number of clusters for k-means clustering, and hyperparameter tuning for supervised learning.

If using another dataset other than GDSC, deposit input file into "data" directory located in the same directory as the notebooks to be run. The necessary columns are DRUGSET_ID (plate ID), CELL_ID (cell line ID), DRUG_ID (compound ID), TAG (compound annotation), ASSAY (type of readout), DURATION (length of experiment), SEEDING_DENSITY (number of cells plated at beginning of experiment), CONC (concentration of compound), and INTENSITY (readout of experiment). Data must be at least in triplicates. Code can be run starting at the "Final/Data processing" notebook.

Additional notebooks can be found in the Exploratory folder. These include exploratory work into different curve generation in python and R, optimization of VGG CNN models, and training and testing of multiple supervised learning approaches. 

## Directory
* README.md
* LICENSE
* requirements.txt
* Code input and output.txt
* Reports
  * Final presentation.pptx
* Final - final version of code
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
  * Supervised learning.ipynb
    * Train supervised model to predict curve label
* Exploratory - exploratory notebooks
  * Data collection and processing
    * Capstone triplicates playground.ipynb
      * Data import, dataset visualisations and processing, curve generation in python
    * Data processing - triplicates.ipynb
      * Data import and processing
  * Image generation
    * Capstone_GDSC_Normalized_Curves_silmplydrug_RKD.ipynb
      * Data processing and images of curves made using simplydrug package in python
    * image_generation.R
      * Images of curves made using dr4pl package in R
  * Model generation
    * Exploratory unsupervised models.ipynb
      * Generate clusters with VGG16, PCA, and KMeans clustering using dr4pl images
    * Capstone_deep_learning_curves_images_RKD.ipynb
      * Generate clusters with VGG16, PCA, and KMeans clustering using simplydrug images
    * Unsupervised image classifier functions, pca and kmeans clustering code.ipynb
      * Clean code to generate clusters with VGG model, PCA, and KMeans clustering using dr4pl images
    * VGG19_notebook
      * Generate clusters with VGG19, PCA, and KMeans clustering using dr4pl images to compare directly with VGG16_notebook
    * VGG16_notebook
      * Generate clusters with VGG16, PCA, and KMeans clustering using dr4pl images to compare directly with VGG19_notebook
  * Labeling, visualizations, and analysis
    * 699 visualisations.ipynb
      * 2D and 3D PCA plots with clusters
    * Labels.ipynb
      * Generate table with curve metrics and labels
    * VGG19 visualizations.ipynb
      * 2D and 3D PCA plots with labels
  * Supervised learning
    * GDSC_triplicate_batch_Supervised_ML_RKD.ipynb
      * Feature selection, hyperparameter tuning, linear regression, logistic regression, decision tree, confusion matrix, voting, bagging, gradient boosting, stacking, linear svc, k-neighbors, and ada boost
    * GDSC_triplicate_batch_Supervised_ML_RKD_Updated.ipynb
      * Hyperparameter tuning, decison tree, voting, bagging, gradient boosting, stacking, logistic regression, SGD, SVC, k-neighbors, extra trees, ada boost
    * Random Forest.ipynb
      * Hyperparameter tuning, Random Forest, confusion matrix, and feature importance
