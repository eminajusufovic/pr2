#!/bin/bash


docker stop backend-container postgres-container || echo "Kontejneri već zaustavljeni."

echo "Aplikacija je pauzirana. Podaci su sačuvani."
