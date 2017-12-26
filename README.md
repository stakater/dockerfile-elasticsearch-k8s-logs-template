# Dockerfile for Elasticsearch Kubernetes Logs template
Dockerfile for submitting template to ES

## How to run 
```
docker run -it stakater/elasticsearch-k8s-logs-template
```

### Additional Options:

#### Environment variables:

`ELASTICSEARCH_URL`: URL of Elasticsearch (default: `http://localhost:9200`)

`RETRY_LIMIT`: Number of tries to connect to Elasticsearch before failing (default: `10`)

`TEMPLATE_NAME`: Name of the template being submitting to elasticsearch (default: `logs`)

`TEMPLATE_FILE_NAME`: Name of the file which contains the template (default: `logs-template.json`)


### Specifying custom template:

* Volume map the directory `/es-template/config` to a directory which contains json for your templates
* Set the name of the template and name of the file through `TEMPLATE_NAME` and `TEMPLATE_FILE_NAME` respectively. 