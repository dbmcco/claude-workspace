# Extracted Content from app_drug_match

**Original Path:** /Users/braydon/projects/work/app_drug_match
**Extraction Date:** Tue May 27 09:40:51 EDT 2025

---

# Drug Match - Project Memory

This file serves as Claude's project memory. It provides essential context about the project, current status, and guidance for development.

**Last Session**: Implemented FDA vector store initialization script and RAG integration plan based on academic paper methodology. Started transitioning FDA data processing from pattern-based extraction to vector-based RAG approach. See [IMPLEMENTATION_STATUS.md](./IMPLEMENTATION_STATUS.md) for detailed current state.

## Project Overview

**Purpose:** A system that matches FDA approved drugs to potential candidates for prescribing using EHR data, developed in collaboration with Mass General Brigham.

**Status:** 30% complete - Core data models, JSON adapter, FDA integration, EHR data analysis

**Type:** Application with API components

## Current Status

**Last Updated:** 2025-04-26

**Recent Accomplishments:**
- Created initial project structure
- Defined core architecture and components
- Implemented comprehensive data models for patients, drugs, and matches
- Developed JSON adapter with caching for development
- Created sample data files for testing
- Designed PostgreSQL schema for future migration
- Added FDA API adapter for drug data access
- Researched available data sources (OpenFDA, ClinicalTrials.gov)
- Enhanced drug model to map to FDA data structure
- Analyzed EHR data from SouthPark Centricity
- Documented EHR data mapping to application models
- Implemented CentricityJsonAdapter for EHR integration
- Created import utility script for Centricity patient data
- Updated development workflow to use functional chunking
- Reorganized build plan with functional units instead of time blocks
- Fixed FDA API connectivity issues with enhanced error handling
- Developed script inventory documentation
- Designed RAG implementation plan for FDA data processing based on academic paper

**Current Focus:**
- Setting up ChromaDB and running FDA vector store initialization (via `scripts/initialize-fda-vector-store.js`)
- Testing vector retrieval functionality (via `scripts/test-fda-vector-retrieval.js`)
- Implementing real embedding generation in `src/services/rag/llmService.js`
- Uncomment production code in `src/services/rag/chromaStore.js` for real ChromaDB connection
- Integrating RAG-enhanced drug matching with existing matching engine

**Next Steps:**
1. **Complete FDA Vector Store Implementation** (Priority)
   - Install ChromaDB: `npm install -g chromadb` or use Docker: `docker run -p 8000:8000 chromadb/chroma`
   - Run FDA vector store initialization: `node scripts/initialize-fda-vector-store.js`
   - Update embedding generation in `/src/services/rag/llmService.js` to use actual API calls instead of mock vectors
   - Connect to real vector store in `/src/services/rag/chromaStore.js` (uncomment production code)

2. **Enhance Existing RAG System**
   - Update query generation in `/src/services/rag/queryGenerator.js` for FDA-specific queries
   - Modify context assembly in `/src/services/rag/contextAssembler.js` to better handle FDA label sections
   - Implement LLM integration for drug matching in `/src/services/rag/index.js`
   - Create integration test in `/tests/unit/rag.test.js`

3. **Create API endpoints for Vector-based FDA data access**
   - Implement endpoints in `/src/api/rag.js`
   - Document API schema in `/docs/api_design_for_rag.md`

4. **Begin UI development**
   - Create simple demonstration UI for drug matching
   - Implement API client for connecting to RAG endpoints

5. **Enhance Centricity Integration**
   - Improve mapping of Centricity data to our patient model
   - Add more sophisticated clinical data extraction

## Technical Stack

- **Frontend:** To be determined (likely React/TypeScript)
- **Backend:** Node.js with Express
- **Database:** 
  - Document Storage: JSON files (development), PostgreSQL (future)
  - Vector Database: ChromaDB (collection: "fda-drug-information")
