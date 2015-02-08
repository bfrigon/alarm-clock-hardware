#!/bin/sh

TMP_METADATA_FILE="/tmp/_merge_sh_meta.dat"
TMP_PDF_OUTPUT="/tmp/_merge_sh_output.pdf"


change_drawing_title () {
    
    echo "InfoBegin" > $TMP_METADATA_FILE
    echo "InfoKey: Title" >> $TMP_METADATA_FILE
    echo "InfoValue: $2" >> $TMP_METADATA_FILE
    echo "InfoBegin" >> $TMP_METADATA_FILE
    echo "InfoKey: Author" >> $TMP_METADATA_FILE
    echo "InfoValue: Benoit Frigon" >> $TMP_METADATA_FILE
    
    pdftk $1.pdf update_info $TMP_METADATA_FILE output $TMP_PDF_OUTPUT
    cp $TMP_PDF_OUTPUT $1.pdf
}

combine_drawing_files () {

    input_files=""
    current_page=1
    
    echo > $TMP_METADATA_FILE

    for drawing_id in $(echo $2 | tr "," "\n")
    do
        #### Dump metainfo from pdf ####
        meta=$(pdftk clk-dwg-$drawing_id.pdf dump_data)
        
        #### Extract title and number of pages info ####
        title=$(echo "$meta" | sed -n '/InfoKey/ {  N ; s/InfoKey: Title\nInfoValue: \(.*\)/\1/p }')
        num_pages=$(echo "$meta" | sed -n 's/NumberOfPages: \(.*\)/\1/p')
        
        #### Add current drawing to the bookmark data ####
        echo "BookmarkBegin" >> $TMP_METADATA_FILE
        echo "BookmarkTitle: $title" >> $TMP_METADATA_FILE
        echo "BookmarkLevel: 1" >> $TMP_METADATA_FILE
        echo "BookmarkPageNumber: $current_page" >> $TMP_METADATA_FILE
        
        input_files="$input_files clk-dwg-$drawing_id.pdf"

        current_page=$(($current_page+$num_pages))
    done
    
    
    pdftk $input_files cat output $TMP_PDF_OUTPUT
    pdftk $TMP_PDF_OUTPUT update_info $TMP_METADATA_FILE output $1.pdf
}



####################################################
echo "Changing title metadata in pdf files..."

change_drawing_title "clk-dwg-01" "Led matrix PCB" 
change_drawing_title "clk-dwg-02" "Touch keypad PCB" 
change_drawing_title "clk-dwg-03" "Motherboard" 
change_drawing_title "clk-dwg-05" "PCB - Left panel" 
change_drawing_title "clk-dwg-06" "Display base" 
change_drawing_title "clk-dwg-07" "Keypad overlay" 
change_drawing_title "clk-dwg-08" "Display (Model B) - 7-Segment PCB" 
change_drawing_title "clk-dwg-09" "Display (Model B) - Dots PCB" 
change_drawing_title "clk-dwg-10" "Display (Model B) - Base PCB"
change_drawing_title "clk-dwg-11" "Speaker holder"
change_drawing_title "clk-dwg-12" "Battery interface PCB" 
change_drawing_title "clk-dwg-20" "Controller PCB assembly" 
change_drawing_title "clk-dwg-21" "Left panel PCB Assembly" 
change_drawing_title "clk-dwg-22" "24 x 7 Led Matrix" 
change_drawing_title "clk-dwg-23" "Led Matrix PCB Assembly" 
change_drawing_title "clk-dwg-24" "Display Assembly (Model A)" 
change_drawing_title "clk-dwg-25" "Final assembly (Model A)" 
change_drawing_title "clk-dwg-26" "Display (model B) - Segment PCB Assembly" 
change_drawing_title "clk-dwg-27" "Display (Model B) - Base PCB assembly" 
change_drawing_title "clk-dwg-28" "Display Assembly (Model B)" 
change_drawing_title "clk-dwg-29" "Display (model B) - Dots PCB Assembly" 
change_drawing_title "clk-dwg-30" "Final assembly (Model B)" 


####################################################
echo "Combining pdf files for model A..."

combine_drawing_files "clk-dwg" "25,11,03,12,20,05,21,01,22,23,06,24,07,02"
change_drawing_title "clk-dwg" "Alarm clock - model A"


####################################################        
echo "Combining pdf files for model B..."

combine_drawing_files "clk-dwg-model-b" "30,11,03,12,20,05,21,08,26,09,29,10,27,06,28,07,02"
change_drawing_title "clk-dwg" "Alarm clock - model B"


echo        
echo "Done"