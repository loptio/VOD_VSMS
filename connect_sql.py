import mysql.connector

config = {
    'host': '140.127.74.226',
    'port': 3306,
    'database': '411277043',
    'user': '411277043',
    'password': '411277043',

}

try:
    conn = mysql.connector.connect(**config)
    print('connect success')
except mysql.connector.Error as e:
    print('connect fail')
    print(e)