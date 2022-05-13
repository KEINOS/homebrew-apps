#shellcheck shell=sh

Describe 'genrawid'
  # Download Test
  It 'should success on install via brew'
    When call brew install --verbose KEINOS/apps/genrawid
    The status should be success
    The stderr should include "Tapping keinos/apps"
    The output should include "🍺"
    The output should include "/Cellar/genrawid"
  End

  # Smoke Test
  It 'should success and contain the rawid'
    When run genrawid -s "abcdefgh"
    The status should be success
    The output should include "-2474118025671277174"
  End
End
