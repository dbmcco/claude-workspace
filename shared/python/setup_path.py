# ABOUTME: Path setup helper for importing claude-workspace shared modules
# Use: from setup_path import add_shared_modules; add_shared_modules()

import sys
from pathlib import Path


def add_shared_modules():
    """
    Add claude-workspace shared Python modules to sys.path.
    Works from any project depth within /Users/braydon/projects/
    """
    # Find the shared modules directory
    shared_python = Path(__file__).parent

    if str(shared_python) not in sys.path:
        sys.path.insert(0, str(shared_python))

    return shared_python


def get_projects_root():
    """
    Find the projects root directory by traversing upward.
    Returns Path to /Users/braydon/projects/
    """
    current = Path.cwd()

    # Try to find 'projects' directory in current path
    for parent in [current] + list(current.parents):
        if parent.name == 'projects':
            return parent

    # Fallback to hardcoded path
    return Path('/Users/braydon/projects')


# Auto-execute on import
add_shared_modules()
