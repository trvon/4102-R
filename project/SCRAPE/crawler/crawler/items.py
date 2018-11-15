# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# https://doc.scrapy.org/en/latest/topics/items.html
import datetime
import scrapy

class CrawlerItem(scrapy.Item):
    # define the fields for your item here like:
    product_name = scrapy.Field()
    product_sale_price = scrapy.Field()
    product_category = scrapy.Field()
    product_availability = scrapy.Field()
    product_date = scrapy.Field()
    pass
