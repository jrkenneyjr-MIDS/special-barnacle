READ-ME.txt:
Exercise 2 Operator's Manual:

1.	Assumptions:
	a.	Postgres is started on instance running
	b.	Database tcount has not been created
		i.	If it has, please use alternate script
2.	Instructions
	a.	Clone Repository with:
		i.	Git init
		ii.	Git clone 
	b.	Change into directory
		i.	Cd w205-Assignments/tweetwordcount
	c.	Run scripts
		i.	If tcount DB has not been created
			1.	Chmod +x ./run.sh
			2.	./run.sh
		ii.	If tcount DB has been created
			1.	Chmod +x ./run-alternate.sh
			2.	./run-alternate.sh
	d.	Tweet stream will automatically commence
		i.	Since you will be running as the root, you may have to press “Enter” to override the LEIN warning
		ii.	Press Ctrl+z to exit from stream when satisfied

