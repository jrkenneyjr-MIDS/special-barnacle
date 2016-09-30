unzip Hospital_Revised_Flatfiles.zip -d Hospital
cd Hospital
mkdir Finished
for f in *.csv; do tail -n +2 "$f" > Finished/"$f"; done

mv Finished ~/w205-fall-16-labs-exercises/special-barnacle
cd ~/w205-fall-16-labs-exercises/special-barnacle
rm -R Hospital
mv Finished Hospital