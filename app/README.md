# Remix Weather App

A modern weather application built with Remix framework, designed for deployment on Azure Kubernetes Service (AKS).

## 🌤️ Features

- Real-time weather data
- City-based weather search
- Responsive design
- Server-side rendering with Remix
- Containerized for Kubernetes deployment

## 🛠️ Technology Stack

- **Framework**: Remix (React-based full-stack framework)
- **Runtime**: Node.js 18
- **Package Manager**: npm
- **Container**: Docker multi-stage build
- **Deployment**: Azure Kubernetes Service (AKS)

## 📦 Dependencies

```json
{
  "dependencies": {
    "@remix-run/node": "^2.0.0",
    "@remix-run/react": "^2.0.0",
    "@remix-run/serve": "^2.0.0",
    "react": "^18.0.0",
    "react-dom": "^18.0.0"
  },
  "devDependencies": {
    "@remix-run/dev": "^2.0.0",
    "@types/react": "^18.0.0",
    "@types/react-dom": "^18.0.0",
    "typescript": "^5.0.0",
    "vite": "^4.0.0"
  }
}
```

## 🐳 Docker Configuration

The application uses a multi-stage Docker build optimized for production:

### Stage 1: Dependencies
- Installs npm dependencies
- Builds the application

### Stage 2: Production
- Minimal Node.js Alpine image
- Only production files
- Optimized for container registries

### Build Commands
```bash
# Build image
docker build -t remix-weather .

# Run locally
docker run -p 3000:3000 remix-weather
```

## 🚀 Local Development

```bash
# Install dependencies
npm install

# Start development server
npm run dev

# Build for production
npm run build

# Start production server
npm start
```

## ☁️ Azure Deployment

This application is designed for deployment on Azure Container Apps or AKS:

### Container Registry
- Built and pushed to Azure Container Registry (ACR)
- Tagged with environment-specific versions

### Kubernetes Deployment
- Deployed to dedicated AKS cluster
- Configured with horizontal pod autoscaling
- Integrated with Azure Load Balancer

### Environment Variables
Configure these in your Kubernetes deployment:
- `PORT`: Application port (default: 3000)
- `NODE_ENV`: Environment (production/development)

## 📁 Project Structure

```
app/
├── app/                    # Remix application code
│   ├── routes/            # Route components
│   ├── components/        # Reusable components
│   └── root.tsx          # Root component
├── public/                # Static assets
├── Dockerfile            # Container configuration
├── package.json          # Dependencies and scripts
├── remix.config.js       # Remix configuration
├── tsconfig.json         # TypeScript configuration
└── vite.config.ts        # Vite configuration
```

## 🔧 Configuration

### Remix Configuration (remix.config.js)
```javascript
/** @type {import('@remix-run/dev').AppConfig} */
export default {
  ignoredRouteFiles: ["**/.*"],
};
```

### TypeScript Configuration
- Strict mode enabled
- ESNext target for modern environments
- Path mapping for clean imports

## 🌐 Environment Support

- **Development**: Hot reload with Vite
- **Testing**: Test environment deployment
- **Production**: Optimized build with caching

## 📊 Performance Features

- Server-side rendering (SSR)
- Automatic code splitting
- Progressive enhancement
- Optimized Docker layers
- Minimal production image size

## 🔍 Monitoring & Logging

Ready for Azure integration:
- Application Insights compatible
- Structured logging support
- Health check endpoints
- Prometheus metrics (can be added)

---

This weather application demonstrates modern web development practices with Remix framework, optimized for cloud-native deployment on Azure infrastructure.

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
