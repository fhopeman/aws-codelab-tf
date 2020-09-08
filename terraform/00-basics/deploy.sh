


ENVIRONMENT="$1"

terraform init

terrafom apply -var-file ../common.tfvar.json -var "environment=${ENVIRONMENT}"