docker build -t alexiscl/multi-client:latest -t alexiscl/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alexiscl/multi-worker:latest -t alexiscl/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker build -t alexiscl/multi-server:latest -t alexiscl/multi-server:$SHA -f ./server/Dockerfile ./server

docker push alexiscl/multi-client:latest
docker push alexiscl/multi-worker:latest
docker push alexiscl/multi-server:latest

docker push alexiscl/multi-client:$SHA
docker push alexiscl/multi-worker:$SHA
docker push alexiscl/multi-server:$SHA

kubectl apply -f k8s-ok

kubectl set image deployments/client-deployment client=alexiscl/multi-client:$SHA
kubectl set image deployments/server-deployment server=alexiscl/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=alexiscl/multi-worker:$SHA