#!/bin/bash


docker stop backend-container postgres-container 2>/dev/null || echo "Kontejneri već zaustavljeni."


docker rm backend-container postgres-container 2>/dev/null || echo "Kontejneri već obrisani."


docker volume rm tododb_volume 2>/dev/null || echo "Volumen već obrisan."


docker network rm my_app_network 2>/dev/null || echo "Mreža već obrisana."


docker rmi backend-image 2>/dev/null || echo "Slika backend-image već obrisana."

echo "Aplikacija i svi resursi su obrisani."
