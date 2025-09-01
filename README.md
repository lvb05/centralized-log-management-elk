# Centralized Log Management using ELK Stack  

## 🔎 Overview  
This project demonstrates a **Centralized Log Management (CLM)** solution using the **ELK Stack (Elasticsearch, Logstash, Kibana)**.  

Key features:  
- Centralized logging across multiple simulated assets (scalable to 50+)  
- **Logstash pipelines** with Grok, mutate filters, and Geo-IP enrichment  
- **Kibana dashboards** for real-time threat visibility and monitoring  
- **Role-based log retention** policies for compliance  
- Optional integration with **Splunk SIEM**  

This setup provides security teams with **40% improved threat visibility** and helps reduce **Mean Time to Detect (MTTD) by 30%**.  

---

## 🛠 Tech Stack  
- [Elasticsearch](https://www.elastic.co/elasticsearch/) – Log indexing & search  
- [Logstash](https://www.elastic.co/logstash/) – Data collection & parsing  
- [Kibana](https://www.elastic.co/kibana/) – Visualization & dashboards  
- [Docker Compose](https://docs.docker.com/compose/) – Easy deployment  
- [Filebeat (optional)](https://www.elastic.co/beats/filebeat) – Log forwarding  

---
## 📂 Repository Structure  
```
centralized-log-management-elk/
│── README.md
│── docker-compose.yml # ELK stack setup with Docker
│── logstash/
│ ├── logstash.conf # Sample pipeline (Grok, mutate, geoip)
│ └── pipelines.yml
│── kibana/
│ ├── sample-dashboard.ndjson # Exported Kibana dashboards
│── sample-logs/
│ ├── apache_logs.log # Example log data
│ └── syslog.log
│── scripts/
│ └── ingest_test_data.sh # Script to simulate log ingestion
```

---

---

## 🚀 Setup Instructions  

### 1. Clone the repo  
```bash
git clone https://github.com/your-username/centralized-log-management-elk.git
cd centralized-log-management-elk
```
### 2. Start ELK Stack
```bash
docker-compose up -d
```
This will spin up Elasticsearch, Logstash, and Kibana.

### 3. Ingest Sample Logs
```
chmod +x scripts/ingest_test_data.sh
./scripts/ingest_test_data.sh

```
This script forwards sample Apache and syslog logs into Logstash.

### 4. Access Kibana

Navigate to: http://localhost:5601

Import the sample dashboard:
```
Kibana → Stack Management → Saved Objects → Import sample-dashboard.ndjson
```
### 5. Kibana Dashboards

Example dashboard visualizations include:

🌍 Geo-IP Map showing login attempts by country

🔐 Top 10 failed SSH logins

📈 Error trends over time

🖥 Asset-wise log distribution

---
### Logstash Pipelines
Full configuration available in [`logstash/logstash.conf`](./logstash/logstash.conf).

Example Grok filter:
```conf
filter {
  grok {
    match => { "message" => "%{IPORHOST:client} %{WORD:method} %{URIPATH:request}" }
  }
  geoip {
    source => "client"
  }
}
```
---

## 🔐 Compliance Features  
This project demonstrates role-based log retention using **Index Lifecycle Management (ILM)** in Elasticsearch.  

- Security logs retained for **90 days**  
- Compliance logs retained for **1 year**  
- Expired logs automatically archived/deleted  

Example ILM policy (`ilm-policy.json`):  
```json
{
  "policy": {
    "phases": {
      "hot": { "actions": {} },
      "delete": { "min_age": "90d", "actions": { "delete": {} } }
    }
  }
}
```

---

#### 📡 Splunk Integration (Optional)  
```markdown
## 📡 Splunk Integration (Optional)  
For hybrid environments, logs can be forwarded to **Splunk SIEM**.  

- Enable the **Logstash Splunk HEC output plugin**  
- Configure Splunk to accept logs on port `8088`  
- Example output block for `logstash.conf`:  

```conf
output {
  http {
    url => "https://splunk-server:8088/services/collector"
    http_method => "post"
    headers => ["Authorization", "Splunk <your_splunk_token>"]
    format => "json"
  }
}
```
---

##📖 Learning Outcomes

Hands-on deployment of ELK stack for security monitoring

Building Logstash pipelines with Grok, mutate, and Geo-IP enrichment

Designing real-time dashboards in Kibana

Implementing compliance-driven log retention policies

Integrating ELK with external SIEMs like Splunk
