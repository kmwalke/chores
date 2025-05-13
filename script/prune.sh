#!/bin/bash
docker system prune -af && docker network prune -f && docker volume prune -af