#shellcheck shell=sh

Describe 'whereami'
  # Download Test
  It 'should success on install via brew'
    When call brew install KEINOS/apps/whereami
    The status should be success
    The stderr should include "Tapping keinos/apps"
    The output should include "🍺  /home/linuxbrew/.linuxbrew/Cellar/whereami"
  End

  # Smoke Test
  It 'should success and contain IP address in the output'
    When run whereami --verbose
    The status should be success
    The output should include '[LOG]: Provider'
  End
End
