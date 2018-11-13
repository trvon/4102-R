#!/usr/bin/python

import psycopg2

try:
    conn = psycopg2.connect(dbname='postgres', user='postgres',
                            password='r_password', host='0.0.0.0')
except:
    print ("Unable to connect")

conn.cursor()
