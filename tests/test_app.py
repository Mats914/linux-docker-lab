# =============================================================================
# test_app.py
# -----------------------------------------------------------------------------
# Unit tests for the Linux & Docker Lab application (app/app.py).
#
# Run locally:
#   pip install pytest
#   pytest tests/ -v
#
# Run inside Docker:
#   docker run --rm -v "$PWD/tests:/tests" linux-lab python3 -m pytest /tests/ -v
#
# These tests verify the core logic of get_env_info() without depending
# on any specific container environment — they mock OS-level calls.
# =============================================================================

import platform
import socket
import sys
import os

# Add the app directory to the Python path so we can import app.py directly
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', 'app'))

import app as lab_app


class TestGetEnvInfo:
    """Tests for the get_env_info() function."""

    def test_returns_dict(self):
        """get_env_info() must return a dictionary."""
        result = lab_app.get_env_info()
        assert isinstance(result, dict), "Expected a dict"

    def test_required_keys_present(self):
        """All required keys must be present in the returned dict."""
        required_keys = {"hostname", "os", "os_release", "python", "environment", "user"}
        result = lab_app.get_env_info()
        missing = required_keys - result.keys()
        assert not missing, f"Missing keys: {missing}"

    def test_hostname_matches_socket(self):
        """hostname value must match the system's actual hostname."""
        result = lab_app.get_env_info()
        assert result["hostname"] == socket.gethostname()

    def test_os_matches_platform(self):
        """os value must match platform.system()."""
        result = lab_app.get_env_info()
        assert result["os"] == platform.system()

    def test_python_version_matches(self):
        """python version must match the running interpreter."""
        result = lab_app.get_env_info()
        assert result["python"] == platform.python_version()

    def test_all_values_are_strings(self):
        """Every value in the returned dict must be a non-empty string."""
        result = lab_app.get_env_info()
        for key, value in result.items():
            assert isinstance(value, str), f"Key '{key}' has non-string value: {value!r}"
            assert len(value) > 0, f"Key '{key}' has empty string value"

    def test_environment_has_default(self):
        """environment key must fall back to 'unknown' when ENV is not set."""
        # Temporarily remove ENV from the environment if it exists
        original = os.environ.pop("ENV", None)
        try:
            result = lab_app.get_env_info()
            assert result["environment"] == "unknown"
        finally:
            # Restore original value so we don't affect other tests
            if original is not None:
                os.environ["ENV"] = original

    def test_environment_reads_env_variable(self):
        """environment key must reflect the ENV variable when it is set."""
        os.environ["ENV"] = "testing"
        try:
            result = lab_app.get_env_info()
            assert result["environment"] == "testing"
        finally:
            del os.environ["ENV"]


class TestPrintBanner:
    """Tests for the print_banner() helper function."""

    def test_runs_without_error(self, capsys):
        """print_banner() must not raise any exceptions."""
        lab_app.print_banner("Test Title")
        captured = capsys.readouterr()
        assert "Test Title" in captured.out

    def test_contains_border(self, capsys):
        """print_banner() output must include a border of '=' characters."""
        lab_app.print_banner("Test")
        captured = capsys.readouterr()
        assert "=" * 10 in captured.out  # at least 10 '=' chars


class TestPrintInfoTable:
    """Tests for the print_info_table() helper function."""

    def test_prints_all_keys(self, capsys):
        """print_info_table() must print every key in the dict."""
        data = {"alpha": "one", "beta": "two", "gamma": "three"}
        lab_app.print_info_table(data)
        captured = capsys.readouterr()
        for key in data:
            assert key in captured.out

    def test_prints_all_values(self, capsys):
        """print_info_table() must print every value in the dict."""
        data = {"hostname": "my-host", "os": "Linux"}
        lab_app.print_info_table(data)
        captured = capsys.readouterr()
        for value in data.values():
            assert value in captured.out
