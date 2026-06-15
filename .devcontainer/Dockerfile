# =============================================================================
#  Docker Container for LinuxBrew Download and Basic Execution Test
# =============================================================================
# [Choice] https://hub.docker.com/r/homebrew/brew/tags
ARG VARIANT="latest"

# -----------------------------------------------------------------------------
#  Main Stage
# -----------------------------------------------------------------------------
FROM homebrew/brew:${VARIANT}

# Disable Linux sandbox for Homebrew (required for Docker)
# and disable tap trust checks for untrusted tap formulas
ENV HOMEBREW_NO_SANDBOX_LINUX=1 \
    HOMEBREW_NO_REQUIRE_TAP_TRUST=1

RUN \
    brew install shellspec/shellspec/shellspec && \
    # Smoke test
    shellspec -v
