#!/bin/bash -e

set -a && source .source.prod && \
  helmfile --environment production -f helm/helmfiles/namespaces.yaml apply && \
  helmfile --environment production -f helm/helmfiles/dynatrace.yaml apply
