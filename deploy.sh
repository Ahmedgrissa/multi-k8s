docker build -t ahmedgrissa/multi-client:latest -t ahmedgrissa/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ahmedgrissa/multi-server:latest -t ahmedgrissa/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ahmedgrissa/multi-worker:latest -t ahmedgrissa/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ahmedgrissa/multi-client:latest
docker push ahmedgrissa/multi-server:latest
docker push ahmedgrissa/multi-worker:latest
docker push ahmedgrissa/multi-client:$SHA
docker push ahmedgrissa/multi-server:$SHA
docker push ahmedgrissa/multi-worker:$SHA

kubectl apply -f k8s/
kubectl set image deployments/server-deployment server=ahmedgrissa/multi-server:$SHA
kubectl set image deployments/client-deployment client=ahmedgrissa/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ahmedgrissa/multi-worker:$SHA