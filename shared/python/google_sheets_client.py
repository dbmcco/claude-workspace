# ABOUTME: Reusable Google Sheets client using centralized service account credentials
# Provides connection utilities for accessing Google Sheets across all projects

import os
import sys
from pathlib import Path
from typing import Optional
from dotenv import load_dotenv
import gspread
from google.oauth2.service_account import Credentials

# Auto-add this module to Python path for easy imports
_MODULE_DIR = Path(__file__).parent
if str(_MODULE_DIR) not in sys.path:
    sys.path.insert(0, str(_MODULE_DIR))


class GoogleSheetsClient:
    """
    Centralized Google Sheets client using service account authentication.

    Uses credentials from ~/.config/google-cloud/service-accounts/claude-service-account.json
    Access control managed via Google Drive folder permissions per project.
    """

    SCOPES = [
        'https://spreadsheets.google.com/feeds',
        'https://www.googleapis.com/auth/drive'
    ]

    DEFAULT_CREDENTIALS_PATH = Path.home() / '.config/google-cloud/service-accounts/claude-service-account.json'

    def __init__(self, credentials_path: Optional[Path] = None, env_path: Optional[Path] = None):
        """
        Initialize Google Sheets client.

        Args:
            credentials_path: Path to service account JSON. Defaults to ~/.config/google-cloud/service-accounts/claude-service-account.json
            env_path: Path to .env file for loading environment variables
        """
        if env_path:
            load_dotenv(dotenv_path=env_path)

        # Allow override via environment variable
        creds_path = credentials_path or os.getenv('GOOGLE_CREDENTIALS_PATH', self.DEFAULT_CREDENTIALS_PATH)
        creds_path = Path(creds_path).expanduser()

        if not creds_path.exists():
            raise FileNotFoundError(
                f"Service account credentials not found at {creds_path}. "
                "Ensure credentials are stored at ~/.config/google-cloud/service-accounts/claude-service-account.json"
            )

        credentials = Credentials.from_service_account_file(str(creds_path), scopes=self.SCOPES)
        self.gc = gspread.authorize(credentials)

    def open_by_key(self, sheet_id: str):
        """
        Open a Google Sheet by its ID.

        Args:
            sheet_id: The Google Sheet ID from the URL

        Returns:
            gspread.Spreadsheet object
        """
        return self.gc.open_by_key(sheet_id)

    def open_by_url(self, url: str):
        """
        Open a Google Sheet by its full URL.

        Args:
            url: Full Google Sheets URL

        Returns:
            gspread.Spreadsheet object
        """
        return self.gc.open_by_url(url)

    def open_by_title(self, title: str):
        """
        Open a Google Sheet by its title.

        Note: Only works if the service account has access to the sheet.

        Args:
            title: The spreadsheet title

        Returns:
            gspread.Spreadsheet object
        """
        return self.gc.open(title)


def get_sheet_client(env_path: Optional[Path] = None) -> GoogleSheetsClient:
    """
    Convenience function to get a configured Google Sheets client.

    Args:
        env_path: Optional path to .env file for environment variables

    Returns:
        GoogleSheetsClient instance
    """
    return GoogleSheetsClient(env_path=env_path)
