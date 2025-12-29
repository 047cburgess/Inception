# Inception

A comprehensive Docker Compose infrastructure project featuring WordPress with multiple integrated services, developed as part of the 42 School curriculum.

## Project Overview

This project demonstrates containerization and orchestration of a complete web infrastructure using Docker and Docker Compose. The architecture includes a WordPress site with supporting services such as database, caching, FTP, reverse proxy, and container management tools.

## Architecture

The project is organized around a multi-container Docker environment with the following services:

### Core Services
- **WordPress** - Content management system with PHP-FPM
- **MariaDB** - Relational database backend for WordPress
- **Nginx** - Web server and reverse proxy

### Bonus Services
- **Adminer** - Web-based database administration interface
- **FTP** - File Transfer Protocol server for file management
- **Portainer** - Container management and monitoring UI
- **Redis** - In-memory data store for caching
- **Static Site** - Additional static website service with Nginx

## Directory Structure

```
srcs/
├── docker-compose.yml     # Docker Compose configuration
└── requirements/
    ├── mariadb/          # MariaDB service configuration
    ├── nginx/            # Nginx service configuration
    ├── wordpress/        # WordPress service configuration
    └── bonus/            # Additional services
        ├── adminer/
        ├── ftp/
        ├── portainer/
        ├── redis/
        └── staticsite/
```

## Key Features

- **Containerized Infrastructure** - Each service runs in its own isolated Docker container
- **Data Persistence** - Volumes for WordPress, MariaDB, Redis, and Portainer data
- **Networking** - Custom Docker network for inter-service communication
- **Configuration Management** - Environment variables and configuration files for each service
- **Health Checks** - MariaDB healthcheck to ensure database readiness
- **HTTPS Support** - SSL/TLS certificates for secure connections
- **FTP Integration** - File transfer capabilities for WordPress uploads
- **Caching Layer** - Redis integration for performance optimization
- **Database Administration** - Adminer for convenient database management
- **Container Orchestration** - Portainer for visual container management

## Technology Stack

- **Docker & Docker Compose** - Container orchestration
- **WordPress** - PHP-based CMS
- **MariaDB** - MySQL-compatible database
- **Nginx** - Web server and reverse proxy
- **PHP-FPM** - PHP FastCGI Process Manager
- **vsftpd** - FTP server
- **Redis** - Caching and session storage
- **Portainer** - Container management platform
- **Adminer** - Database administration tool

## Service Configuration

Each service includes:
- Custom Dockerfile for containerization
- Service-specific configuration files
- Startup and initialization scripts
- Health monitoring capabilities

### Environment Setup

The project uses environment variables for configuration:
- `.env` file for service credentials and settings
- `secrets` folder for sensitive data
- Service-specific configuration files in `conf/` directories

## Notes

This project was developed within a virtual machine environment as part of the 42 School curriculum and represents a learning implementation of Docker and containerized infrastructure concepts.
