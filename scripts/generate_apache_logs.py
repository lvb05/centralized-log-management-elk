import random
import time
import datetime

ips = ["192.0.2.1", "203.0.113.5", "198.51.100.7", "192.0.2.44", "203.0.113.9"]
methods = ["GET", "POST", "DELETE", "PUT"]
endpoints = ["/", "/index.html", "/login", "/admin", "/products/item?id=42", "/api/v1/data"]
status_codes = [200, 200, 200, 401, 403, 404, 500]

with open("../sample-logs/apache_logs.log", "a") as f:
    while True:
        ip = random.choice(ips)
        method = random.choice(methods)
        endpoint = random.choice(endpoints)
        status = random.choice(status_codes)
        size = random.randint(100, 2000)

        log = f'{ip} - - [{datetime.datetime.utcnow().strftime("%d/%b/%Y:%H:%M:%S +0000")}] "{method} {endpoint} HTTP/1.1" {status} {size} "-" "Mozilla/5.0"\n'
        f.write(log)
        f.flush()
        print(log.strip())
        time.sleep(random.uniform(0.5, 2))  # adjustable speed
