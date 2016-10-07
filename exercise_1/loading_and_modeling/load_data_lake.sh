wget https://data.medicare.gov/views/bg9k-emty/files/Nqcy71p9Ss2RSBWDmP77H1DQXcyacr2khotGbDHHW_s?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip
mv Nqcy71p9Ss2RSBWDmP77H1DQXcyacr2khotGbDHHW_s\?content_type\=application%2Fzip\;\ charset\=binary hospital_files.zip
unzip hospital_files -d hospital_compare

mkdir useful_files
mv Readmissions\ and\ Deaths\ -\ Hospital.csv useful_files/readm_hospital.csv
mv Readmissions\ and\ Deaths\ -\ State.csv useful_files/readm_state.csv
mv Readmissions\ and\ Deaths\ -\ National.csv useful_files/readm_nation.csv
mv Complications\ -\ Hospital.csv useful_files/comp_hospital.csv
mv Complications\ -\ State.csv useful_files/comp_state.csv
mv Complications\ -\ Nation.csv useful_files/comp_nation.csv
mv Timely\ and\ Effective\ Care\ -\ Hospital.csv useful_files/tec_hospital.csv
mv Timely\ and\ Effective\ Care\ -\ State.csv useful_files/tec_state.csv
mv Timely\ and\ Effective\ Care\ -\ National.csv useful_files/tec_nation.csv
mv hvbp_hcahps_05_28_2015.csv useful_files/survey_results.csv

cd useful_files/
mkdir Finished
for f in *.csv; do tail -n +2 "$f" > Finished/"$f"; done
mv Finished/ ../

rm -R hospital_compare
mv Finished hospital_compare
cd hospital_compare
mkdir readm_hospital
mkdir readm_state
mkdir readm_nation
mkdir comp_hospital
mkdir comp_state
mkdir comp_nation
mkdir tec_hospital
mkdir tec_state
mkdir tec_nation
mkdir survey_results

mv readm_hospital.csv readm_hospital/
mv readm_state.csv readm_state/
mv readm_nation.csv readm_nation/
mv comp_hospital.csv comp_hospital/
mv comp_state.csv comp_state/
mv comp_nation.csv comp_nation/
mv tec_hospital.csv tec_hospital/
mv tec_state.csv tec_state/
mv tec_nation.csv tec_nation
mv survey_results.csv survey_results/

hdfs dfs -put hospital_compare /user/w205/
hdfs dfs -du /user/w205/hospital_compare