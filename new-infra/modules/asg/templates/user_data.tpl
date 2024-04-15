#! /bin/bash

set -euxo pipefail

cat << EOF >> /etc/ecs/ecs.config
ECS_CLUSTER=${cluster_name}
EOF