# Shared Python Utilities

Reusable Python modules for cross-project functionality.

## Google Sheets Client

Centralized Google Sheets access using service account authentication.

### Setup

1. **Credentials**: Stored at `~/.config/google-cloud/service-accounts/claude-service-account.json`
2. **Access Control**: Share specific Google Drive folders/sheets with `claude@versatile-brace-473317-m8.iam.gserviceaccount.com`
3. **Project Config**: Each project sets `GOOGLE_SHEET_ID` in `.env`

### Usage

**Option 1: Absolute Path (Recommended)**
```python
import sys
from pathlib import Path

# Add shared modules using absolute path
sys.path.insert(0, '/Users/braydon/projects/claude-workspace/shared/python')
from google_sheets_client import get_sheet_client

# Initialize client (loads .env from current directory if present)
client = get_sheet_client(env_path=Path(__file__).parent / '.env')

# Open sheet by ID from environment
import os
sheet_id = os.getenv('GOOGLE_SHEET_ID')
spreadsheet = client.open_by_key(sheet_id)

# Work with the sheet
worksheet = spreadsheet.worksheet('Sheet Name')
data = worksheet.get_all_values()
```

**Option 2: Using setup_path Helper**
```python
import sys
sys.path.insert(0, '/Users/braydon/projects/claude-workspace/shared/python')
import setup_path  # Auto-configures paths

from google_sheets_client import get_sheet_client
# ... rest same as above
```

### Dependencies

Add to your project's `requirements.txt`:
```
gspread==6.0.0
google-auth==2.23.4
google-auth-oauthlib==1.1.0
google-auth-httplib2==0.1.1
python-dotenv==1.0.0
```

### Security Model

- **Single Service Account**: Same credentials used across all projects
- **Least Privilege**: Google Drive folder permissions determine project access
- **Project Isolation**: Synth project can't access LFW sheets unless explicitly shared
