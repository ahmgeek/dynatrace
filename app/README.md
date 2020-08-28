# Transactions APIs

Top notch CRUD APIs to store/fetch transactions from an in-memory DB.

# Directory structure
```
.
├── api     # contains the API router
├── lib
│   ├── errors # Error handler for the HTTP requests
│   ├── models # Data entities
│   ├── repositories # in-memory db
│   └── use_cases # Service object
```

# Tests
The application is fully covered with unit tests / integration tests.

Please check `spec/` for the full specs.

# Running the app

`docker-compose up -d` will install the needed images and run everything in the background.

The app runts on port `5500` [localhost:5500](http://localhost:5500)

# Monitoring
The app is monitored via `prometheus` and there's an already provisioned dashboards on `Grafana`

To access the dashboard: [http://localhost:3000](http:localhost:3000)
  - user: admin
  - pass: 123456

`Prometheus` runs on the port `9090`: [http:localhost:9090](http:localhost:9090)
