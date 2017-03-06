#!/bin/bash
docker build -t liana/sample-node .
docker push liana/sample-node

ssh gareeva_inno@104.196.248.113  << EOF
docker pull liana/sample-node:latest
docker stop web || true
docker rm web || true
docker rmi liana/sample-node:current || true
docker tag liana/sample-node:latest liana/sample-node:current
docker run -d --net app --restart always --name web -p 80:80 liana/sample-node:current
EOF
