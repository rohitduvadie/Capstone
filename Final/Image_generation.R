# import libraries
library(dr4pl)
library(ggplot2)

# check if /images and /data exist and if not, create them
if (!dir.exists('images')) {dir.create(file.path(getwd(),'images'))}
if (!dir.exists('data')) {dir.create(file.path(getwd(),'data'))}

# read in the data
triplicates_df <- read.csv('data/triplicates_normalized.csv')

# make a new dataframe to save metrics
gdsc_df = data.frame(matrix(nrow=0, ncol=14))
colnames(gdsc_df) <- c('cell','drug','min_conc','max_conc','min_norm_intensity','max_norm_intensity',
                       'mean_sd','convergence','upper_limit','IC50','slope','lower_limit',
                       'file_path','image_name')

# generate image for unique plate, drug, cell line, assay, seeding density, duration, and batch
for(plate in unique(triplicates_df$DRUGSET_ID)){
  df <- triplicates_df[triplicates_df$DRUGSET_ID==plate,]
  for(drug in unique(df$DRUG_ID)){
    df2 <- df[df$DRUG_ID==drug,]
    for(cell in unique(df2$CELL_ID)){
      df3 <- df2[df2$CELL_ID==cell,]
      for(assay in unique(df3$ASSAY)){
        df4 <- df3[df3$ASSAY==assay,]
        for(seeding in unique(df4$SEEDING_DENSITY)){
          df5 <- df4[df4$SEEDING_DENSITY==seeding,]
          for(duration in unique(df5$DURATION)){
            df6 <- df5[df5$DURATION==duration,]
            for(batch in unique(df6$batch)){
              tryCatch({df7 <- df6[df6$batch==batch,]

                #generate data metrics
                min_conc <- min(df7$CONC)
                max_conc <- max(df7$CONC)
                min_norm_intensity <- min(df7$norm_intensity)
                max_norm_intensity <- max(df7$norm_intensity)
                mean_sd <- mean(aggregate(df7$norm_intensity, list(df7$CONC), FUN=sd)$x)
              
                # generate the curve and metrics
                curve <- dr4pl(df7$norm_intensity~df7$CONC, method.init='logistic')
                data <- curve$data
                upper_limit <- curve$parameters[1]
                IC50 <- curve$parameters[2]
                slope <- curve$parameters[3]
                lower_limit <- curve$parameters[4]
                convergence <- curve$convergence
              
                # create a unique file name and path for image
                name <- paste(df7$CELL_ID[1], df7$DRUG_ID[1], df7$DRUGSET_ID[1], df7$ASSAY[1], df7$SEEDING_DENSITY[1], df7$DURATION[1], df7$batch[1], sep = '_')
                image_name <- paste(name, '.png', sep='')
                file_path <- file.path("images", image_name)
              
                # save data to dataframe
                gdsc_df[nrow(gdsc_df)+1,] <- list(cell, drug, min_conc, max_conc, min_norm_intensity, 
                                                max_norm_intensity, mean_sd, convergence, upper_limit, IC50, 
                                                slope, lower_limit, file_path, image_name)
              
                # save the image
                png(file=file_path)
                print(plot(curve, text.title='', text.y='', text.x='') + ylim(0,1.5) + theme(axis.text.x=element_blank(), axis.text.y=element_blank()))
                dev.off()
              }, error=function(e){cat('ERROR :', conditionMessage(e), '\n')})
            }
          }
        } 
      }
    }
  }
}

# save the dataframe as csv
write.csv(gdsc_df, 'data/triplicate_batch_images.csv', row.names=FALSE)
