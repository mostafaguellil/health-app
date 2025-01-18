# Health Calculator Application

## Overview
The **Health Calculator** application provides an intuitive platform for users to calculate their **BMI (Body Mass Index)** and **BMR (Basal Metabolic Rate)**. Built using **Flask**, it features a responsive web interface optimized for desktop, tablet, and mobile devices. The design has been adapted specifically to ensure seamless usage on mobile versions. The application supports testing with **pytest** and offers automation through a **Makefile**.

---

## Features
- **BMI Calculator**:
  - Calculate your BMI by entering your height (meters) and weight (kg).
  - Displays the BMI value and the corresponding health category.
- **BMR Calculator**:
  - Input height (cm), weight (kg), age, and gender to compute daily calorie requirements.
  - Provides calorie needs for different activity levels.
- **Responsive Design**:
  - Accessible across desktop, tablet, and mobile devices with a clean interface.

---

## Components

### 1. Core Application
- **Backend**: Flask routes handle API requests for BMI and BMR calculations.
- **Frontend**: Interactive HTML and JavaScript for a smooth user experience.
- **Utilities**: Core logic for BMI and BMR calculations resides in `health_utils.py`.

### 2. Testing
- **Unit Tests**: Comprehensive tests in `test.py` validate BMI and BMR logic.

### 3. Automation
- **Makefile**: Simplifies common tasks such as building, testing, and running the application.
- **CI Workflow**: Includes a GitHub Actions configuration for automated testing on each commit.

---

## Deployment
The application is deployed on **Azure**. To access the live version, visit the deployment URL:
```
https://health-app-final-bfb6a8cagxftbhbd.francecentral-01.azurewebsites.net/
```

## Resource Group Creation
A resource group was created to organize and manage all the associated Azure resources for the application. This acts as a container to group services like App Service, App Service Plan, and storage.

## App Service Plan Setup
A dedicated App Service Plan is used to host and scale the application on Azure.

---

## Setup and Usage

### Prerequisites
- Python 3.9+
- Docker (if using containerization)

### Running the Application

#### Using Docker
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/mostafaguellil/health-app 
   cd health-app
   ```

2. **Build, Test, and Run**:
   ```bash
   make all
   ```

3. **Access the Application**:
   Open a browser and visit: `http://localhost:3000`.

#### Running Locally
1. **Set Up Virtual Environment**:
   ```bash
   make venv
   ```

2. **Run Locally**:
   ```bash
   make local
   ```

#### Running Tests
To validate the application logic:
```bash
make test
```

---

## Makefile Targets

| Command           | Description                                               |
|-------------------|-----------------------------------------------------------|
| `make help`       | Display all available commands.                           |
| `make all`        | Build, test, and run the application in Docker.           |
| `make venv`       | Create a Python virtual environment and install dependencies. |
| `make local`      | Run the application locally.                              |
| `make build`      | Build the Docker image.                                   |
| `make run`        | Run the Docker container.                                 |
| `make test`       | Run unit tests using pytest.                              |
| `make clean`      | Remove unused Docker resources.                           |
| `make clean-all`  | Clean all Docker resources and the virtual environment.   |

---

## Project Structure

```plaintext
.
├── Dockerfile           # Docker image configuration
├── Makefile             # Task automation
├── app.py               # Main Flask application
├── health_utils.py      # Utility functions for calculations
├── requirements.txt     # Dependencies
├── static/              # CSS and JS files
├── templates/           # HTML templates
├── test.py              # Unit tests
└── .github/workflows/   # CI configuration
```

---

## Continuous Integration
This project uses **GitHub Actions** for automated testing:
- Workflow file: `.github/workflows/ci.yml`
- On each push or pull request, tests are executed to ensure functionality.

