#shellcheck shell=sh

Describe 'go-pallet'
  # Download Test
  It 'should success on install via brew'
    When call brew install KEINOS/apps/go-pallet
    The status should be success
    The stderr should include "Tapping keinos/apps"
    The output should include "🍺  /home/linuxbrew/.linuxbrew/Cellar/go-pallet"
  End

  # Smoke Test
  It 'should success and contain "pallet" in the output on version print'
    When run pallet -v
    The status should be success
    The output should match pattern "pallet *"
  End
End
