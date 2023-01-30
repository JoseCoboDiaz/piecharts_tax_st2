# piecharts_tax_st2
This pipeline was designed to transform the output files from SourceTracker2 pipeline (https://github.com/biota/sourcetracker2) into piecharts figure where the size of the pie indicates the percentage of source contribution to each sink, while the colors within the pie indicates the contribution per taxa.

The first step is run sourcetracker2 with <i>--per_sink_feature_assignments</i>, remember that as a <i>.biom</i> format is need to run SourceTracker2, you can transform your <i>.txt</i> abundance matrix by adding <i># Constructed from biom file</i> at first line, and <i>#OTU ID</i> as the header of first column. Samples have to been represented by columns while taxa are represented by rows, using the total count matrix (not transformed to percentage). So, after this modifications, SourceTracker2 can be run by:

        sourcetracker2 -i matrix_abundance.txt -m metadata_pie.txt -o st2_output/ --jobs 32 --per_sink_feature_assignments

where metadata_pie.txt is a 3 column matrix with <i>Sample ID</i>, <i>SourceSink</i> and <i>Env</i> as headers.

After that, the obtained matrices has to been filtered to keep those taxa with highest influence on SourceTracker analysis, by run these scripts (the first one is only to fix format issues):

        ruby 00.quote_header.rb        
        ruby 01.auto_recalculate.rb

Now, we need to extract the list of taxa with importance among all the samples analyzed, to re-run the <i>auto_recalculate</i> script taking all these taxa: 
               
        ruby 01b.select_taxa.rb
        ruby 02.auto_recalculate_selected.rb

So now, we are ready to extract the info in a matrix for further plot in R:

        ruby 03.organize_data_pie.rb
        
        Rscript 04.piechart.R

Of course, any modifications on the R-script for plot piechart can be done to change colors, figure format or whatever you want or need.

Enjoy!
