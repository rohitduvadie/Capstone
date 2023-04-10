gdsc_df = data.frame(matrix(nrow=0, ncol=14))
colnames(gdsc_df) <- c('cell','drug','min_conc','max_conc','min_norm_intensity','max_norm_intensity',
                       'mean_sd','upper_limit','IC50','slope','lower_limit',
                       'file_path','image_name')

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
                min_conc <- min(df7$CONC)
                max_conc <- max(df7$CONC)
                min_norm_intensity <- min(df7$norm_intensity)
                max_norm_intensity <- max(df7$norm_intensity)
                mean_sd <- mean(aggregate(df7$norm_intensity, list(df7$CONC), FUN=sd)$x)
                upper_limit <- curve$parameters[1]
                IC50 <- curve$parameters[2]
                slope <- curve$parameters[3]
                lower_limit <- curve$parameters[4]
                name <- paste(df7$CELL_LINE_NAME, df7$DRUG_ID, df7$DRUGSET_ID, df7$ASSAY, df7$SEEDING_DENSITY, df7$DURATION, df7$batch, sep = '_')
                image_name <- paste(name, '.png', sep='')
                file_path <- file.path("/Users/akfay/Documents/Capstone/triplicate_batch_images", image_name)
                gdsc_df[nrow(gdsc_df)+1,] <- list(cell, drug, min_conc, max_conc, min_norm_intensity, 
                                                  max_norm_intensity, mean_sd, upper_limit, IC50, 
                                                  slope, lower_limit, file_path, image_name)
                }, error=function(e){cat('ERROR :', conditionMessage(e), '\n')})
            }
          }
        } 
      }
    }
  }
}

write.csv(gdsc_df, '/Users/akfay/Documents/Capstone/triplicate_batch_images', row.names=FALSE)
