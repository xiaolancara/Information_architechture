#https://downloads.mysql.com/docs/connector-python-en.a4.pdf


import mysql.connector

# connect to server
connection = mysql.connector.connect(user='root', password='eE123654',host='127.0.0.1', port ='3306')


print('Connected to database.')
cursor = connection.cursor()

##Test query to see if you can connect
query = "select * from dav6100_db_2_dw.dim_date;"
cursor.execute(query)
result = cursor.fetchall()
print(result)

#Call Dimension Tables Stored Procedure
cursor.callproc('dav6100_db_2_dw.updateDimensionsProc')
print('Dimension tables updated.')

#Call Fact Tables Stored Procedure
cursor.callproc('dav6100_db_2_dw.updateFacts')
print('Fact tables updated.')

connection.commit()
connection.close()
print('Disconnected from database.')

