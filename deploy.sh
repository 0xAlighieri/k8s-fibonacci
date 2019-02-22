docker build -t tfrench93/multi-client:latest -t tfrench93/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tfrench93/multi-server:latest -t tfrench93/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tfrench93/multi-worker:latest -t tfrench93/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tfrench93/multi-client:latest
docker push tfrench93/multi-client:$SHA
docker push tfrench93/multi-server:latest
docker push tfrench93/multi-server:$SHA
docker push tfrench93/multi-worker:latest
docker push tfrench93/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tfrench93/multi-server:$SHA
kubectl set image deployments/client-deployment client=tfrench93/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tfrench93/multi-worker:$SHA
