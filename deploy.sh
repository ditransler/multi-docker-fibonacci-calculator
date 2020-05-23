docker build -t ditransler/multi-docker-fibonacci-calculator-client:latest -t ditransler/multi-docker-fibonacci-calculator-client:$SHA -f ./client/Dockerfile ./client
docker build -t ditransler/multi-docker-fibonacci-calculator-server:latest -t ditransler/multi-docker-fibonacci-calculator-server:$SHA -f ./server/Dockerfile ./server
docker build -t ditransler/multi-docker-fibonacci-calculator-worker:latest -t ditransler/multi-docker-fibonacci-calculator-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ditransler/multi-docker-fibonacci-calculator-client:latest
docker push ditransler/multi-docker-fibonacci-calculator-server:latest
docker push ditransler/multi-docker-fibonacci-calculator-worker:latest

docker push ditransler/multi-docker-fibonacci-calculator-client:$SHA
docker push ditransler/multi-docker-fibonacci-calculator-server:$SHA
docker push ditransler/multi-docker-fibonacci-calculator-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ditransler/multi-docker-fibonacci-calculator-server:$SHA
kubectl set image deployments/client-deployment client=ditransler/multi-docker-fibonacci-calculator-client:$SHA
kubectl set image deployments/worker-deployment worker=ditransler/multi-docker-fibonacci-calculator-worker:$SHA