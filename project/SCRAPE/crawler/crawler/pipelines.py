# -*- coding: utf-8 -*-
import psycopg2

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://doc.scrapy.org/en/latest/topics/item-pipeline.html

class CrawlerPipeline(object):
    def open_spider(self, spider):
        hostname = 'localhost'
        username = 'postgres'
        password = 'r_password'
        database = 'postgres'
        self.connection = psycopg2.connect(host=hostname,
                                           user=username,
                                           password=password,
                                           dbname=database)
        self.cur = self.connection.cursor()
        try:
            self.cur.execute("CREATE TABLE items (id varchar PRIMARY KEY, sale_price varchar, category varchar);")
        except:
            print("TABLE already created")

    def close_spider(self, spider):
        self.connection.close()
        self.cur.close()
    
    def process_item(self, item, spider):
        self.cur.execute("insert into items(id, sale_price, category) values(%s, %s, %s)", (item['product_name'], item['product_sale_price'].replace('$',''), item['product_category']))

        self.connection.commit()
        return item
