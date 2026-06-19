#shellcheck shell=sh

Describe 'dev-go-sample'
  It 'should print its greeting'
    When run dev-go-sample
    The status should be success
    The output should match pattern "Hello, Gopher!*"
  End
End
