# -*- coding: utf-8 -*-
import scrapy
from crawler.items import CrawlerItem

class AmazonproductSpider(scrapy.Spider):
    name = 'AmazonProduct'
    allowed_domains = ['amazon.com']
    start_urls = ["https://www.amazon.com/MSI-RTX-2080-GAMING-TRIO/dp/B07GHXQTGZ",
                  "https://www.amazon.com/Nintendo-Switch-Neon-Red-Blue-Joy/dp/B01MUAGZ49",
                  "https://www.amazon.com/PlayStation-4-Slim-1TB-Console/dp/B071CV8CG2?th=1",
                  "https://www.amazon.com/AMD-Threadripper-32-thread-Processor-YD195XA8AEWOF/dp/B074CBH3R4",
                  "https://www.amazon.com/Redragon-KUMARA-Backlit-Mechanical-Keyboard/dp/B016MAK38U",
                  "http://www.amazon.com/Apple-MacBook-Version-1-8GHz-128GB/dp/B07738WFFN",
                  "https://www.amazon.com/Black-Passport-Portable-External-Drive/dp/B01LQQHF2W",
                  "https://www.amazon.com/Samsung-Inch-Internal-MZ-76E1T0B-AM/dp/B078DPCY3T",
                  "https://www.amazon.com/Samsung-960-EVO-Internal-MZ-V6E1T0BW",
                  "https://www.amazon.com/Roku-Streaming-Stick-Player-Wireless/dp/B075XLWML4"
    ]

    def parse(self, response):
        items = CrawlerItem()
        title = response.xpath('//h1[@id="title"]/span/text()').extract()
        sale_price = response.xpath('//span[contains(@id,"ourprice") or contains(@id, "saleprice")]/text()').extract()
        category = response.xpath('//a[@class="a-link-normal a-color-tertiary"]/text()').extract()
        availability = response.xpath('//div[@id="availability"]//text()').extract()
        items['product_name'] = ''.join(title).strip()
        items['product_sale_price'] = ''.join(sale_price).strip()
        items['product_category'] = ''.join(map(lambda x: x.strip(), category)).strip()
        items['product_availability'] = ''.join(availability).strip()
        yield items
