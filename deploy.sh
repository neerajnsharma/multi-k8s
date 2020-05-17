docker build -t neerajnsharma/multi-client:latest -t neerajnsharma/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t neerajnsharma/multi-server:latest -t neerajnsharma/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t neerajnsharma/multi-worker:latest -t neerajnsharma/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push neerajnsharma/multi-client:latest
docker push neerajnsharma/multi-server:latest
docker push neerajnsharma/multi-worker:latest
docker push neerajnsharma/multi-client:$SHA
docker push neerajnsharma/multi-server:$SHA
docker push neerajnsharma/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=neerajnsharma/multi-client:$SHA
kubectl set image deployments/server-deployment server=neerajnsharma/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=neerajnsharma/multi-worker:$SHA
