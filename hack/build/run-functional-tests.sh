#!/usr/bin/env bash

#Copyright 2018 The CDI Authors.
#
#Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
#Unless required by applicable law or agreed to in writing, software
#distributed under the License is distributed on an "AS IS" BASIS,
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#See the License for the specific language governing permissions and
#limitations under the License.

set -euo pipefail

script_dir="$(readlink -f $(dirname $0))"
source hack/build/config.sh
source hack/build/common.sh

# functional testing
KUBECTL=${KUBECTL:-${CDI_DIR}/cluster/.kubectl}
KUBECONFIG=${KUBECONFIG:-${CDI_DIR}/cluster/.kubeconfig}
KUBE_MASTER_URL=${KUBE_MASTER_URL:-""}
CDI_NAMESPACE=${CDI_NAMESPACE:-kube-system}

# parsetTestOpts sets 'pkgs' and test_args
parseTestOpts "${@}"

arg_master="${KUBE_MASTER_URL:+-master=$KUBE_MASTER_URL}"
arg_namespace="${CDI_NAMESPACE:+-cdi-namespace=$CDI_NAMESPACE}"
arg_kubeconfig="${KUBECONFIG:+-kubeconfig=$KUBECONFIG}"
arg_kubectl="${KUBECTL:+-kubectl-path=$KUBECTL}"
arg_oc="${KUBECTL:+-oc-path=$KUBECTL}"

test_args="${test_args} -ginkgo.v ${arg_master} ${arg_namespace} ${arg_kubeconfig} ${arg_kubectl} ${arg_oc}"

${script_dir}/run-tests.sh ${pkgs} --test-args="${test_args}"
