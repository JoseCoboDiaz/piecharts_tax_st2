# piecharts_tax_st2
This pipeline was designed to transform the output files from SourceTracker2 pipeline (https://github.com/biota/sourcetracker2) into piecharts figure where the size of the pie indicates the percentage of source contribution to each sink, while the colors within the pie indicates the contribution per taxa.

The first step is run sourcetracker2 with <i>--per_sink_feature_assignments</i>, remember that as a <i>.biom</i> format is need to run SourceTracker2, you can transform your <i>.txt</i> abundance matrix by adding <i># Constructed from biom file</i> at first line, and <i>#OTU ID</i> as the header of first column. Samples have to been represented by columns while taxa are represented by rows, using the total count matrix (not transformed to percentage). So, after this modifications, SourceTracker2 can be run by:

        sourcetracker2 --sink_rarefaction_depth 0 --source_rarefaction_depth 0 -i matrix_abundance.txt -m metadata_pie.txt -o st2_output/ --jobs 11 --per_sink_feature_assignments

where metadata_pie.txt is a 3 column matrix with <i>Sample ID</i>, <i>SourceSink</i> and <i>Env</i> as headers.

After that, the obtained matrices has to been transformed into percentage matrices. Put <i>01.recalculate_st2.R</i> and <i>01.auto_recalculate.rb</i> scripts in the <i>st2_output</i> folder. Change at lines 12 and 22 of <i>01.recalculate_st2.R</i> the taxa you want to keep for further analysis, and run this filtering step by:

        ruby auto_recalculate.rb

Now, we need to re-organize the data before the plotting step, by: 

        ruby 02.organize_data_pie.rb

If you want to select only those source samples with significant contribution to sinks, you can select them manually on line 16 of <i>02.organize_data_pie.rb</i>, and by uncomment lines 36 and 38. After the re-organization of data, the piechart can be drawn by:

        Rscript 02.piechart.R

Of course, any modifications on R-script can be done to change colors, figure format or whatever you want or need.
