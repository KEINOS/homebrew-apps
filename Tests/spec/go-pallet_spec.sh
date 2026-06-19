#shellcheck shell=sh

Describe 'go-pallet'
  It 'should print its version'
    When run pallet -v
    The status should be success
    The output should match pattern "pallet *"
  End
End
