# =============================================================================
#  Docker Container for LinuxBrew Download and Basic Execution Test
# =============================================================================
# [Choice] https://hub.docker.com/r/homebrew/brew/tags
ARG VARIANT="latest"

# -----------------------------------------------------------------------------
#  Main Stage
# -----------------------------------------------------------------------------
FROM homebrew/brew:${VARIANT}

RUN \
    brew install shellspec/shellspec/shellspec && \
    # Smoke test
    shellspec -v
