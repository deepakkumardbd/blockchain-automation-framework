apiVersion: flux.weave.works/v1beta1
kind: HelmRelease
metadata:
  name: {{ component_name }}
  namespace: {{ component_ns }}
  annotations:
    flux.weave.works/automated: "false"
spec:
  releaseName: {{ component_name }}
  chart:
    git: {{ git_url }}
    ref: {{ git_branch }}
    path: {{ charts_dir }}/h2
  values:
    nodeName: {{ node_name }}
    metadata:
      namespace: {{ component_ns }}
    replicaCount: 1
    image:
      conatinerName: {{ container_name }}
      imagePullSecret: {{ image_pull_secret }}
    resources:
      limits: 512Mi
      requests: 512Mi
    storage:
      name: {{ storageclass }}
      memory: 512Mi
    service:
      type: NodePort
      tcp:
        port: {{ ports_tcp.port }}
        targetPort: {{ ports_tcp.targetPort }}
      web:
        targetPort: {{ ports_web.targetPort }}
        port: {{ ports_web.port }}
      annotations: {}
    deployment:
      annotations: {}
    pvc:
      annotations: {}