- **RAG Components:**
  - Vector Embeddings: Using OpenAI's ada-002 (1536 dimensions)
  - LLM Integration: OpenAI API with GPT-4
  - Vector Store: ChromaDB (see `/src/services/rag/chromaStore.js`)
- **External APIs:** 
  - OpenFDA: Using enhanced adapter (`/src/adapters/enhancedFdaAdapter.js`)
  - Potentially ClinicalTrials.gov
- **EHR Data:** SouthPark Centricity (JSON format, imported via `/scripts/import-centricity-patients.js`)
- **Deployment:** Local development for proof of concept

## Architecture

The application uses multiple architectural patterns:

1. **Adapter Pattern** 
   - Data access abstraction through `/src/adapters/dataAdapter.js`
   - Implementations for JSON (`/src/adapters/jsonAdapter.js`) and future PostgreSQL
   - External data adapters for FDA API (`/src/adapters/enhancedFdaAdapter.js`) and Centricity (`/src/adapters/centricityJsonAdapter.js`)

2. **RAG Architecture** (Per academic paper implementation)
   - Document Processing: Extract, segment, and preprocess FDA drug information
   - Vectorization: Create embeddings for drug information chunks
   - Semantic Retrieval: Query vector database based on patient context
   - Context Assembly: Combine relevant drug information sections
   - LLM-Enhanced Generation: Produce clinical reasoning with retrieved context

3. **Service Pattern**
   - Core matching logic in `/src/services/matchingService.js`
   - Drug class-specific handlers in `/src/services/drugClassHandlers/`
   - RAG services in `/src/services/rag/` directory

4. **API Layer**
   - RESTful endpoints in `/src/api/routes.js`
   - RAG-specific endpoints in `/src/api/rag.js`

The current implementation uses EHR data transformed and loaded via the import utility script (`/scripts/import-centricity-patients.js`). FDA data is accessed both through the API adapter and the new vector storage system.

## Key Files

### Core Application Files
- `src/adapters/dataAdapter.js` - Abstract interface for data storage
- `src/adapters/jsonAdapter.js` - JSON file implementation of data adapter
- `src/adapters/centricityJsonAdapter.js` - Centricity EHR data adapter
- `src/adapters/fdaAdapter.js` - Basic FDA API adapter for drug data
- `src/adapters/enhancedFdaAdapter.js` - Enhanced FDA API adapter with improved error handling
- `src/models/patient.js` - Patient data model with clinical information
- `src/models/drug.js` - Drug model with indications and contraindications
- `src/models/match.js` - Match model for patient-drug matching
- `src/api/routes.js` - API endpoint definitions
- `scripts/import-centricity-patients.js` - Utility to import Centricity patient data
- `scripts/test-fda-adapter.js` - Test script for FDA API connectivity

### Documentation
- `README.md` - Project overview and getting started guide
- `BUILD_PLAN.md` - Detailed implementation plan with functional chunks
- `docs/DEVELOPMENT_WORKFLOW.md` - Guide for development process using functional chunks
- `docs/CENTRICITY_INTEGRATION_PLAN.md` - Implementation plan for Centricity integration
- `docs/CENTRICITY_USAGE_GUIDE.md` - Guide for using Centricity data integration
- `docs/SCRIPT_INVENTORY.md` - Inventory of utility scripts with usage information
- `docs/postgresql-schema.md` - Schema design for PostgreSQL migration
- `docs/json-adapters.md` - Documentation for JSON adapter implementation
- `docs/data-sources.md` - Documentation of available data sources
- `docs/ehr-data-analysis.md` - Analysis of SouthPark Centricity EHR data
- `UPDATED_WORKFLOW.md` - Summary of workflow changes from time-based to functional chunks

### Data Files
- `data/sample-*.json` - Sample data files for development
- `data/fda-sample-response.json` - Sample FDA API response
- `data/centricity/*.json` - Centricity EHR data exports (to be provided)

## Database Strategy

