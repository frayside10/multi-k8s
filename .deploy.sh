docker build -t frayside10/multi-client:latest -t frayside10/multi-client:$SHA -f ./client/Dockerfile ./client 
docker build -t frayside10/multi-server:latest -t frayside10/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t frayside10/multi-worker:latest -f frayside10/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push frayside10/multi-client:latest
docker push frayside10/multi-server:latest
docker push frayside10/multi-worker:latest

docker push frayside10/multi-client:$SHA
docker push frayside10/multi-server:$SHA
docker push frayside10/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=frayside10/multi-server:$SHA
kubectl set image deployments/client-deployment client=frayside10/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=frayside10/multi-worker:$SHA

