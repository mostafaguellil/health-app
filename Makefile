# Variables
APP_NAME := health_calculator
DOCKER_IMAGE := $(APP_NAME):latest
DOCKER_CONTAINER := $(APP_NAME)_container
HOST_PORT := 3000
DOCKER_PORT := 3000
VENV := myvenv
PYTHON := python3

# Default target: build, test, run the app
.PHONY: all
all: venv build test run

# Help: list available commands
.PHONY: help
help:
	@echo "Available commands:"
	@echo "  make help          - Show this help message."
	@echo "  make all           - Build the app, run tests, and start it in Docker."
	@echo "  make venv          - Create a Python virtual environment and install dependencies."
	@echo "  make build         - Build the Docker image."
	@echo "  make run           - Run the app in a Docker container."
	@echo "  make test          - Run unit tests using the virtual environment."
	@echo "  make local         - Run the app locally using the virtual environment."
	@echo "  make clean         - Clean up unused Docker resources."
	@echo "  make clean-all     - Remove Docker containers, images, and the virtual environment."
	
# Create and set up the virtual environment
.PHONY: venv
venv:
	@echo "Creating virtual environment..."
	@if [ ! -d "$(VENV)" ]; then \
		$(PYTHON) -m venv $(VENV); \
		. $(VENV)/bin/activate && pip install --upgrade pip && pip install -r requirements.txt; \
		echo "Virtual environment created and dependencies installed."; \
	else \
		echo "Virtual environment already exists."; \
	fi

# Build the Docker image
.PHONY: build
build:
	@echo "Building Docker image..."
	docker build -t $(DOCKER_IMAGE) .

# Run the application in a Docker container
.PHONY: run
run:
	@echo "Running application in Docker container..."
	@if [ "`docker ps -q -f name=$(DOCKER_CONTAINER)`" ]; then \
		echo "$(DOCKER_CONTAINER) is already running at http://localhost:$(HOST_PORT)"; \
	else \
		docker run -d --name $(DOCKER_CONTAINER) -p $(HOST_PORT):$(DOCKER_PORT) $(DOCKER_IMAGE); \
		echo "Application started. Visit http://localhost:$(HOST_PORT)"; \
	fi

# Run tests inside the virtual environment
.PHONY: test
test: venv
	@echo "Running tests..."
	. $(VENV)/bin/activate && python -m unittest discover -s . -p 'test*.py'

# Clean up dangling Docker resources
.PHONY: clean
clean:
	@echo "Cleaning up unused Docker resources..."
	-docker system prune -f

# Full clean-up (removing images, containers, and the virtual environment)
.PHONY: clean-all
clean-all:
	@echo "Removing all related Docker images and containers..."
	-docker rm -f $(DOCKER_CONTAINER) || true
	-docker rmi -f $(DOCKER_IMAGE) || true
	-docker system prune -f
	@echo "Removing virtual environment..."
	-rm -rf $(VENV)

# Run the app locally (outside Docker) using the virtual environment
.PHONY: local
local: venv
	@echo "Running application locally..."
	. $(VENV)/bin/activate && flask run --host=0.0.0.0 --port=$(HOST_PORT)
