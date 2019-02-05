docker build -t tokini/multi-client:latest -t tokini/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tokini/multi-server:latest -t tokini/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tokini/multi-worker:latest -t tokini/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push tokini/multi-client:latest
docker push tokini/multi-server:latest
docker push tokini/multi-worker:latest
docker push tokini/multi-client:$SHA
docker push tokini/multi-server:$SHA
docker push tokini/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tokini/multi-server:$SHA
kubectl set image deployments/client-deployment client=tokini/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tokini/multi-worker:$SHA
