# Remix Weather Application

This directory contains the Remix Weather application code.

## Structure
```
app/
├── README.md                 # This file
├── package.json             # Node.js dependencies
├── Dockerfile              # Docker configuration
├── app/                    # Remix app source code
│   ├── root.tsx
│   ├── routes/
│   │   └── _index.tsx
│   └── components/
└── public/                 # Static assets
```

## Getting Started

1. Install dependencies:
   ```bash
   npm install
   ```

2. Run development server:
   ```bash
   npm run dev
   ```

3. Build for production:
   ```bash
   npm run build
   ```

4. Build Docker image:
   ```bash
   docker build -t remix-weather .
   ```

## Deployment

The application is deployed to Azure Kubernetes Service (AKS) using the infrastructure defined in the `infra/` directory.
