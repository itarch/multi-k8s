docker build -t itarch/multi-client:latest -t itarch/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t itarch/multi-server:latest -t itarch/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t itarch/multi-worker:latest -t itarch/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push itarch/multi-client:latest
docker push itarch/multi-server:latest
docker push itarch/multi-worker:latest
docker push itarch/multi-client:$SHA
docker push itarch/multi-server:$SHA
docker push itarch/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=itarch/multi-server:$SHA
kubectl set image deployments/client-deployment client=itarch/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=itarch/multi-worker:$SHA