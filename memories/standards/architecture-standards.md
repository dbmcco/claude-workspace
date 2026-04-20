# System Architecture Standards

**ABOUTME:** Comprehensive architectural standards for modern web applications and systems
**ABOUTME:** Version 1.0 - Reference guide for consistent architectural decisions during development

## Table of Contents

1. [Overview](#1-overview)
2. [Architectural Principles](#2-architectural-principles)
3. [Component Architecture Patterns](#3-component-architecture-patterns)
4. [Data Architecture Standards](#4-data-architecture-standards)
5. [API Design Standards](#5-api-design-standards)
6. [Security Architecture](#6-security-architecture)
7. [Performance Standards](#7-performance-standards)
8. [Integration Patterns](#8-integration-patterns)
9. [Deployment Architecture](#9-deployment-architecture)
10. [Implementation Guidelines](#10-implementation-guidelines)

---

## 1. Overview

### 1.1 Purpose

These standards provide architectural guidance for modern application development, ensuring consistency across all domains while maintaining performance, security, and scalability requirements. This document serves as a reference for Claude agents and developers implementing system components.

### 1.2 Scope

Applies to all application components including:
- Business domain services (authentication, data management, reporting, etc.)
- API endpoints and data services
- Database patterns and data flows
- External integrations (APIs, ML services, third-party systems)
- Security and performance implementations

### 1.3 Tech Stack Foundation

Our architecture is built on modern, production-ready technologies:
- **Frontend**: Next.js 14+ (App Router) + TypeScript + Tailwind CSS + Shadcn/ui
- **Backend**: Next.js API routes + TypeScript + Zod validation
- **Database**: PostgreSQL + Prisma ORM (adaptable to other databases)
- **Deployment**: Vercel + GitHub Actions (adaptable to other platforms)
- **Testing**: Jest + React Testing Library + TDD workflow

### 1.4 AI Agent Implementation Notes

When implementing these standards:
- Follow entity-based multi-tenancy patterns where applicable
- Use TypeScript strict mode throughout
- Implement comprehensive error handling
- Follow TDD workflow with >90% coverage
- Use ORM (Prisma recommended) for all database operations
- Apply Zod validation for all inputs

---

## 2. Architectural Principles

### 2.1 Core Principles

#### 2.1.1 Domain-Centric Design
```typescript
// All operations are scoped to business domains
interface DomainScopedOperation {
  userId: string;
  domainId: string;
  operation: BusinessOperation;
}

// Example: Operation always includes domain context
const performOperation = async (userId: string, domainId: string, data: OperationData) => {
  // Validate domain access
  await validateDomainAccess(userId, domainId);
  // Perform operation within domain scope
  return repository.create({
    ...data,
    userId,
    domainId
  });
};
```

#### 2.1.2 Type-Safe End-to-End
```typescript
// Database → API → Frontend type safety
// ORM generates types from schema
import { User, Document } from '@prisma/client';

// API routes use Zod for validation
const DocumentSchema = z.object({
  title: z.string().min(1),
  content: z.string(),
  userId: z.string().cuid(),
  domainId: z.string().cuid(),
});

// Frontend uses validated types
type ValidatedDocument = z.infer<typeof DocumentSchema>;
```

#### 2.1.3 Performance-First Design
```typescript
// All operations target <500ms response times
export const PERFORMANCE_TARGETS = {
  API_RESPONSE: 500, // milliseconds
  DATABASE_QUERY: 100, // milliseconds
  PAGE_LOAD: 2000, // milliseconds
  LARGE_LIST_RENDER: 100, // milliseconds for 10K+ items
} as const;

// Use performance monitoring
export const withPerformanceLogging = <T>(
  operation: string,
  fn: () => Promise<T>
): Promise<T> => {
  const start = performance.now();
  return fn().finally(() => {
    const duration = performance.now() - start;
    if (duration > PERFORMANCE_TARGETS.API_RESPONSE) {
      console.warn(`Slow operation: ${operation} took ${duration}ms`);
    }
  });
};
```

#### 2.1.4 Security by Design
```typescript
// Multi-layer security validation
export const secureOperation = async <T>(
  userId: string,
  resourceId: string,
  operation: () => Promise<T>
): Promise<T> => {
  // 1. Validate user authentication
  await validateUserAuth(userId);
  
  // 2. Validate resource access
  await validateResourceAccess(userId, resourceId);
  
  // 3. Perform operation with audit trail
  const result = await operation();
  
  // 4. Log security-relevant operations
  await auditLog(userId, resourceId, 'operation_performed');
  
  return result;
};
```

### 2.2 Design Patterns

#### 2.2.1 Repository Pattern
```typescript
// Consistent data access patterns
export interface DocumentRepository {
  findByDomain(domainId: string, filters?: DocumentFilters): Promise<Document[]>;
  create(data: CreateDocumentData): Promise<Document>;
  update(id: string, data: UpdateDocumentData): Promise<Document>;
  delete(id: string): Promise<void>;
}

export class PrismaDocumentRepository implements DocumentRepository {
  constructor(private prisma: PrismaClient) {}
  
  async findByDomain(domainId: string, filters?: DocumentFilters) {
    return this.prisma.document.findMany({
      where: { domainId, ...filters },
      include: { author: true, tags: true },
      orderBy: { createdAt: 'desc' }
    });
  }
}
```

#### 2.2.2 Service Layer Pattern
```typescript
// Business logic encapsulation
export class DocumentService {
  constructor(
    private documentRepo: DocumentRepository,
    private searchService: SearchService,
    private auditService: AuditService
  ) {}
  
  async createDocument(
    userId: string,
    domainId: string,
    data: CreateDocumentData
  ): Promise<Document> {
    return secureOperation(userId, domainId, async () => {
      // Apply content processing
      const processed = await this.searchService.processContent(data.content);
      
      // Create document
      const document = await this.documentRepo.create({
        ...data,
        ...processed,
        userId,
        domainId
      });
      
      // Update search index
      await this.searchService.index(document);
      
      return document;
    });
  }
}
```

---

## 3. Component Architecture Patterns

### 3.1 Domain Organization

#### 3.1.1 Domain Structure
```
src/
├── domains/
│   ├── authentication/          # User management and auth
│   │   ├── services/
│   │   ├── repositories/
│   │   ├── types/
│   │   └── api/
│   ├── documents/              # Document management
│   │   ├── services/
│   │   ├── repositories/
│   │   ├── types/
│   │   └── api/
│   ├── analytics/              # Data analysis
│   └── reporting/              # Reports and dashboards
├── shared/
│   ├── services/               # Cross-domain services
│   ├── types/                  # Shared TypeScript types
│   ├── utils/                  # Utility functions
│   └── middleware/             # API middleware
└── components/
    ├── ui/                     # Shadcn/ui components
    ├── domain/                 # Domain-specific components
    └── shared/                 # Shared components
```

#### 3.1.2 Domain Interface Pattern
```typescript
// Consistent domain interfaces
export interface BusinessDomain {
  name: string;
  services: DomainServices;
  repositories: DomainRepositories;
  api: DomainAPIHandlers;
  components: DomainComponents;
}

// Example: Documents domain
export const DocumentsDomain: BusinessDomain = {
  name: 'documents',
  services: {
    documentService: new DocumentService(),
    searchService: new SearchService(),
  },
  repositories: {
    documentRepository: new PrismaDocumentRepository(),
  },
  api: {
    '/api/documents': documentHandlers,
  },
  components: {
    DocumentList: DocumentListComponent,
    DocumentForm: DocumentFormComponent,
  }
};
```

### 3.2 Component Patterns

#### 3.2.1 API Route Pattern
```typescript
// Consistent API route structure
export async function POST(request: Request) {
  try {
    // 1. Authentication & authorization
    const { userId } = await validateAuth(request);
    
    // 2. Input validation
    const body = await request.json();
    const validated = DocumentSchema.parse(body);
    
    // 3. Domain access validation
    await validateDomainAccess(userId, validated.domainId);
    
    // 4. Business logic execution
    const result = await documentService.create(userId, validated);
    
    // 5. Response formatting
    return NextResponse.json(result, { status: 201 });
    
  } catch (error) {
    return handleAPIError(error);
  }
}
```

#### 3.2.2 React Component Pattern
```typescript
// Consistent component structure
interface DocumentListProps {
  domainId: string;
  filters?: DocumentFilters;
}

export function DocumentList({ domainId, filters }: DocumentListProps) {
  // 1. Data fetching with error handling
  const { data: documents, isLoading, error } = useDocuments(domainId, filters);
  
  // 2. Performance optimization for large lists
  const virtualizer = useVirtualizer({
    count: documents?.length ?? 0,
    getScrollElement: () => parentRef.current,
    estimateSize: () => 60,
  });
  
  // 3. Error states
  if (error) return <ErrorBoundary error={error} />;
  if (isLoading) return <LoadingState />;
  
  // 4. Virtualized rendering for performance
  return (
    <div ref={parentRef} className="h-96 overflow-auto">
      <div style={{ height: `${virtualizer.getTotalSize()}px` }}>
        {virtualizer.getVirtualItems().map((virtualItem) => (
          <DocumentItem
            key={virtualItem.key}
            document={documents[virtualItem.index]}
            style={{
              position: 'absolute',
              top: 0,
              left: 0,
              width: '100%',
              height: `${virtualItem.size}px`,
              transform: `translateY(${virtualItem.start}px)`,
            }}
          />
        ))}
      </div>
    </div>
  );
}
```

---

## 4. Data Architecture Standards

### 4.1 Database Design Patterns

#### 4.1.1 Multi-Tenant Data Scoping
```typescript
// All queries must be tenant-scoped
export const tenantScopedQuery = <T>(
  tenantId: string,
  userId: string,
  query: Prisma.DocumentFindManyArgs
): Prisma.DocumentFindManyArgs => ({
  ...query,
  where: {
    ...query.where,
    tenantId,
    userId, // Double validation for security
  }
});

// Usage example
const getDocuments = async (userId: string, tenantId: string) => {
  return prisma.document.findMany(
    tenantScopedQuery(tenantId, userId, {
      include: { author: true, tags: true },
      orderBy: { createdAt: 'desc' },
      take: 100
    })
  );
};
```

#### 4.1.2 Data Flow Patterns
```typescript
// Data flows through domain boundaries
export interface DomainDataFlow {
  source: BusinessDomain;
  target: BusinessDomain;
  data: DataTransfer;
  classification: TransferClassification;
}

// Cross-domain data transfer
export const transferData = async (
  fromDomain: string,
  toDomain: string,
  data: any
): Promise<DomainDataFlow | null> => {
  // Validate cross-domain transfer permissions
  await validateCrossDomainAccess(fromDomain, toDomain);
  
  // Apply data transformation rules
  const transformed = await transformForDomain(data, toDomain);
  
  // Create audit trail
  await auditCrossDomainTransfer(fromDomain, toDomain, data);
  
  return {
    source: fromDomain,
    target: toDomain,
    data: transformed,
    classification: 'INTERNAL_TRANSFER'
  };
};
```

### 4.2 Performance Patterns

#### 4.2.1 Database Query Optimization
```typescript
// Optimized query patterns
export const performanceOptimizedQueries = {
  // Index-optimized queries
  recentDocuments: (tenantId: string, limit = 50) => ({
    where: { tenantId },
    orderBy: { createdAt: 'desc' as const },
    take: limit,
    include: {
      author: { select: { name: true, email: true } },
      tags: { select: { name: true, color: true } }
    }
  }),
  
  // Aggregation queries for dashboards
  monthlyActivity: (tenantId: string, months = 12) => 
    prisma.$queryRaw`
      SELECT 
        DATE_TRUNC('month', created_at) as month,
        COUNT(*) as document_count,
        COUNT(DISTINCT user_id) as active_users
      FROM documents 
      WHERE tenant_id = ${tenantId} 
        AND created_at >= NOW() - INTERVAL '${months} months'
      GROUP BY DATE_TRUNC('month', created_at)
      ORDER BY month DESC
    `,
    
  // Cached summaries
  domainSummary: async (tenantId: string) => {
    const cached = await redis.get(`summary:${tenantId}`);
    if (cached) return JSON.parse(cached);
    
    const summary = await prisma.document.groupBy({
      by: ['status'],
      where: { tenantId },
      _count: { id: true },
      _avg: { size: true }
    });
    
    await redis.setex(`summary:${tenantId}`, 300, JSON.stringify(summary)); // 5min cache
    return summary;
  }
};
```

#### 4.2.2 Real-Time Data Patterns
```typescript
// WebSocket patterns for real-time updates
export class DataStreamer {
  private connections = new Map<string, WebSocket[]>();
  
  async broadcastUpdate(tenantId: string, update: DataUpdate) {
    const tenantConnections = this.connections.get(tenantId) || [];
    
    const message = {
      type: 'data_update',
      tenantId,
      data: update,
      timestamp: new Date()
    };
    
    // Broadcast to all connected clients for this tenant
    await Promise.all(
      tenantConnections.map(ws => 
        this.safeSend(ws, JSON.stringify(message))
      )
    );
  }
  
  async handleDataChange(change: DataChange) {
    // Real-time updates
    await this.broadcastUpdate(change.tenantId, {
      type: 'document_updated',
      document: change.document,
      changeType: change.type
    });
    
    // Invalidate cached data
    await redis.del(`summary:${change.tenantId}`);
    await redis.del(`recent:${change.tenantId}`);
  }
}
```

### 4.3 Data Consistency Patterns

#### 4.3.1 Transaction Integrity
```typescript
// Ensure data consistency across operations
export const withTransaction = async <T>(
  operation: (tx: PrismaTransactionClient) => Promise<T>
): Promise<T> => {
  return prisma.$transaction(async (tx) => {
    try {
      const result = await operation(tx);
      
      // Validate data consistency
      await validateDataIntegrity(tx);
      
      return result;
    } catch (error) {
      console.error('Transaction failed:', error);
      throw error;
    }
  });
};

// Example: Complex multi-table operation
export const createDocumentWithRelations = async (
  data: ComplexDocumentData
) => {
  return withTransaction(async (tx) => {
    // Create primary document
    const document = await tx.document.create({
      data: {
        title: data.title,
        content: data.content,
        tenantId: data.tenantId,
        userId: data.userId
      }
    });
    
    // Create related tags
    const tags = await Promise.all(
      data.tags.map(tag => 
        tx.tag.upsert({
          where: { name_tenantId: { name: tag.name, tenantId: data.tenantId } },
          create: { name: tag.name, tenantId: data.tenantId },
          update: {}
        })
      )
    );
    
    // Link document to tags
    await tx.documentTag.createMany({
      data: tags.map(tag => ({
        documentId: document.id,
        tagId: tag.id
      }))
    });
    
    return { document, tags };
  });
};
```

---

## 5. API Design Standards

### 5.1 RESTful API Patterns

#### 5.1.1 URL Structure
```typescript
// Consistent API endpoint patterns
const API_PATTERNS = {
  // Resource-scoped endpoints
  '/api/tenants/:tenantId/documents',           // GET, POST
  '/api/tenants/:tenantId/documents/:id',       // GET, PUT, DELETE
  '/api/tenants/:tenantId/analytics',           // GET
  '/api/tenants/:tenantId/reports',             // GET, POST
  
  // Cross-tenant operations (admin only)
  '/api/admin/tenants',                         // GET, POST
  '/api/admin/users',                           // GET
  
  // System-level endpoints
  '/api/user/profile',                          // GET, PUT
  '/api/system/health',                         // GET
} as const;
```

#### 5.1.2 Request/Response Patterns
```typescript
// Standardized API request/response types
export interface APIRequest<T = unknown> {
  userId: string;
  tenantId?: string;
  data: T;
  metadata?: RequestMetadata;
}

export interface APIResponse<T = unknown> {
  success: boolean;
  data?: T;
  error?: APIError;
  metadata: ResponseMetadata;
}

export interface APIError {
  code: string;
  message: string;
  details?: Record<string, unknown>;
  timestamp: string;
}

// Response metadata for performance tracking
export interface ResponseMetadata {
  requestId: string;
  timestamp: string;
  duration: number;
  tenantId?: string;
}
```

#### 5.1.3 Validation Patterns
```typescript
// Zod validation schemas for all endpoints
export const DocumentSchemas = {
  create: z.object({
    title: z.string().min(1).max(255),
    content: z.string(),
    tags: z.array(z.string()).optional(),
    visibility: z.enum(['PUBLIC', 'PRIVATE', 'TEAM']),
  }),
  
  update: z.object({
    title: z.string().min(1).max(255).optional(),
    content: z.string().optional(),
    tags: z.array(z.string()).optional(),
  }),
  
  query: z.object({
    search: z.string().optional(),
    tags: z.array(z.string()).optional(),
    visibility: z.enum(['PUBLIC', 'PRIVATE', 'TEAM']).optional(),
    limit: z.number().min(1).max(1000).default(50),
    offset: z.number().min(0).default(0),
  })
};
```

### 5.2 Error Handling Standards

#### 5.2.1 Error Classification
```typescript
export enum APIErrorCode {
  // Authentication/Authorization
  UNAUTHORIZED = 'UNAUTHORIZED',
  FORBIDDEN = 'FORBIDDEN',
  TENANT_ACCESS_DENIED = 'TENANT_ACCESS_DENIED',
  
  // Validation
  INVALID_INPUT = 'INVALID_INPUT',
  RESOURCE_NOT_FOUND = 'RESOURCE_NOT_FOUND',
  
  // Business Logic
  DUPLICATE_RESOURCE = 'DUPLICATE_RESOURCE',
  BUSINESS_RULE_VIOLATION = 'BUSINESS_RULE_VIOLATION',
  
  // Performance
  REQUEST_TIMEOUT = 'REQUEST_TIMEOUT',
  RATE_LIMIT_EXCEEDED = 'RATE_LIMIT_EXCEEDED',
  
  // System
  DATABASE_ERROR = 'DATABASE_ERROR',
  EXTERNAL_SERVICE_ERROR = 'EXTERNAL_SERVICE_ERROR',
  INTERNAL_SERVER_ERROR = 'INTERNAL_SERVER_ERROR',
}
```

#### 5.2.2 Error Response Handler
```typescript
export const handleAPIError = (error: unknown): NextResponse => {
  const requestId = generateRequestId();
  const timestamp = new Date().toISOString();
  
  // Log error for monitoring
  console.error('API Error:', { error, requestId, timestamp });
  
  if (error instanceof z.ZodError) {
    return NextResponse.json({
      success: false,
      error: {
        code: APIErrorCode.INVALID_INPUT,
        message: 'Invalid input data',
        details: error.errors,
        timestamp
      },
      metadata: { requestId, timestamp, duration: 0 }
    }, { status: 400 });
  }
  
  if (error instanceof TenantAccessError) {
    return NextResponse.json({
      success: false,
      error: {
        code: APIErrorCode.TENANT_ACCESS_DENIED,
        message: 'Access denied to tenant resource',
        timestamp
      },
      metadata: { requestId, timestamp, duration: 0 }
    }, { status: 403 });
  }
  
  // Default internal server error
  return NextResponse.json({
    success: false,
    error: {
      code: APIErrorCode.INTERNAL_SERVER_ERROR,
      message: 'Internal server error',
      timestamp
    },
    metadata: { requestId, timestamp, duration: 0 }
  }, { status: 500 });
};
```

---

## 6. Security Architecture

### 6.1 Authentication & Authorization Patterns

#### 6.1.1 User Authentication
```typescript
// JWT-based authentication with Next.js
export interface UserSession {
  userId: string;
  email: string;
  defaultTenantId?: string;
  permissions: UserPermission[];
  expiresAt: Date;
}

export const validateAuth = async (request: Request): Promise<UserSession> => {
  const token = extractAuthToken(request);
  
  if (!token) {
    throw new Error('No authentication token provided');
  }
  
  try {
    const payload = jwt.verify(token, process.env.JWT_SECRET!) as JWTPayload;
    
    // Validate user still exists and is active
    const user = await prisma.user.findUnique({
      where: { id: payload.userId },
      include: { preferences: true }
    });
    
    if (!user) {
      throw new Error('User not found');
    }
    
    return {
      userId: user.id,
      email: user.email,
      defaultTenantId: user.preferences?.defaultTenantId,
      permissions: await getUserPermissions(user.id),
      expiresAt: new Date(payload.exp * 1000)
    };
  } catch (error) {
    throw new Error('Invalid authentication token');
  }
};
```

#### 6.1.2 Resource Access Control
```typescript
// Multi-layer resource access validation
export const validateResourceAccess = async (
  userId: string,
  resourceId: string,
  action: string
): Promise<Resource> => {
  const resource = await prisma.resource.findFirst({
    where: {
      id: resourceId,
      OR: [
        { ownerId: userId },
        { 
          permissions: {
            some: {
              userId: userId,
              action: action
            }
          }
        }
      ]
    }
  });
  
  if (!resource) {
    throw new ResourceAccessError(`Access denied to resource ${resourceId}`);
  }
  
  return resource;
};

// Audit trail for security-sensitive operations
export const auditSecurityEvent = async (
  userId: string,
  resourceId: string,
  action: SecurityAction,
  details?: Record<string, unknown>
) => {
  await prisma.auditLog.create({
    data: {
      userId,
      resourceId,
      action,
      details: details || {},
      ipAddress: await getCurrentIPAddress(),
      userAgent: await getCurrentUserAgent(),
      timestamp: new Date()
    }
  });
};
```

### 6.2 Data Protection Patterns

#### 6.2.1 Sensitive Data Encryption
```typescript
// Encrypt sensitive data at rest
export class DataEncryption {
  private static readonly ALGORITHM = 'aes-256-gcm';
  private static readonly KEY = process.env.ENCRYPTION_KEY!;
  
  static encrypt(data: string): EncryptedData {
    const iv = crypto.randomBytes(16);
    const cipher = crypto.createCipher(this.ALGORITHM, this.KEY);
    cipher.setAAD(Buffer.from('application-data'));
    
    let encrypted = cipher.update(data, 'utf8', 'hex');
    encrypted += cipher.final('hex');
    
    const authTag = cipher.getAuthTag();
    
    return {
      encrypted,
      iv: iv.toString('hex'),
      authTag: authTag.toString('hex')
    };
  }
  
  static decrypt(encryptedData: EncryptedData): string {
    const decipher = crypto.createDecipher(this.ALGORITHM, this.KEY);
    decipher.setAAD(Buffer.from('application-data'));
    decipher.setAuthTag(Buffer.from(encryptedData.authTag, 'hex'));
    
    let decrypted = decipher.update(encryptedData.encrypted, 'hex', 'utf8');
    decrypted += decipher.final('utf8');
    
    return decrypted;
  }
}

// Use encryption for sensitive fields
export const encryptSensitiveData = (data: string): string => {
  const encrypted = DataEncryption.encrypt(data);
  return JSON.stringify(encrypted);
};
```

#### 6.2.2 Input Sanitization
```typescript
// Comprehensive input sanitization
export const sanitizeInput = {
  text: (text: unknown): string => {
    if (typeof text !== 'string') {
      throw new Error('Text input must be a string');
    }
    // Sanitize HTML and limit length
    return text
      .replace(/<[^>]*>/g, '') // Remove HTML tags
      .substring(0, 1000)       // Limit length
      .trim();
  },
  
  email: (email: unknown): string => {
    if (typeof email !== 'string') {
      throw new Error('Email must be a string');
    }
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
      throw new Error('Invalid email format');
    }
    return email.toLowerCase().trim();
  },
  
  id: (id: unknown): string => {
    if (typeof id !== 'string') {
      throw new Error('ID must be a string');
    }
    // Validate CUID format
    const cuidRegex = /^c[a-z0-9]{24}$/;
    if (!cuidRegex.test(id)) {
      throw new Error('Invalid ID format');
    }
    return id;
  }
};
```

---

## 7. Performance Standards

### 7.1 Response Time Targets

#### 7.1.1 Performance Metrics
```typescript
export const PERFORMANCE_TARGETS = {
  // API response times (95th percentile)
  SIMPLE_QUERY: 100,        // Simple database queries
  COMPLEX_QUERY: 300,       // Joins, aggregations
  DOCUMENT_CREATE: 200,     // Creating new documents
  SEARCH_OPERATION: 500,    // Search operations
  REPORT_GENERATION: 2000,  // Report generation
  
  // Frontend performance
  PAGE_LOAD: 2000,          // Initial page load
  NAVIGATION: 200,          // Client-side navigation
  LIST_RENDER: 100,         // Rendering 100+ items
  SEARCH_RESULTS: 300,      // Search result display
  
  // Database performance
  SIMPLE_SELECT: 50,        // Single table queries
  COMPLEX_JOIN: 150,        // Multi-table joins
  AGGREGATION: 200,         // GROUP BY, SUM, etc.
  
  // External integrations
  EXTERNAL_API: 5000,       // External API calls
  FILE_UPLOAD: 10000,       // File upload operations
} as const;
```

#### 7.1.2 Performance Monitoring
```typescript
// Comprehensive performance monitoring
export class PerformanceMonitor {
  static async measureAPICall<T>(
    operation: string,
    fn: () => Promise<T>
  ): Promise<T> {
    const start = performance.now();
    const startMemory = process.memoryUsage();
    
    try {
      const result = await fn();
      const duration = performance.now() - start;
      const endMemory = process.memoryUsage();
      
      // Log performance metrics
      console.log(`Performance: ${operation}`, {
        duration,
        memoryDelta: endMemory.heapUsed - startMemory.heapUsed,
        target: this.getTarget(operation),
        status: duration < this.getTarget(operation) ? 'PASS' : 'FAIL'
      });
      
      // Alert on performance issues
      if (duration > this.getTarget(operation)) {
        await this.alertSlowOperation(operation, duration);
      }
      
      return result;
    } catch (error) {
      const duration = performance.now() - start;
      console.error(`Performance: ${operation} FAILED`, { duration, error });
      throw error;
    }
  }
  
  private static getTarget(operation: string): number {
    // Map operation names to performance targets
    if (operation.includes('query')) return PERFORMANCE_TARGETS.COMPLEX_QUERY;
    if (operation.includes('create')) return PERFORMANCE_TARGETS.DOCUMENT_CREATE;
    if (operation.includes('search')) return PERFORMANCE_TARGETS.SEARCH_OPERATION;
    return PERFORMANCE_TARGETS.SIMPLE_QUERY;
  }
}
```

### 7.2 Optimization Patterns

#### 7.2.1 Database Optimization
```typescript
// Optimized database patterns
export const DatabaseOptimizations = {
  // Use database indexes for common queries
  ensureIndexes: async () => {
    // These should be in Prisma schema, but documented here
    const indexes = [
      'CREATE INDEX IF NOT EXISTS idx_documents_tenant_created ON documents(tenant_id, created_at DESC)',
      'CREATE INDEX IF NOT EXISTS idx_documents_user_tenant ON documents(user_id, tenant_id)',
      'CREATE INDEX IF NOT EXISTS idx_documents_status ON documents(status)',
      'CREATE INDEX IF NOT EXISTS idx_users_email ON users(email)',
      'CREATE INDEX IF NOT EXISTS idx_permissions_user ON permissions(user_id)',
    ];
    
    // Execute index creation
    for (const index of indexes) {
      await prisma.$executeRawUnsafe(index);
    }
  },
  
  // Connection pooling for high performance
  connectionPool: {
    max: 20,                    // Maximum connections
    min: 5,                     // Minimum connections
    acquireTimeoutMillis: 30000, // 30 second timeout
    idleTimeoutMillis: 300000,   // 5 minute idle timeout
  },
  
  // Query optimization patterns
  batchQueries: async <T>(
    queries: (() => Promise<T>)[]
  ): Promise<T[]> => {
    // Execute queries in batches to avoid overwhelming database
    const batchSize = 5;
    const results: T[] = [];
    
    for (let i = 0; i < queries.length; i += batchSize) {
      const batch = queries.slice(i, i + batchSize);
      const batchResults = await Promise.all(
        batch.map(query => query())
      );
      results.push(...batchResults);
    }
    
    return results;
  }
};
```

#### 7.2.2 Caching Strategies
```typescript
// Multi-layer caching
export class ApplicationCache {
  private static redis = new Redis(process.env.REDIS_URL!);
  
  // Cache frequently accessed data (5 minute TTL)
  static async getUserData(userId: string): Promise<UserData> {
    const cacheKey = `user:${userId}`;
    const cached = await this.redis.get(cacheKey);
    
    if (cached) {
      return JSON.parse(cached);
    }
    
    const userData = await prisma.user.findUnique({
      where: { id: userId },
      include: {
        preferences: true,
        permissions: true
      }
    });
    
    await this.redis.setex(cacheKey, 300, JSON.stringify(userData));
    return userData;
  }
  
  // Cache computed results (1 hour TTL)
  static async getAnalytics(
    tenantId: string,
    period: 'day' | 'week' | 'month'
  ): Promise<AnalyticsData> {
    const cacheKey = `analytics:${tenantId}:${period}`;
    const cached = await this.redis.get(cacheKey);
    
    if (cached) {
      return JSON.parse(cached);
    }
    
    const analytics = await calculateAnalytics(tenantId, period);
    await this.redis.setex(cacheKey, 3600, JSON.stringify(analytics));
    
    return analytics;
  }
  
  // Invalidate related caches on data changes
  static async invalidateTenantCache(tenantId: string): Promise<void> {
    const pattern = `*:${tenantId}*`;
    const keys = await this.redis.keys(pattern);
    
    if (keys.length > 0) {
      await this.redis.del(...keys);
    }
  }
}
```

---

## 8. Integration Patterns

### 8.1 External Service Integration

#### 8.1.1 API Integration Pattern
```typescript
// Standardized external API integration
export interface ExternalAPIProvider {
  name: string;
  authenticate(): Promise<AuthToken>;
  request<T>(endpoint: string, options?: RequestOptions): Promise<T>;
  handleError(error: unknown): never;
}

export class ExternalServiceProvider implements ExternalAPIProvider {
  name = 'ExternalService';
  
  async authenticate(): Promise<AuthToken> {
    const response = await fetch(`${this.baseUrl}/auth`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${process.env.EXTERNAL_API_KEY}`
      }
    });
    
    if (!response.ok) {
      throw new Error(`Authentication failed: ${response.statusText}`);
    }
    
    const { token, expiresAt } = await response.json();
    return { token, expiresAt: new Date(expiresAt) };
  }
  
  async request<T>(
    endpoint: string,
    options: RequestOptions = {}
  ): Promise<T> {
    const authToken = await this.authenticate();
    
    const response = await fetch(`${this.baseUrl}${endpoint}`, {
      ...options,
      headers: {
        'Authorization': `Bearer ${authToken.token}`,
        'Content-Type': 'application/json',
        ...options.headers
      }
    });
    
    if (!response.ok) {
      this.handleError(new Error(`API request failed: ${response.statusText}`));
    }
    
    return response.json();
  }
  
  handleError(error: unknown): never {
    console.error(`${this.name} error:`, error);
    throw new ExternalServiceError(`${this.name} service unavailable`);
  }
}
```

### 8.2 Data Synchronization Patterns

#### 8.2.1 Import Pipeline
```typescript
// Robust data import pipeline with error handling
export class DataImportPipeline {
  async importData(
    userId: string,
    tenantId: string,
    data: ImportData
  ): Promise<ImportResult> {
    const batchId = generateId();
    
    return withTransaction(async (tx) => {
      try {
        // 1. Create import batch record
        const batch = await tx.importBatch.create({
          data: {
            id: batchId,
            userId,
            tenantId,
            source: data.source,
            totalRecords: data.records.length,
            status: 'PROCESSING'
          }
        });
        
        // 2. Process records in batches
        const results = await this.processBatch(tx, userId, tenantId, data.records, batchId);
        
        // 3. Update final status
        await tx.importBatch.update({
          where: { id: batchId },
          data: {
            status: results.failedRecords > 0 ? 'PARTIAL_SUCCESS' : 'COMPLETED',
            successfulRecords: results.successfulRecords,
            failedRecords: results.failedRecords,
            errorLog: results.errors.length > 0 ? JSON.stringify(results.errors) : null
          }
        });
        
        return {
          batchId,
          totalRecords: data.records.length,
          successfulRecords: results.successfulRecords,
          failedRecords: results.failedRecords,
          errors: results.errors
        };
        
      } catch (error) {
        // Mark batch as failed
        await tx.importBatch.update({
          where: { id: batchId },
          data: {
            status: 'FAILED',
            errorLog: error instanceof Error ? error.message : 'Unknown error'
          }
        });
        
        throw error;
      }
    });
  }
  
  private async processBatch(
    tx: PrismaTransactionClient,
    userId: string,
    tenantId: string,
    records: ImportRecord[],
    batchId: string
  ): Promise<BatchProcessResult> {
    let successfulRecords = 0;
    let failedRecords = 0;
    const errors: ImportError[] = [];
    
    for (const record of records) {
      try {
        // Validate and transform record
        const validatedRecord = await this.validateRecord(record, userId, tenantId);
        
        // Check for duplicates
        const existing = await tx.document.findFirst({
          where: {
            externalId: record.externalId,
            tenantId: tenantId
          }
        });
        
        if (!existing) {
          // Create new record
          await tx.document.create({
            data: {
              ...validatedRecord,
              importBatchId: batchId,
              externalId: record.externalId
            }
          });
          
          successfulRecords++;
        } else {
          // Update existing record if data has changed
          if (this.hasChanged(existing, validatedRecord)) {
            await tx.document.update({
              where: { id: existing.id },
              data: validatedRecord
            });
          }
          successfulRecords++;
        }
        
      } catch (error) {
        failedRecords++;
        errors.push({
          record,
          error: error instanceof Error ? error.message : 'Unknown error'
        });
      }
    }
    
    return { successfulRecords, failedRecords, errors };
  }
}
```

---

## 9. Deployment Architecture

### 9.1 Cloud Platform Optimization

#### 9.1.1 Environment Configuration
```typescript
// Environment-specific configuration
export const environmentConfig = {
  development: {
    database: {
      maxConnections: 5,
      queryTimeout: 10000,
      statementTimeout: 30000,
    },
    cache: {
      enabled: false,
      ttl: 60
    },
    logging: {
      level: 'debug',
      queries: true
    }
  },
  
  production: {
    database: {
      maxConnections: 20,
      queryTimeout: 5000,
      statementTimeout: 15000,
    },
    cache: {
      enabled: true,
      ttl: 300
    },
    logging: {
      level: 'error',
      queries: false
    }
  }
} as const;

// Runtime configuration based on environment
export const getCurrentConfig = () => {
  const env = process.env.NODE_ENV;
  return environmentConfig[env as keyof typeof environmentConfig] || environmentConfig.development;
};
```

#### 9.1.2 Connection Management
```typescript
// Optimized database connection management for serverless
export class DatabaseConnectionManager {
  private static instance: PrismaClient;
  
  static getInstance(): PrismaClient {
    if (!this.instance) {
      const config = getCurrentConfig();
      
      this.instance = new PrismaClient({
        datasources: {
          db: {
            url: process.env.DATABASE_URL
          }
        },
        log: config.logging.queries ? ['query', 'info', 'warn', 'error'] : ['error']
      });
      
      // Connection event handlers
      this.instance.$on('beforeExit', async () => {
        console.log('Database connection closing');
      });
    }
    
    return this.instance;
  }
  
  // Graceful shutdown for serverless environments
  static async disconnect(): Promise<void> {
    if (this.instance) {
      await this.instance.$disconnect();
      this.instance = null as any;
    }
  }
}

// Middleware for connection management
export const withDatabaseConnection = <T>(
  handler: (prisma: PrismaClient) => Promise<T>
): Promise<T> => {
  const prisma = DatabaseConnectionManager.getInstance();
  return handler(prisma);
};
```

### 9.2 Monitoring and Observability

#### 9.2.1 Application Monitoring
```typescript
// Comprehensive monitoring
export class ApplicationMonitor {
  static async trackOperation(
    operation: string,
    userId: string,
    tenantId: string,
    metadata?: Record<string, unknown>
  ): Promise<void> {
    const event = {
      timestamp: new Date(),
      operation,
      userId,
      tenantId,
      metadata,
      environment: process.env.NODE_ENV,
      version: process.env.npm_package_version
    };
    
    // Log to structured logging service
    console.log('Application Operation:', JSON.stringify(event));
    
    // Send to monitoring service
    if (process.env.MONITORING_API_KEY) {
      await this.sendToMonitoring(event);
    }
  }
  
  static async trackError(
    error: Error,
    context: {
      operation: string;
      userId?: string;
      tenantId?: string;
      request?: any;
    }
  ): Promise<void> {
    const errorEvent = {
      timestamp: new Date(),
      error: {
        name: error.name,
        message: error.message,
        stack: error.stack
      },
      context,
      environment: process.env.NODE_ENV
    };
    
    console.error('Application Error:', JSON.stringify(errorEvent));
    
    // Send to error tracking service
    if (process.env.ERROR_TRACKING_API_KEY) {
      await this.sendToErrorTracking(errorEvent);
    }
  }
}
```

#### 9.2.2 Health Checks
```typescript
// Comprehensive health check endpoint
export async function healthCheck(): Promise<HealthStatus> {
  const checks: HealthCheck[] = [];
  
  // Database connectivity
  try {
    await prisma.$queryRaw`SELECT 1`;
    checks.push({
      name: 'database',
      status: 'healthy',
      details: 'Database connected successfully'
    });
  } catch (error) {
    checks.push({
      name: 'database',
      status: 'unhealthy',
      details: `Database connection failed: ${error}`
    });
  }
  
  // External service connectivity
  try {
    const response = await fetch(process.env.EXTERNAL_SERVICE_URL + '/health', {
      timeout: 5000
    });
    checks.push({
      name: 'external_service',
      status: response.ok ? 'healthy' : 'degraded',
      details: `External service responded with ${response.status}`
    });
  } catch (error) {
    checks.push({
      name: 'external_service',
      status: 'unhealthy',
      details: `External service unreachable: ${error}`
    });
  }
  
  // Cache connectivity
  if (process.env.REDIS_URL) {
    try {
      await redis.ping();
      checks.push({
        name: 'cache',
        status: 'healthy',
        details: 'Cache responding normally'
      });
    } catch (error) {
      checks.push({
        name: 'cache',
        status: 'unhealthy',
        details: `Cache connection failed: ${error}`
      });
    }
  }
  
  const overallStatus = checks.every(c => c.status === 'healthy') 
    ? 'healthy' 
    : checks.some(c => c.status === 'unhealthy') 
      ? 'unhealthy' 
      : 'degraded';
  
  return {
    status: overallStatus,
    timestamp: new Date(),
    version: process.env.npm_package_version,
    environment: process.env.NODE_ENV,
    checks
  };
}
```

---

## 10. Implementation Guidelines

### 10.1 Development Workflow Integration

#### 10.1.1 Claude Agent Instructions
```typescript
// Instructions for Claude agents implementing features
export const CLAUDE_IMPLEMENTATION_GUIDE = {
  // Always start with these patterns
  requiredImports: [
    "import { prisma } from '@/lib/database';",
    "import { validateAuth, validateResourceAccess } from '@/lib/auth';",
    "import { handleAPIError } from '@/lib/errors';",
    "import { z } from 'zod';",
    "import { NextRequest, NextResponse } from 'next/server';"
  ],
  
  // Standard API route structure
  apiRouteTemplate: `
    export async function POST(request: NextRequest) {
      try {
        // 1. Authentication
        const { userId } = await validateAuth(request);
        
        // 2. Input validation
        const body = await request.json();
        const validated = YourSchema.parse(body);
        
        // 3. Resource access validation
        await validateResourceAccess(userId, validated.resourceId);
        
        // 4. Business logic
        const result = await yourService.performOperation(userId, validated);
        
        // 5. Response
        return NextResponse.json({ success: true, data: result });
        
      } catch (error) {
        return handleAPIError(error);
      }
    }
  `,
  
  // Required testing patterns
  testingRequirements: [
    "Write tests before implementation (TDD)",
    "Test authentication and authorization",
    "Test input validation with Zod schemas",
    "Test error conditions",
    "Test performance with large datasets",
    "Test access controls"
  ],
  
  // Performance requirements
  performanceChecklist: [
    "Add performance monitoring to all operations",
    "Use database indexes for query optimization",
    "Implement caching for frequently accessed data",
    "Use pagination for large result sets",
    "Test with 10K+ records",
    "Ensure <500ms response times"
  ]
};
```

### 10.2 Quality Assurance

#### 10.2.1 Code Review Checklist
```typescript
export const CODE_REVIEW_CHECKLIST = {
  architecture: [
    "Follows domain-scoped patterns",
    "Uses proper TypeScript types",
    "Implements error handling",
    "Includes performance monitoring",
    "Follows security patterns"
  ],
  
  performance: [
    "Database queries are optimized",
    "Caching is implemented where appropriate",
    "Large result sets use pagination",
    "Response times meet targets",
    "Memory usage is reasonable"
  ],
  
  security: [
    "Authentication is validated",
    "Resource access is checked",
    "Input is sanitized and validated",
    "Sensitive data is protected",
    "Audit trails are implemented"
  ],
  
  testing: [
    "Tests cover all code paths",
    "Error conditions are tested",
    "Performance tests are included",
    "Test coverage >90%",
    "Tests are maintainable"
  ]
};
```

---

## 11. Version Control & Updates

### 11.1 Standards Evolution

This document follows semantic versioning:
- **Major** (X.0.0): Breaking changes to existing standards
- **Minor** (0.X.0): New standards or patterns added  
- **Patch** (0.0.X): Clarifications or minor adjustments

### 11.2 Implementation Timeline

- **Immediate**: Apply to all new development
- **1 month**: Update existing components to follow standards
- **3 months**: Full compliance across all domains

### 11.3 Governance

- Standards updates require review and approval
- Regular review every 3 months
- Performance metrics evaluation monthly
- Security audit quarterly

---

**Document Version:** 1.0  
**Last Updated:** January 6, 2025  
**Next Review:** April 6, 2025  
**Maintained By:** Bray.Doc & Development Teams