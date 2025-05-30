#!/bin/bash


docker network create my_app_network


docker volume create tododb_volume


docker build -t backend-image ./backend

echo "Aplikacija je pripremljena."
