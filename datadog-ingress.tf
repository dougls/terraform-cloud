resource "kubectl_manifest" "ingress" {
    yaml_body = <<YAML
      apiVersion: networking.k8s.io/v1
      kind: Ingress
      metadata:
        name: test-ingress
        annotations:
          nginx.ingress.kubernetes.io/rewrite-target: /
      spec:
        rules:
        - http:
            paths:
            - path: /testpath
              pathType: "Prefix"
              backend:
                serviceName: test
                servicePort: 80
    YAML
}