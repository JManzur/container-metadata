#!/bin/sh
set -e

# Get container metadata
metadata=$(curl -s $ECS_CONTAINER_METADATA_URI)

# Update HTML file with metadata
echo $metadata | jq '.' > metadata.json
sed "s/{placeholder}/$(cat metadata.json | tr -d '\n')/" /usr/local/apache2/htdocs/index.html > /usr/local/apache2/htdocs/temp.html
mv /usr/local/apache2/htdocs/temp.html /usr/local/apache2/htdocs/index.html
rm metadata.json

# Run httpd
httpd-foreground