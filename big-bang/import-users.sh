#!/bin/bash

# set environmental variables
source .env

for file in *.json; do
  echo "Processing $file";
  RES=`curl -v \
      -s -w "%{http_code}" \
      -H "Authorization: $API_KEY" \
      -H "X-FusionAuth-TenantId: $TENANT_ID" \
      -H "Content-type: application/json" \
      -XPOST \
      $FA_HOST/api/user/import \
      -d@$file`
  if [ "$RES" -ne "200" ] && [ "$RES" -ne "100" ]; then
  echo "Error: $RES";
  exit 1;
  fi
done