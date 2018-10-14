bazel-generate:
	SYNC_VENDOR=true hack/dockerized "bazel run :gazelle"

bazel-generate-manifests-dev:
	SYNC_MANIFESTS=true hack/dockerized "bazel build //manifests:generate_manifests --define dev=true"

bazel-generate-manifests-release:
	SYNC_MANIFESTS=true hack/dockerized "bazel build //manifests:generate_manifests --define release=true"

bazel-push-images-k8s-1.10.4:
	hack/dockerized "bazel run //:push_images --define dev=true --define cluster_provider=k8s_1_10_4"

bazel-push-images-os-3.10.0:
	hack/dockerized "bazel run //:push_images --define dev=true --define cluster_provider=os_3_10_0"

cluster-build:
	./cluster/build.sh

cluster-clean:
	./cluster/clean.sh

cluster-deploy: cluster-clean
	./cluster/deploy.sh

cluster-down:
	./cluster/down.sh

cluster-sync: cluster-build cluster-deploy

cluster-up:
	./cluster/up.sh

deps-install:
	SYNC_VENDOR=true hack/dockerized "dep ensure"

deps-update:
	SYNC_VENDOR=true hack/dockerized "dep ensure -update"

distclean: clean
	hack/dockerized "rm -rf vendor/ && rm -f Gopkg.lock"
	rm -rf vendor/

generate:
	hack/dockerized "hack/update-codegen.sh"

.PHONY: bazel-generate bazel-generate-manifests-dev bazel-generate-manifests-release bazel-push-images-k8s-1.10.4 bazel-push-images-os-3.10.0 cluster-build cluster-clean cluster-deploy cluster-down cluster-sync cluster-up deps-install deps-update distclean generate
