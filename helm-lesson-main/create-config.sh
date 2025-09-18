# Создать ServiceAccount и получить токен
kubectl apply -f k8s/service-account.yaml
kubectl config set-context --current --namespace=default
kubectl create token gitlab-ci --duration=8760h
kubectl get secret $(kubectl get serviceaccount gitlab-ci -o jsonpath='{.secrets[0].name}') -o jsonpath='{.data.token}' | base64 -d

# Получить данные кластера
CLUSTER_NAME=$(kubectl config view --minify -o jsonpath='{.clusters[0].name}')
SERVER_URL=$(kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}')
CA_DATA=$(kubectl config view --minify --raw -o jsonpath='{.clusters[0].cluster.certificate-authority-data}')

# Получить токен ServiceAccount
TOKEN=$(kubectl create token gitlab-ci --duration=8760h)

# Создать kubeconfig
cat > gitlab-kubeconfig.yaml << EOF
apiVersion: v1
kind: Config
clusters:
- cluster:
    certificate-authority-data: ${CA_DATA}
    server: ${SERVER_URL}
  name: ${CLUSTER_NAME}
contexts:
- context:
    cluster: ${CLUSTER_NAME}
    user: gitlab-ci
  name: gitlab-ci-context
current-context: gitlab-ci-context
users:
- name: gitlab-ci
  user:
    token: ${TOKEN}
EOF

cat gitlab-kubeconfig.yaml | base64 > config.txt