# Data Handling Guidelines

## JSON File Storage

Bray.Doc's projects often use JSON files for local data storage. Follow these patterns:

### File Structure
```javascript
// ABOUTME: Standard JSON data file structure
// Consistent format across all JSON storage
{
  "version": "1.0.0",
  "lastModified": "2024-01-15T10:30:00Z",
  "data": [
    // Actual data array/object
  ],
  "metadata": {
    "count": 100,
    "source": "manual_entry|import|api"
  }
}
```

### Safe File Operations
```javascript
// ABOUTME: Safe JSON file read/write pattern
// Always backup before writing
const fs = require('fs').promises;
const path = require('path');

class JSONFileManager {
  constructor(filePath) {
    this.filePath = filePath;
    this.backupDir = path.join(path.dirname(filePath), 'backups');
  }

  async read() {
    try {
      const data = await fs.readFile(this.filePath, 'utf8');
      return JSON.parse(data);
    } catch (error) {
      if (error.code === 'ENOENT') {
        return this.getDefaultStructure();
      }
      throw error;
    }
  }

  async write(data) {
    // Create backup first
    await this.backup();
    
    // Write with pretty formatting
    const jsonString = JSON.stringify(data, null, 2);
    await fs.writeFile(this.filePath, jsonString, 'utf8');
  }

  async backup() {
    await fs.mkdir(this.backupDir, { recursive: true });
    const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
    const backupPath = path.join(this.backupDir, `backup-${timestamp}.json`);
    await fs.copyFile(this.filePath, backupPath);
  }
}
```

### Python Equivalent
```python
import json
import shutil
from pathlib import Path
from datetime import datetime
from typing import Any, Dict

class JSONFileManager:
    """Manage JSON file operations with automatic backups."""
    
    def __init__(self, file_path: Path):
        self.file_path = Path(file_path)
        self.backup_dir = self.file_path.parent / "backups"
        
    def read(self) -> Dict[str, Any]:
        """Read JSON file with error handling."""
        if not self.file_path.exists():
            return self.get_default_structure()
            
        with open(self.file_path, 'r') as f:
            return json.load(f)
    
    def write(self, data: Dict[str, Any]) -> None:
        """Write JSON file with backup."""
        self.backup()
        
        with open(self.file_path, 'w') as f:
            json.dump(data, f, indent=2, ensure_ascii=False)
    
    def backup(self) -> None:
        """Create timestamped backup."""
        self.backup_dir.mkdir(exist_ok=True)
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        backup_path = self.backup_dir / f"backup_{timestamp}.json"
        shutil.copy2(self.file_path, backup_path)
```

## Database Patterns

### MongoDB (Document Store)
```python
# ABOUTME: MongoDB connection and model pattern
# Consistent document structure with validation
from pymongo import MongoClient
from pydantic import BaseModel, Field
from datetime import datetime
from typing import Optional

class MongoConnection:
    def __init__(self, connection_string: str):
        self.client = MongoClient(connection_string)
        self.db = self.client.get_default_database()
    
    def __enter__(self):
        return self
    
    def __exit__(self, exc_type, exc_val, exc_tb):
        self.client.close()

class BaseDocument(BaseModel):
    """Base document model with common fields."""
    id: Optional[str] = Field(None, alias="_id")
    created_at: datetime = Field(default_factory=datetime.utcnow)
    updated_at: datetime = Field(default_factory=datetime.utcnow)
    version: int = 1
    
    class Config:
        populate_by_name = True

# Usage example
class User(BaseDocument):
    name: str
    email: str
    active: bool = True

async def save_user(user: User, db):
    """Save user with automatic timestamp update."""
    user.updated_at = datetime.utcnow()
    result = await db.users.insert_one(user.dict(by_alias=True))
    return str(result.inserted_id)
```

### PostgreSQL (Relational)
```python
# ABOUTME: PostgreSQL pattern with SQLAlchemy
# Type-safe ORM approach
from sqlalchemy import create_engine, Column, String, DateTime, Boolean
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from datetime import datetime

Base = declarative_base()

class TimestampMixin:
    """Mixin for automatic timestamps."""
    created_at = Column(DateTime, default=datetime.utcnow, nullable=False)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow, nullable=False)

class User(Base, TimestampMixin):
    __tablename__ = 'users'
    
    id = Column(String, primary_key=True)
    name = Column(String, nullable=False)
    email = Column(String, unique=True, nullable=False)
    active = Column(Boolean, default=True)

# Connection management
class DatabaseConnection:
    def __init__(self, connection_string: str):
        self.engine = create_engine(connection_string, pool_pre_ping=True)
        self.SessionLocal = sessionmaker(bind=self.engine)
    
    def get_session(self):
        return self.SessionLocal()
```

## Data Validation

### Pydantic Models (Python)
```python
# ABOUTME: Data validation with Pydantic
# Ensure data integrity at boundaries
from pydantic import BaseModel, validator, EmailStr
from typing import List, Optional
from datetime import datetime

class ContactData(BaseModel):
    name: str
    email: EmailStr
    phone: Optional[str] = None
    tags: List[str] = []
    
    @validator('name')
    def name_must_not_be_empty(cls, v):
        if not v.strip():
            raise ValueError('Name cannot be empty')
        return v.strip()
    
    @validator('tags')
    def lowercase_tags(cls, v):
        return [tag.lower() for tag in v]
```

