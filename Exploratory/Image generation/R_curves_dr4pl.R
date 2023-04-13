# import libraries
library(dr4pl)
library(ggplot2)

# read in the raw data file
gdsc_trip <- read.csv('exploratory/data/gdsc_triplicates.csv')

# make directories if necessary
if (!dir.exists('exploratory/curve_images')) {dir.create('exploratory/curve_images')}
if (!dir.exists('exploratory/data')) {dir.create('exploratory/data')}

# initialize n to count images
n = 0

# make a new dataframe to save metrics
gdsc_df = data.frame(matrix(nrow=0, ncol=14))
colnames(gdsc_df) <- c('cell','drug','min_conc','max_conc','min_norm_intensity','max_norm_intensity','mean_sd','convergence','upper_limit','IC50','slope','lower_limit','file_path','image_name')

# generate image for unique plate, drug, and cell line
for(plate in unique(gdsc_trip$DRUGSET_ID)){
  df <- gdsc_trip[gdsc_trip$DRUGSET_ID==plate,]
  for(drug in unique(df$DRUG_ID)){
    df2 <- df[df$DRUG_ID==drug,]
    for(cell in unique(df2$CELL_ID)){
      tryCatch({df3 <- df2[df2$CELL_ID==cell,]
      
        # generate data metrics
        min_conc <- min(df3$CONC)
        max_conc <- max(df3$CONC)
        min_norm_intensity <- min(df3$norm_intensity)
        max_norm_intensity <- max(df3$norm_intensity)
        mean_sd <- mean(aggregate(df3$norm_intensity, list(df3$CONC), FUN=sd)$x)
        
        # generate the curve and metrics
        curve <- dr4pl(df3$norm_intensity~df3$CONC, method.init='logistic')
        data <- curve$data
        upper_limit <- curve$parameters[1]
        IC50 <- curve$parameters[2]
        slope <- curve$parameters[3]
        lower_limit <- curve$parameters[4]
        convergence <- curve$convergence
        
        # create a unique file name and path for image
        image_name <- paste("image_", n, ".jpg", sep = "")
        file_path <- file.path("exploratory/curve_images", image_name)
        
        # save data to dataframe
        gdsc_df[nrow(gdsc_df)+1,] <- list(cell, drug, min_conc, max_conc, min_norm_intensity, max_norm_intensity, mean_sd, convergence, upper_limit, IC50, slope, lower_limit, file_path, image_name)
        
        # save the image
        jpeg(file=file_path)
        print(plot(curve, text.title='', text.y='', text.x='') 
              + ylim(0,1.5) 
              + theme(axis.text.x=element_blank(), axis.text.y=element_blank()))
        dev.off()
        n = n+1
        
      }, error=function(e){cat('ERROR :', conditionMessage(e), '\n')})
    }
  }
}

# save the dataframe as csv
write.csv(gdsc_df, 'exploratory/data/triplicate_images.csv', row.names=FALSE)
