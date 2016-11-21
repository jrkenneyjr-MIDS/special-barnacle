#Connecting to a database
import psycopg2, sys
conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")

cur = conn.cursor()

#Select
if len(sys.argv) == 1:
 	cur.execute("SELECT * FROM Tweetwordcount WHERE word !~ '^[1-9]' ORDER BY word ASC LIMIT 50;")
	records = cur.fetchall()
	for rec in records:
   		print ("word = " + str(rec[0]) + '\t' + "count = " + str(rec[1]))
else:
	try:
		cur.execute("SELECT word, count from Tweetwordcount where word = %s;",(sys.argv[1],))
  		rec = cur.fetchone()
		print("Total occurrences of \"" + str(rec[0]) + "\": " + str(rec[1]))
	except TypeError:
		print("No instances found.")
	
conn.commit()

conn.close()
