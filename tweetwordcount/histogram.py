#Connecting to a database
import psycopg2, sys
conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")

cur = conn.cursor()

args = sys.argv[1]
lbound = int(args[0])
ubound = int(args[2])

if lbound > ubound:
	ubound = int(args[0])
	lbound = int(args[2])

print(lbound*2)

cur.execute("SELECT * FROM Tweetwordcount WHERE word !~ '^[1-9]' AND count < %s AND count > %s ORDER BY count DESC, word ASC LIMIT 50;",(ubound,lbound))
conn.commit
records = cur.fetchall()
for rec in records:
	print ("word = " + str(rec[0]) + '\t' + "count = " + str(rec[1]))

conn.close()



