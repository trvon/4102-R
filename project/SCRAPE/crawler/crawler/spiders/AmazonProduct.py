# -*- coding: utf-8 -*-
import scrapy
import datetime
from crawler.items import CrawlerItem

class AmazonproductSpider(scrapy.Spider):
    name = 'AmazonProduct'
    allowed_domains = ['amazon.com']
    start_urls = ["https://www.amazon.com/MSI-RTX-2080-GAMING-TRIO/dp/B07GHXQTGZ",
                  "https://www.amazon.com/PlayStation-4-Slim-1TB-Console/dp/B071CV8CG2?th=1",
                  "https://www.amazon.com/PlayStation-4-Slim-1TB-Console/dp/B071CV8CG2?th=1",
                  "https://www.amazon.com/AMD-Threadripper-32-thread-Processor-YD195XA8AEWOF/dp/B074CBH3R4",
                  "https://www.amazon.com/Redragon-KUMARA-Backlit-Mechanical-Keyboard/dp/B016MAK38U",
                  "http://www.amazon.com/Apple-MacBook-Version-1-8GHz-128GB/dp/B07738WFFN",
                  "https://www.amazon.com/Black-Passport-Portable-External-Drive/dp/B01LQQHF2W",
                  "https://www.amazon.com/Roku-Streaming-Stick-Player-Wireless/dp/B075XLWML4",
                  "https://www.amazon.com/Emarth-Telescope-Astronomical-Refracter-Beginners/dp/B071XX1WX9/",
                  "https://www.amazon.com/EILIKS-Survival-Emergency-Earthquake-Adventures/dp/B07HH1BP4C",
                  "https://www.amazon.com/DBPOWER-U842-WIFI-Quadcopter-Beginners/dp/B01D9XWFGG",
                  "https://www.amazon.com/Wsky-Portable-Theater-Projector-Compatible/dp/B07F1PV5QF",
                  "https://www.amazon.com/TaoTronics-Cancelling-Bluetooth-Headphones-Noise-Cancelling/dp/B075CBHN9M",
                  "https://www.amazon.com/dp/B019U00D7K",
                  "https://www.amazon.com/All-New-Amazon-Fire-7-Tablet/dp/B01GEW27DA",
                  "https://www.amazon.com/All-new-Kindle-Paperwhite-Waterproof-Storage/dp/B07CXG6C9W",
                  "https://www.amazon.com/Amazon-Echo-Dot-Portable-Bluetooth-Speaker-with-Alexa-Black/dp/B01DFKC2SO",
                  "https://www.amazon.com/All-new-Echo-Dot-3rd-Gen/dp/B0792KTHKJ",
                  "https://www.amazon.com/all-new-amazon-echo-speaker-with-wifi-alexa-dark-charcoal/dp/B06XCM9LJ4",
                  "https://www.amazon.com/Stick-Alexa-Voice-Remote-White/dp/B075911H6L",
                  "https://www.amazon.com/Wyze-Indoor-Wireless-Camera-Vision/dp/B076H3SRXG",
                  "https://www.amazon.com/Logitech-MK270-Wireless-Keyboard-Mouse/dp/B079JLY5M",
                  "https://www.amazon.com/TCL-55S405-55-Inch-Ultra-Smart/dp/B01MTGM5I",
                  "https://www.amazon.com/All-New-Tablet-Hands-Free-Alexa-Display/dp/B0794RHPZD",
                  "https://www.amazon.com/Roku-Streaming-Stick-Player-Wireless/dp/B075XLWML4",
                  "https://www.amazon.com/Amazon-Echo-Dot-Portable-Bluetooth-Speaker-with-Alexa-White/dp/B015TJD0Y4",
                  "https://www.amazon.com/RCA-Digital-Alarm-Clock-Display/dp/B007T0W5CA",
                  "https://www.amazon.com/Echo-2nd-Gen-Dot-3rd/dp/B07JQD8WHD",
                  "https://www.amazon.com/HP-23-8-inch-Adjustment-Speakers-VH240a/dp/B072M34RQC",
                  "https://www.amazon.com/Google-WiFi-system-3-Pack-replacement/dp/B01MAW2294",
                  "https://www.amazon.com/UBeesize-Portable-Adjustable-Universal-Compatible/dp/B06Y2VP3C7",
                  "https://www.amazon.com/All-new-Echo-Show-2nd-Gen/dp/B077SXWSRP",
                  "https://www.amazon.com/Toshiba-32LF221U19-32-inch-720p-Smart/dp/B07FPR6FMJ",
                  "https://www.amazon.com/Ring-8AB1S7-0EU0-Rechargeable-Battery-Pack/dp/B076JKHDQT",
                  "https://www.amazon.com/Certified-Refurbished-Tablet-Hands-Free-Display/dp/B01M5D2HKW",
                  "https://www.amazon.com/Wyze-1080p-Indoor-Camera-Vision/dp/B07DGR98VQ",
                  "https://www.amazon.com/Anker-4-Port-Macbook-Surface-Notebook/dp/B00XMD7KPU",
                  "https://www.amazon.com/TOGUARD-Backup-Rearview-Waterproof-Reversing/dp/B07DGS11CM",
                  "https://www.amazon.com/AUKEY-Dashboard-Supercapacitor-Nighttime-Recording/dp/B072FGL63X",
                  "https://www.amazon.com/NETGEAR-R6700-Nighthawk-Gigabit-Ethernet/dp/B00R2AZLD2",
                  "https://www.amazon.com/Acer-SB220Q-Ultra-Thin-Frame-Monitor/dp/B07CVL2D2S",
                  "https://www.amazon.com/GE-Protector-Outlets-Extension-14092/dp/B00DOMYL24",
                  "https://www.amazon.com/Apple-TV-32GB-4th-Generation/dp/B075NFX24M",
                  "https://www.amazon.com/Acer-Predator-Overclockable-Aeroblade-PH315-51-78NP/dp/B07CTHLX8C",
                  "https://www.amazon.com/8th-Gen-i5-8300H-GeForce-FireCuda-Windows/dp/B07BP9QG2J",
                  "https://www.amazon.com/VivoBook-i7-8550U-Processor-GeForce-Backlit/dp/B07661CYPD",
                  "https://www.amazon.com/MSI-GS65-Stealth-THIN-051-i7-8750H/dp/B07BB7XN8C",
                  "https://www.amazon.com/Acer-i5-7300HQ-2-50GHz-Backlit-Keyboard/dp/B07CWBM1B9"
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
        items['product_date'] = datetime.datetime.now().strftime('%d-%m-%Y')
        yield items
