# API Design Patterns

## RESTful Endpoint Structure

All API endpoints follow consistent patterns:

### Resource Naming
```
GET    /api/contacts          # List all contacts
GET    /api/contacts/:id      # Get specific contact
POST   /api/contacts          # Create new contact
PUT    /api/contacts/:id      # Update contact
DELETE /api/contacts/:id      # Delete contact
```

### Query Parameters
```
GET /api/contacts?source=LinkedIn&limit=50&offset=0
GET /api/contacts?category=executive&sort=-updatedAt
GET /api/contacts?search=john&fields=name,email,company
```

## Response Formats

### Success Response
```json
{
  "success": true,
  "data": {
    // Resource data
  },
  "metadata": {
    "timestamp": "2024-01-15T10:30:00Z",
    "version": "1.0"
  }
}
```

### Error Response
```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid email format",
    "field": "email",
    "details": {
      // Additional error context
    }
  }
}
```

### Paginated Response
```json
{
  "success": true,
  "data": [...],
  "pagination": {
    "total": 150,
    "limit": 50,
    "offset": 0,
    "hasNext": true,
    "hasPrev": false
  }
}
```

## Authentication Patterns

### Token-Based Auth
```javascript
// ABOUTME: JWT authentication middleware
// Validates tokens and attaches user to request
const authenticateToken = (req, res, next) => {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];
  
  if (!token) {
    return res.status(401).json({
      success: false,
      error: { code: 'NO_TOKEN', message: 'Access token required' }
    });
  }
  
  jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
    if (err) {
      return res.status(403).json({
        success: false,
        error: { code: 'INVALID_TOKEN', message: 'Invalid or expired token' }
      });
    }
    
    req.user = user;
    next();
  });
};
```

## Validation Patterns

### Request Validation
```javascript
// ABOUTME: Express validator middleware
// Validates and sanitizes input
const { body, validationResult } = require('express-validator');

const validateContact = [
  body('name').trim().notEmpty().withMessage('Name is required'),
  body('email').isEmail().normalizeEmail().withMessage('Valid email required'),
  body('phone').optional().isMobilePhone().withMessage('Invalid phone number'),
  body('tags').optional().isArray().withMessage('Tags must be an array'),
  
  (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({
        success: false,
        error: {
          code: 'VALIDATION_ERROR',
          message: 'Invalid input data',
          details: errors.array()
        }
      });
    }
    next();
  }
];
```

## Error Handling

### Centralized Error Handler
```javascript
// ABOUTME: Global error handling middleware
// Catches and formats all errors consistently
class APIError extends Error {
  constructor(code, message, statusCode = 400) {
    super(message);
    this.code = code;
    this.statusCode = statusCode;
  }
}

const errorHandler = (err, req, res, next) => {
  logger.error({
    error: err.message,
    stack: err.stack,
    url: req.url,
    method: req.method,
    body: req.body
  });
  
  if (err instanceof APIError) {
    return res.status(err.statusCode).json({
      success: false,
      error: {
        code: err.code,
        message: err.message
      }
    });
  }
  
  // Default error response
  res.status(500).json({
    success: false,
    error: {
      code: 'INTERNAL_ERROR',
      message: 'An unexpected error occurred'
    }
  });
};
```

## Data Transformation

### DTO Pattern
```javascript
// ABOUTME: Data Transfer Object pattern
// Transforms internal data to API format
class ContactDTO {
  static toAPI(contact) {
    return {
      id: contact._id || contact.id,
      name: contact.name,
      email: contact.email,
      company: contact.company,
      title: contact.title,
      linkedIn: contact.linkedInUrl,
      tags: contact.tags || [],
      source: contact.source,
      lastContactedAt: contact.lastContactedAt,
      createdAt: contact.createdAt,
      updatedAt: contact.updatedAt
    };
  }
  
  static fromAPI(data) {
    return {
      name: data.name,
      email: data.email?.toLowerCase(),
      company: data.company,
      title: data.title,
      linkedInUrl: data.linkedIn,
      tags: data.tags?.map(tag => tag.toLowerCase()),
      source: data.source || 'manual'
    };
  }
}
```

## Caching Strategy

### Response Caching
```javascript
// ABOUTME: Redis-based response caching
// Reduces database load for frequently accessed data
const cache = require('./utils/cache');

const cacheMiddleware = (duration = 300) => {
  return async (req, res, next) => {
    if (req.method !== 'GET') return next();
    
    const key = `cache:${req.originalUrl}`;
    const cached = await cache.get(key);
    
    if (cached) {
      return res.json(JSON.parse(cached));
    }
    
    // Store original send function
    const originalSend = res.json;
    
    // Override send to cache response
    res.json = function(data) {
      cache.set(key, JSON.stringify(data), duration);
      originalSend.call(this, data);
    };
    
    next();
  };
};
```

## Rate Limiting

### API Rate Limits
```javascript
const rateLimit = require('express-rate-limit');

const apiLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // limit each IP to 100 requests per windowMs
  message: {
    success: false,
    error: {
      code: 'RATE_LIMIT_EXCEEDED',
      message: 'Too many requests, please try again later'
    }
  }
});

const strictLimiter = rateLimit({
  windowMs: 60 * 1000, // 1 minute
  max: 10, // strict limit for sensitive endpoints
  skipSuccessfulRequests: true
});
```

## Integration Patterns

### External API Calls
```javascript
// ABOUTME: External API integration pattern
// Handles retries, timeouts, and errors gracefully
class ExternalAPIClient {
  constructor(baseURL, apiKey) {
    this.client = axios.create({
      baseURL,
      timeout: 10000,
      headers: {
        'Authorization': `Bearer ${apiKey}`,
        'Content-Type': 'application/json'
      }
    });
    
    // Add retry logic
    this.client.interceptors.response.use(
      response => response,
      async error => {
        const { config, response } = error;
        
        if (!config || !config.retry) {
          config.retry = 0;
        }
        
        if (config.retry < 3 && (!response || response.status >= 500)) {
          config.retry += 1;
          const delay = config.retry * 1000;
          
          await new Promise(resolve => setTimeout(resolve, delay));
          return this.client(config);
        }
        
        throw error;
      }
    );
  }
}
```

## Batch Operations

### Bulk Endpoints
```javascript
// POST /api/contacts/bulk
router.post('/bulk', async (req, res) => {
  const { operations } = req.body;
  const results = [];
  
  for (const op of operations) {
    try {
      let result;
      switch (op.action) {
        case 'create':
          result = await createContact(op.data);
          break;
        case 'update':
          result = await updateContact(op.id, op.data);
          break;
        case 'delete':
          result = await deleteContact(op.id);
          break;
      }
      
      results.push({ success: true, id: op.id, result });
    } catch (error) {
      results.push({ 
        success: false, 
        id: op.id, 
        error: error.message 
      });
    }
  }
  
  res.json({
    success: true,
    data: results,
    summary: {
      total: operations.length,
      succeeded: results.filter(r => r.success).length,
      failed: results.filter(r => !r.success).length
    }
  });
});
```