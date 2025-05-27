# Node.js Development Guidelines

## Package Management

- Use npm (not yarn) for consistency across projects
- Always commit package-lock.json
- Run npm audit regularly and fix vulnerabilities
- Use exact versions in package.json for critical dependencies

## Project Structure

```
project/
├── src/              # Source code
│   ├── routes/       # API routes
│   ├── models/       # Data models
│   ├── services/     # Business logic
│   └── utils/        # Utilities
├── tests/            # Test files
├── public/           # Static assets (if applicable)
└── package.json
```

## Code Style

- **Linting**: ESLint with project configuration
- **Formatting**: Prettier (integrate with ESLint)
- **Style**: Prefer modern ES6+ syntax
- Use semicolons consistently
- Prefer const over let, avoid var

## TypeScript

- Preferred for new code
- Strict mode enabled in tsconfig.json
- Interface over type aliases for objects
- Explicit return types for functions

## Testing

- **Framework**: Jest for all testing needs
- **API Testing**: Supertest for HTTP endpoints
- **React Testing**: React Testing Library
- **Coverage**: Aim for 80%+ coverage
- **Structure**: __tests__ folders or .test.js files

## API Development

### Express Best Practices
```javascript
// ABOUTME: Error handling middleware
// Centralized error handling for Express apps
app.use((err, req, res, next) => {
  logger.error(err.stack);
  res.status(err.status || 500).json({
    error: {
      message: err.message,
      ...(process.env.NODE_ENV === 'development' && { stack: err.stack })
    }
  });
});
```

### RESTful Conventions
- GET /api/resources - List
- GET /api/resources/:id - Get one
- POST /api/resources - Create
- PUT /api/resources/:id - Update
- DELETE /api/resources/:id - Delete

### Authentication
- JWT for stateless auth
- Store tokens in httpOnly cookies when possible
- Always validate input with express-validator

## Frontend (React/Next.js)

### Component Structure
```jsx
// ABOUTME: Functional component with hooks
// Standard pattern for React components
function ComponentName({ prop1, prop2 }) {
  const [state, setState] = useState(initialValue);
  
  useEffect(() => {
    // Side effects
  }, [dependencies]);
  
  return <div>{/* JSX */}</div>;
}
```

### State Management
- useState for local state
- useContext for cross-component state
- Consider Redux Toolkit for complex apps
- Server state: React Query or SWR

## Database Access

### MongoDB
- Use Mongoose for schema validation
- Always handle connection errors
- Index frequently queried fields

### PostgreSQL
- Use parameterized queries
- Connection pooling with pg-pool
- Migrations with knex or similar

## Security

- Helmet.js for security headers
- Rate limiting with express-rate-limit
- Input validation on all endpoints
- Sanitize user input
- Use CORS appropriately

## Environment Configuration

```javascript
// ABOUTME: Environment configuration
// Load and validate environment variables
require('dotenv').config();

const config = {
  port: process.env.PORT || 3000,
  dbUrl: process.env.DATABASE_URL,
  jwtSecret: process.env.JWT_SECRET,
  // Validate required vars
  validate() {
    if (!this.jwtSecret) {
      throw new Error('JWT_SECRET must be set');
    }
  }
};

config.validate();
module.exports = config;
```

## Error Handling

- Always use try-catch for async operations
- Create custom error classes
- Log errors with context
- Never expose internal errors to users

## Performance

- Use compression middleware
- Implement caching strategies
- Lazy load large modules
- Use PM2 for production process management