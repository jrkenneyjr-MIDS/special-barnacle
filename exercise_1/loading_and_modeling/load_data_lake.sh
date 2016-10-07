unzip hospital_compare_Revised_Flatfiles.zip -d hospital_compare
cd hospital_compare
mkdir Finished
for f in *.csv; do tail -n +2 "$f" > Finished/"$f"; done

mv Finished ~/w205-fall-16-labs-exercises/special-barnacle
cd ~/w205-fall-16-labs-exercises/special-barnacle
rm -R hospital_compare
mv Finished hospital_compare

hdfs dfs -put hospital_compare /user/w205/
hdfs dfs -du /user/w205/hospital_compare