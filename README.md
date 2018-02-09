# kubewatch

[![Version Widget]][Version] [![License Widget]][License] [![GoReportCard Widget]][GoReportCard] [![Travis Widget]][Travis] [![DockerHub Widget]][DockerHub]

[Version]: https://github.com/gmichels/kubewatch/releases
[Version Widget]: https://img.shields.io/github/release/gmichels/kubewatch.svg?maxAge=60
[License]: http://www.apache.org/licenses/LICENSE-2.0.txt
[License Widget]: https://img.shields.io/badge/license-APACHE2-1eb0fc.svg
[GoReportCard]: https://goreportcard.com/report/gmichels/kubewatch
[GoReportCard Widget]: https://goreportcard.com/badge/gmichels/kubewatch
[Travis]: https://travis-ci.org/gmichels/kubewatch
[Travis Widget]: https://travis-ci.org/gmichels/kubewatch.svg?branch=master
[DockerHub]: https://hub.docker.com/r/gmichels/kubewatch
[DockerHub Widget]: https://img.shields.io/docker/pulls/gmichels/kubewatch.svg

# Overview

Kubernetes API event watcher with output to Splunk HEC.

This is a fork of [softonic/kubewatch](https://github.com/softonic/kubewatch "softonic/kubewatch") adding support to output the data to Splunk via HTTP Event Collector (HEC).

##### Install

```
go get -u github.com/gmichels/kubewatch
```

##### Shell completion

```
eval "$(kubewatch --completion-script-${0#-})"
```

##### Splunk Configuration
Proper functionality depends on the existence of the following environment variables:

- `SPLUNK_HEC_HOST`: the FQDN of the Splunk HTTP Event Collector
- `SPLUNK_HEC_PORT`: the port of the Splunk HTTP Event Collector
- `SPLUNK_HEC_TOKEN`: the token for the Splunk HTTP Event Collector
- `SPLUNK_HEC_PORT`: the port of the Splunk HTTP Event Collector

The below environment variables are optional:

- `SPLUNK_HOST`: the `host` field for the events
- `SPLUNK_SOURCE`: the `source` field for the events
- `SPLUNK_SOURCETYPE`: the `sourcetype` field for the events
- `SPLUNK_INDEX`: the `index` field for the events

##### Help

```
kubewatch --help
usage: kubewatch [<flags>] <resources>...

Watches Kubernetes resources via its API.

Flags:
  -h, --help          Show context-sensitive help (also try --help-long and --help-man).
      --kubeconfig    Absolute path to the kubeconfig file.
      --namespace     Set the namespace to be watched.
      --flatten       Whether to produce flatten JSON output or not.
      --version       Show application version.

Args:
  <resources>  Space delimited list of resources to be watched.
```

##### Out-of-cluster examples:

Make sure the required environment variables are set.

Watch for `pods` and `events` in all `namespaces`:
```
kubewatch pods events | jq '.'
```

Same thing with docker:
```
docker run -it --rm \
-v ~/.kube/config:/root/.kube/config \
gmichels/kubewatch pods events | jq '.'
```

Watch for `services` events in namespace `foo`:
```
kubewatch --namespace foo services | jq '.'
```

Same thing with docker:
```
docker run -it --rm \
-v ~/.kube/config:/root/.kube/config \
gmichels/kubewatch --namespace foo services | jq '.'
```

##### In-cluster examples:

See the examples in [k8s-manifests](k8s-manifests "k8s-manifests") folder for a Kubernetes deployment.
