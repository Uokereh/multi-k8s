docker build -t uokereh/multi-client:latest -t uokereh/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t uokereh/multi-server:latest -t uokereh/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t uokereh/multi-worker:latest -t uokereh/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push uokereh/multi-client:latest
docker push uokereh/multi-server:latest
docker push uokereh/multi-worker:latest

docker push uokereh/multi-client:$SHA
docker push uokereh/multi-server:$SHA
docker push uokereh/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=uokereh/multi-server:$SHA
kubectl set image deployments/client-deployment client=uokereh/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=uokereh/multi-worker:$SHA