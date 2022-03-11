#shellcheck shell=sh

Describe 'dev-go-sample'
  # Download Test
  It 'should success on install via brew'
    When call brew install --verbose KEINOS/apps/dev-go-sample
    The status should be success
    The stderr should include "Tapping keinos/apps"
    The output should include "🍺"
    The output should include "/Cellar/dev-go-sample"
  End

  # Smoke Test
  It 'should success and contain "pallet" in the output on version print'
    When run dev-go-sample
    The status should be success
    The output should match pattern "Hello, Gopher!*"
  End
End
