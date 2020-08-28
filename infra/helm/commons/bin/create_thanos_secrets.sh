#!/bin/bash -e
BUCKET=$1
THANOS_CONFIG=thanos-objstore-config

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cat > $dir/thanos.yaml <<EOL
---
type: S3
config:
  bucket: $BUCKET
  endpoint: s3.eu-central-1.amazonaws.com
  access_key: $S3_KEY
  secret_key: $S3_SECRET
  signature_version2: false
  encrypt_sse: true
EOL

# Check how i can generate such config
create_thanos_storage_secret() {
  kubectl -n thanos delete secret $THANOS_CONFIG --ignore-not-found
  kubectl -n thanos create secret generic $THANOS_CONFIG --from-file=thanos.yaml=$dir/thanos.yaml
}
clean_up () {
  if [[ -f $dir/thanos.yaml ]]; then
    rm $dir/thanos.yaml
  else
    echo "File doesn't exist"
  fi
}
create_thanos_storage_secret
clean_up
