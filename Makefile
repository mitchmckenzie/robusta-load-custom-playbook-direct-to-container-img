CLUSTER_NAME := robusta-issue
CTX := kind-$(CLUSTER_NAME)
IMAGE ?= foo.dev/repo-foo/robusta-issue:dev
ROBUSTA_NS ?= robusta

.PHONY: load-image install-robusta fresh clean cluster image uninstall-robusta

fresh: clean install-robusta

cluster:
	kind get clusters | grep -q $(CLUSTER_NAME) || kind create cluster --name=$(CLUSTER_NAME)

clean:
	kind delete cluster --name=$(CLUSTER_NAME)

install-robusta: cluster load-image
	helm repo add robusta https://robusta-charts.storage.googleapis.com && helm repo update
	helm upgrade --create-namespace --install --kube-context=$(CTX) -n $(ROBUSTA_NS) -f ./chart/values.yaml robusta ./chart
	until kubectl --context=$(CTX) -n $(ROBUSTA_NS) rollout status deployment robusta-runner; do sleep 1; done
	until kubectl --context=$(CTX) -n $(ROBUSTA_NS) rollout status deployment robusta-forwarder; do sleep 1; done

uninstall-robusta:
	helm uninstall -n $(ROBUSTA_NS) robusta

image:
	docker build -t $(IMAGE) .

load-image: image
	kind load docker-image $(IMAGE) --name $(CLUSTER_NAME)