### JSON Schema (JavaScript)
```javascript
// ABOUTME: JSON Schema validation
// Validate data at API boundaries
const Ajv = require('ajv');
const ajv = new Ajv();

const contactSchema = {
  type: 'object',
  properties: {
    name: { type: 'string', minLength: 1 },
    email: { type: 'string', format: 'email' },
    phone: { type: 'string', pattern: '^[0-9-+()\\s]+$' },
    tags: {
      type: 'array',
      items: { type: 'string' }
    }
  },
  required: ['name', 'email'],
  additionalProperties: false
};

const validateContact = ajv.compile(contactSchema);

function validateData(data) {
  const valid = validateContact(data);
  if (!valid) {
    throw new ValidationError(validateContact.errors);
  }
  return data;
}
```

## Data Migration

### Version Management
```python
# ABOUTME: Data migration pattern
# Handle schema evolution gracefully
class DataMigrator:
    def __init__(self, current_version: str):
        self.current_version = current_version
        self.migrations = {
            "1.0.0": self.migrate_1_0_0_to_1_1_0,
            "1.1.0": self.migrate_1_1_0_to_1_2_0,
        }
    
    def migrate(self, data: dict) -> dict:
        """Apply all necessary migrations."""
        data_version = data.get("version", "1.0.0")
        
        while data_version != self.current_version:
            if data_version not in self.migrations:
                raise ValueError(f"No migration path from {data_version}")
            
            migration_func = self.migrations[data_version]
            data = migration_func(data)
            data_version = data["version"]
        
        return data
    
    def migrate_1_0_0_to_1_1_0(self, data: dict) -> dict:
        """Example migration adding new field."""
        data["version"] = "1.1.0"
        for item in data.get("data", []):
            item.setdefault("newField", "default_value")
        return data
```

## Data Security

### Encryption at Rest
```python
# ABOUTME: Encrypt sensitive data
# Use Fernet for symmetric encryption
from cryptography.fernet import Fernet
import json
import base64

class EncryptedJSONStorage:
    def __init__(self, key: bytes):
        self.cipher = Fernet(key)
    
    def save(self, data: dict, filepath: str):
        """Save encrypted JSON data."""
        json_bytes = json.dumps(data).encode('utf-8')
        encrypted = self.cipher.encrypt(json_bytes)
        
        with open(filepath, 'wb') as f:
            f.write(encrypted)
    
    def load(self, filepath: str) -> dict:
        """Load and decrypt JSON data."""
        with open(filepath, 'rb') as f:
            encrypted = f.read()
        
        decrypted = self.cipher.decrypt(encrypted)
        return json.loads(decrypted.decode('utf-8'))

# Generate and store key securely
def generate_key():
    return Fernet.generate_key()
```

### Sensitive Data Handling
```javascript
// ABOUTME: Handle sensitive data
// Never log or expose sensitive information
class SensitiveDataHandler {
  constructor(fields = ['password', 'token', 'apiKey', 'secret']) {
    this.sensitiveFields = fields;
  }

  sanitize(obj) {
    const sanitized = { ...obj };
    
    for (const field of this.sensitiveFields) {
      if (field in sanitized) {
        sanitized[field] = '[REDACTED]';
      }
    }
    
    return sanitized;
  }

  logSafe(message, data) {
    console.log(message, this.sanitize(data));
  }
}
```

## Batch Operations

### Bulk Processing
```python
# ABOUTME: Process data in batches
# Prevent memory issues with large datasets
from typing import Iterator, List, TypeVar
from itertools import islice

T = TypeVar('T')

def batch_processor(items: Iterator[T], batch_size: int = 100) -> Iterator[List[T]]:
    """Process items in batches."""
    iterator = iter(items)
    while batch := list(islice(iterator, batch_size)):
        yield batch

# Usage
async def process_large_dataset(items):
    for batch in batch_processor(items, batch_size=50):
        await process_batch(batch)
        # Add small delay to prevent overload
        await asyncio.sleep(0.1)
```

## Data Import/Export

### CSV Handling
```python
# ABOUTME: CSV import/export patterns
# Handle various CSV formats gracefully
import csv
from pathlib import Path
from typing import List, Dict

class CSVHandler:
    @staticmethod
    def read_csv(filepath: Path, encoding='utf-8-sig') -> List[Dict]:
        """Read CSV with automatic encoding detection."""
        with open(filepath, 'r', encoding=encoding) as f:
            # Detect delimiter
            sample = f.read(1024)
            f.seek(0)
            sniffer = csv.Sniffer()
            delimiter = sniffer.sniff(sample).delimiter
            
            reader = csv.DictReader(f, delimiter=delimiter)
            return list(reader)
    
    @staticmethod
    def write_csv(filepath: Path, data: List[Dict], fieldnames=None):
        """Write CSV with consistent formatting."""
        if not data:
            return
            
        fieldnames = fieldnames or data[0].keys()
        
        with open(filepath, 'w', newline='', encoding='utf-8') as f:
            writer = csv.DictWriter(f, fieldnames=fieldnames)
            writer.writeheader()
            writer.writerows(data)
```

## Caching Strategies

### In-Memory Cache
```python
# ABOUTME: Simple caching implementation
# Reduce redundant data operations
from functools import lru_cache
from datetime import datetime, timedelta
import hashlib

class CacheManager:
    def __init__(self, ttl_seconds=300):
        self.cache = {}
        self.ttl = timedelta(seconds=ttl_seconds)
    
    def get_key(self, *args, **kwargs):
        """Generate cache key from arguments."""
        key_str = f"{args}{sorted(kwargs.items())}"
        return hashlib.md5(key_str.encode()).hexdigest()
    
    def get(self, key):
        """Get cached value if not expired."""
        if key in self.cache:
            value, timestamp = self.cache[key]
            if datetime.now() - timestamp < self.ttl:
                return value
            del self.cache[key]
        return None
    
    def set(self, key, value):
        """Set cache value with timestamp."""
        self.cache[key] = (value, datetime.now())
```