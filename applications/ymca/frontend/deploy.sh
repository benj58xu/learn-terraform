#!/bin/bash

set -euo pipefail

frontend_dir="${FRONTEND_SOURCE_DIR:-$HOME/Coding/ymca/frontend}"
stack_dir="$(cd "$(dirname "$0")" && pwd)"

if [ -f "$stack_dir/github.env" ]; then
  set -a
  source "$stack_dir/github.env"
  set +a
fi

if [ ! -d "$frontend_dir" ]; then
  echo "Frontend source directory does not exist: $frontend_dir" >&2
  exit 1
fi

if [ -z "${FRONTEND_BUCKET_NAME:-}" ]; then
  echo "Set FRONTEND_BUCKET_NAME to the Terraform bucket_name output." >&2
  exit 1
fi

if [ -z "${REACT_APP_API_URL:-}" ]; then
  echo "Set REACT_APP_API_URL to the Lambda API Gateway URL." >&2
  exit 1
fi

cd "$frontend_dir"
npm ci
REACT_APP_API_URL="$REACT_APP_API_URL" npm run build
aws s3 sync build/ "s3://$FRONTEND_BUCKET_NAME" --delete

echo "Frontend uploaded from $frontend_dir"
echo "This is a static S3 site. Upload to the bucket and use the website URL or Route53 alias."
echo "Stack directory: $stack_dir"