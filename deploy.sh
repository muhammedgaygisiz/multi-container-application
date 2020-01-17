docker build -t mgaygisiz/multi-client:latest -t mgaygisiz/multi-clinet:$SHA -f ./client/Dockerfile ./client
docker build -t mgaygisiz/multi-server:latest -t mgaygisiz/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mgaygisiz/multi-worker:latest -t mgaygisiz/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mgaygisiz/multi-client:latest
docker push mgaygisiz/multi-server:latest
docker push mgaygisiz/multi-worker:latest

docker push mgaygisiz/multi-client:$SHA
docker push mgaygisiz/multi-server:$SHA
docker push mgaygisiz/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=mgaygisiz/multi-server:$SHA
kubectl set image deployments/client-deployment client=mgaygisiz/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mgaygisiz/multi-worker:$SHA
