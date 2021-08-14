docker build -t jean84matias/multi-client:latest -t jean84matias/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jean84matias/multi-server:latest -t jean84matias/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jean84matias/multi-worker:latest -t jean84matias/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jean84matias/multi-client:latest
docker push jean84matias/multi-server:latest
docker push jean84matias/multi-worker:latest

docker push jean84matias/multi-client:$SHA
docker push jean84matias/multi-server:$SHA
docker push jean84matias/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=jean84matias/multi-client:$SHA
kubectl set image deployments/server-deployment server=jean84matias/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=jean84matias/multi-worker:$SHA