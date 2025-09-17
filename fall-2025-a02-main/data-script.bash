#!/usr/bin/env bash
# data-script.bash
# Author: Sarah Chambers
# This is a bash script to analyze NCBirths2004.csv

# Makes sure that the script will NOT keep running if something goes wrong
set -euo pipefail

# CSV file that is being read from
CSV="NCBirths2004.csv"

# Find the column 
column_finder() {
  awk -F',' -v name="$1" 'NR==1{
    for(i=1;i<=NF;i++){
      gsub(/"/,"",$i); gsub(/\r/,"",$i)
      if(tolower($i)==tolower(name)){ print i; exit }
    }
  }' "$CSV"
}

# Get columns 
weight_column=$(column_finder "Weight")
alcohol_column=$(column_finder "Alcohol")
smoker_column=$(column_finder "Smoker")

# Get baby weight
baby_weight(){
    local vcol=$1 fcol=$2 fval=$3
    awk -F',' -v V="$vcol" -v F="$fcol" -v WANT="$fval" '

    NR>1 {
    for(i=1;i<=NF;i++){ gsub(/"/,"",$i); gsub(/\r/,"",$i) }
    if(tolower($F)==tolower(WANT) && $V ~ /^-?[0-9]+(\.[0-9]+)?$/){ print $V }
    }' "$CSV"
}

# Group-by Analysis: Median Weight by Smoking Status------
# Median requires sorting values and finding the middle element.
median_sort(){
    local file="$1"

    local n; n=$(wc -l < "$file" | tr -d ' ')

    # if there is an empty imput = error
    if (( n == 0 )); then echo "Error"; return; fi

    # if there is an odd count
    if (( n % 2 == 1 )); then
     sed -n "$(( (n+1)/2 ))p" "$file"

    else
     # if there is an even count then arg the 2 middle lines 
     y=$(sed -n "$(( n/2 ))p" "$file")
     z=$(sed -n "$(( n/2 + 1 ))p" "$file")
     echo "($y+$z)/2" | bc -l
    fi
}

# Smoker = no & Smoker = yes
no_smoke=$(mktemp)
baby_weight "$weight_column" "$smoker_column" "No" | sort -n > "$no_smoke"
smoker_no_med=$(median_sort "$no_smoke")

echo "$smoker_no_med" > smoker-no-med.txt

yes_smoke=$(mktemp)
baby_weight "$weight_column" "$smoker_column" "Yes" | sort -n > "$yes_smoke"
smoker_yes_med=$(median_sort "$yes_smoke")

echo "$smoker_yes_med" > smoker-yes-med.txt

echo "The Median Weight of the Baby if Smoker = Yes: $smoker_yes_med"
echo "The Median Weight of the Baby if Smoker = No: $smoker_no_med"

# Group-by Analysis: Average Weight by Alcohol Use------
mean_get(){
    awk '{s+=$1; c++} END{ if(c>0){print s/c} else {print "NaN"} }'
}

alc_no_avg=$( baby_weight "$weight_column" "$alcohol_column" "No" | mean_get )
alc_yes_avg=$( baby_weight "$weight_column" "$alcohol_column" "Yes" | mean_get )

echo "$alc_no_avg"  > alcohol-no-avg.txt
echo "$alc_yes_avg" > alcohol-yes-avg.txt
echo "The Average Weight of the Baby if Alc = Yes: $alc_yes_avg"
echo "The Average Weight of the Baby if Alc = No: $alc_no_avg"

# Standard Deviation Calculation------
# NOTE: Ai-assisted for calculations
std_alc_yes=$(
  baby_weight "$weight_column" "$alcohol_column" "Yes" \
  | awk -v m="$alc_yes_avg" '
      {d=$1-m; ss+=d*d; c++}
      END{ if(c>0){ printf("%.10f\n", sqrt(ss/c)) } else { print "NaN" } }
    '
)

echo "$std_alc_yes" > stddev-alcohol-yes.txt
echo "Standard dev if Alc = Yes: $std_alc_yes"