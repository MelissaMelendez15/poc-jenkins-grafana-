#!/usr/bin/env bash
set -euo pipefail

# Uso:
#   ./scripts/push_metrics.sh <INPUT_VAL> [PUSHGATEWAY_URL]
#
# Ej:
#   ./scripts/push_metrics.sh 50
#   ./scripts/push_metrics.sh 90 http://obs-pushgateway:9091

INPUT_VAL="${1:-}"
PUSHGATEWAY_URL="${2:-http://obs-pushgateway:9091}"

if [[ -z "${INPUT_VAL}" ]]; then
  echo "ERROR: Falta INPUT_VAL. Uso: $0 <INPUT_VAL> [PUSHGATEWAY_URL]" >&2
  exit 1
fi

# Regla simple para demo: OK=1 si INPUT <= 80, si no OK=0
OK=1
if [[ "${INPUT_VAL}" -gt 80 ]]; then OK=0; fi

# MVP: avg y max = input
AVG="${INPUT_VAL}"
MAX="${INPUT_VAL}"

cat <<EOF | curl --silent --show-error --fail --data-binary @- "${PUSHGATEWAY_URL}/metrics/job/jenkins_poc"
poc_input_value ${INPUT_VAL}
poc_input_avg ${AVG}
poc_input_max ${MAX}
poc_input_ok ${OK}
EOF

echo "Pushed metrics -> INPUT=${INPUT_VAL}, AVG=${AVG}, MAX=${MAX}, OK=${OK}"