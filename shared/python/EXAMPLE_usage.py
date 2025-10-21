#!/usr/bin/env python3
# ABOUTME: Example usage of Google Sheets client from any project location
# This works from any subdirectory within /Users/braydon/projects/

import os
import sys
from pathlib import Path

# Add shared modules (absolute path - works from anywhere)
sys.path.insert(0, '/Users/braydon/projects/claude-workspace/shared/python')
from google_sheets_client import get_sheet_client


def example_usage():
    """
    Example: Access Google Sheets from any project.

    Prerequisites:
    1. .env file in your project directory with:
       GOOGLE_CREDENTIALS_PATH=~/.config/google-cloud/service-accounts/claude-service-account.json
       GOOGLE_SHEET_ID=<your-sheet-id>

    2. Share the Google Sheet/folder with:
       claude@versatile-brace-473317-m8.iam.gserviceaccount.com
    """

    # Load .env from current project directory
    env_path = Path.cwd() / '.env'

    # Initialize client
    client = get_sheet_client(env_path=env_path)

    # Get sheet ID from environment
    sheet_id = os.getenv('GOOGLE_SHEET_ID')
    if not sheet_id:
        raise ValueError("GOOGLE_SHEET_ID not found in .env")

    # Open the spreadsheet
    spreadsheet = client.open_by_key(sheet_id)
    print(f"Connected to: {spreadsheet.title}")

    # List all worksheets
    for worksheet in spreadsheet.worksheets():
        print(f"  - {worksheet.title}")

    # Access specific worksheet
    # worksheet = spreadsheet.worksheet('Sheet1')
    # data = worksheet.get_all_values()
    # print(data)


if __name__ == "__main__":
    example_usage()
