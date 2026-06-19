#shellcheck shell=sh

Describe 'genrawid'
  It 'should generate a consistent raw ID'
    When run genrawid -s "abcdefgh"
    The status should be success
    The output should include "-2474118025671277174"
  End
End
