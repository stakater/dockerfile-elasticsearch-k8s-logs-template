#!/bin/bash
set -exo pipefail

retries=${RETRY_LIMIT:-10};
ES_URL=${ELASTICSEARCH_URL:-"http://localhost:9200"}
TEMPLATE_FILE_NAME=${TEMPLATE_FILE_NAME:-"logs-template.json"}
TEMPLATE_NAME=${TEMPLATE_NAME:-"logs"}

# Wait for ES to start up properly
until $(curl -s -f -o /dev/null --connect-timeout 1 -m 1 --head ${ES_URL}) ; do
    sleep 0.5;
    retries=$(($retries-1))
    
    if [[ ${retries} -eq 0 ]]; 
    then 
        echo "Cannot connect to Elasticsearch at ${ES_URL}: Retry limit reached";
        exit 1;
    fi
done

# If the logs template doesn't already exist...
if ! [ $(curl -s -f -o /dev/null ${ES_URL}/_template/${TEMPLATE_NAME}) ]; then
    curl -XPUT -d@/es-template/config/${TEMPLATE_FILE_NAME} -H 'Content-Type: application/json' ${ES_URL}/_template/${TEMPLATE_NAME}?pretty
fi

# Sleep 1m so that kubernetes can mark this as healthy
sleep 1m;