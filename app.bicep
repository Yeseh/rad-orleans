extension radius

param application string
param environment string

resource demo 'Applications.Core/containers@2023-10-01-preview' = {
  name: 'demo'
  properties: {
    application: application
    container: {
      image: 'localhost:5000/yeseh/rad-orleans:latest'
      ports: {
        web: {
          containerPort: 3000
        }
      }
      env: {
        // Inject a .NET connectionstring for the database so we can GetConnectionString() in the application 
        'ConnectionStrings__${db.name}': {
          value: db.listSecrets().connectionString
        }
      }
    }
    connections: {
      sql: {
        source: db.id
      }
    }
  }
}

resource db 'Applications.Datastores/sqlDatabases@2023-10-01-preview' = {
  name: 'sql'
  properties: {
    environment: environment
    application: application
  }
}
