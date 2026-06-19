#shellcheck shell=sh

Describe 'whereami'
  It 'should report its provider'
    When run whereami --verbose
    The status should be success
    The output should include '[LOG]: Provider'
  End
End
