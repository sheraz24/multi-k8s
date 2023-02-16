docker build -t sheraz24/multi-client:latest -t sheraz24/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sheraz24/multi-server:latest -t sheraz24/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sheraz24/multi-worker:latest -t sheraz24/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sheraz24/multi-client:latest
docker push sheraz24/multi-server:latest
docker push sheraz24/multi-worker:latest

docker push sheraz24/multi-client:$SHA
docker push sheraz24/multi-server:$SHA
docker push sheraz24/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sheraz24/multi-server:$SHA
kubectl set image deployments/client-deployment client=sheraz24/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sheraz24/multi-worker:$SHA