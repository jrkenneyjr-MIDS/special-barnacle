#Connecting to a database
import psycopg2, sys
conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")

cur = conn.cursor()

if len(sys.argv) == 1:
 	cur.execute("SELECT * FROM Tweetwordcount WHERE word !~ '^[0-9]' ORDER BY count DESC LIMIT 50;")
	records = cur.fetchall()
	for rec in records:
   		print ("word = " + str(rec[0]) + '\t' + "count = " + str(rec[1]))

else:
	try:
		args = sys.argv[1].split(",")
		lbound = int(args[0])
		ubound = int(args[1])
		if lbound > ubound:
			ubound = int(args[0])
			lbound = int(args[1])
		cur.execute("SELECT * FROM Tweetwordcount WHERE word !~ '^[0-9]' AND count <= %s AND count >= %s ORDER BY count DESC, word ASC LIMIT 50;",(ubound,lbound))
		conn.commit
		records = cur.fetchall()
		for rec in records:
			print ("word = " + str(rec[0]) + '\t' + "count = " + str(rec[1]))	
	except TypeError:
		print("No instances found.")		

conn.close()


