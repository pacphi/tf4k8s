#!/bin/bash

# Destroys all Terraform artifacts, directories and files under experiments and its subdirectories

cd ..
cd experiments
cd gcp
cd certmanager
rm -Rf .terraform terr* graph.svg
cd ../cluster
rm -Rf .terraform terr* graph.svg
cd ../dns
rm -Rf .terraform terr* graph.svg
cd ../external-dns
rm -Rf .terraform terr* graph.svg
cd ../..
cd k8s
cd cf4k8s
rm -Rf .terraform terr* graph.svg
cd ../harbor
rm -Rf .terraform terr* graph.svg
cd ../nginx-ingress
rm -Rf .terraform terr* graph.svg
