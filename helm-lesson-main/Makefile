docker-build:
	docker login -u ${DOCKER_HUB_USER} -p ${DOCKER_HUB_TOKEN}
	docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
	docker push ${IMAGE_NAME}:${IMAGE_TAG}

docker-run:
	docker stop fastapi-app || true
	docker run -d --rm --name fastapi-app -p 8000:8000 zikarimovlt/fastapi-app:latest

helm-install-ingress:
	helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
	helm repo update
	helm install ingress-nginx ingress-nginx/ingress-nginx \
		--namespace ingress-nginx \
		--create-namespace \
		--set controller.replicaCount=1 \
		--set controller.nodeSelector."kubernetes\.io/os"=linux \
		--set controller.admissionWebhooks.enabled=false \
		--set controller.service.type=LoadBalancer

helm-uninstall-ingress:
	helm uninstall ingress-nginx -n ingress-nginx

helm-lint:
	helm lint helm/fastapi-app
	helm template fastapi-app helm/fastapi-app
	helm install fastapi-app helm/fastapi-app --dry-run --debug

helm-deploy:
	helm upgrade --install fastapi-app helm/fastapi-app \
		--namespace otus \
		--create-namespace \
		--set image.repository=${IMAGE_NAME} \
		--set image.tag=${IMAGE_TAG} \
		--wait \
		--timeout 5m

helm-delete:
	helm uninstall fastapi-app -n otus

connect-cluster:
	yc managed-kubernetes cluster get-credentials --id ${CLUSTER_ID} --external --force

create-kubeconfig:
	bash create-config.sh