- **Development:** Local JSON files with caching for rapid prototyping
- **Production:** PostgreSQL (future implementation with schema designed)
- **External Data:** OpenFDA API for drug information, SouthPark Centricity for EHR data
- **VPN Requirements:** No - local development environment

## Project-Specific Challenges

- **Data Quality:** Ensuring EHR data contains sufficient information for matching
- **Algorithm Refinement:** Balancing sensitivity and specificity in drug matches
- **Clinical Validation:** Ensuring matches are clinically appropriate
- **FDA Data Integration:** Moving from pattern-based extraction to RAG approach for FDA drug labeling
- **Vector Representation:** Effectively representing FDA drug information in vector space for semantic retrieval
- **Academic Paper Implementation:** Adhering to the RAG methodology described in the academic paper for clinical matching
- **EHR Integration:** Mapping varied EHR formats to standardized models
- **Date Format Handling:** Converting between different date formats
- **Functional Chunking:** Identifying appropriate boundaries for functional units
- **Centricity Data Mapping:** Ensuring accurate mapping of Centricity EHR data to application models
- **Test-Driven Development:** Creating comprehensive test suites for complex matching logic

## Agent Guidance

### For Manager Role
Coordinate overall development and focus on project roadmap. Ensure all agents have clear tasks and interfaces are well-defined.

### For Clinical Specialist Role
Focus on defining matching criteria for drug classes. Provide domain expertise on what clinical factors should influence matching and how to interpret EHR data.

### For Frontend Developer Role
Design a simple UI that demonstrates the matching process. Focus on clear presentation of match results with supporting evidence.

### For Backend Developer Role
Implement core API endpoints and the matching engine. Ensure the adapter pattern is properly implemented for data access.

### For Database Specialist Role
Define comprehensive data models for patients, drugs, and matches. Implement efficient adapters for data access with future PostgreSQL migration in mind. Create ETL processes for EHR data integration.

### For Security Specialist Role
Define how PHI should be handled in the development environment. Plan for future security needs if the application moves to production.

## Common Commands

Common operations for this project:

```bash
# Start development server
npm run dev

# Run tests
npm test

# Run specific test file
npm test -- tests/unit/enhancedFdaAdapter.test.js

# Build for production
npm run build

# Test FDA adapter
node scripts/test-fda-adapter.js

# Import Centricity patient data
node scripts/import-centricity-patients.js

# Initialize FDA vector store
node scripts/initialize-fda-vector-store.js

# Start ChromaDB with Docker (if needed)
docker run -p 8000:8000 chromadb/chroma
```

## Issues and Decisions

**Open Issues:**
- Need to define confidence scoring method for matches
- Need to standardize mapping between patient conditions and drug indications
- Need to implement comprehensive test suite for functional chunks
- Need to update remaining time-based chunks in build plan to functional chunks

**Recent Decisions:**
- Implement adapter pattern with interface for data storage - 2025-04-19 - Enables future PostgreSQL migration
- Design PostgreSQL schema with normalization - 2025-04-19 - Supports efficient querying in production
- Use ID generator utility for consistent entity IDs - 2025-04-19 - Standardizes ID format across application
- Add FDA API adapter for drug data access - 2025-04-19 - Provides real drug information beyond sample data
- Enhance drug model to accommodate FDA data structure - 2025-04-19 - Allows FDA data integration
- Use SouthPark Centricity EHR data for testing - 2025-04-19 - Provides real-world patient data
- Implement CentricityJsonAdapter - 2025-04-21 - Enables direct integration with Centricity EHR data
- Create import utility for Centricity data - 2025-04-22 - Simplifies working with Centricity patient data
- Transition from time-based chunks to functional chunks - 2025-04-25 - Improves development workflow with logical boundaries
- Update documentation to reflect functional chunking - 2025-04-25 - Ensures consistent approach across project
- Adopt RAG methodology from academic paper for FDA data processing - 2025-04-26 - Provides more sophisticated understanding of drug information
- Implement script inventory documentation - 2025-04-26 - Improves documentation and maintenance of utility scripts