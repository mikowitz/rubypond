\version "2.13.8"
\include "english.ly"

CFour = \markup{"c4"}
CThree = \markup{"c3"}
ASFive = \markup{"as5"}
BFFour = \markup{"bf4"}
FSFive = \markup{"fs5"}


cFour = \relative c {
  \clef bass
  \time 2/4
  c, c''^\CFour
  cs,, c''^\CFour
  d,, c''^\CFour
  ef,, c''^\CFour
  e,, c''^\CFour
  f,, c''^\CFour
  fs,, c''^\CFour
  gf, c'^\CFour
  g, c'^\CFour
  af, c'^\CFour
  a, c'^\CFour
  bf, c'^\CFour
  b, c'^\CFour
  c, c'^\CFour
  cs, c'^\CFour
  d, c'^\CFour
  ef, c'^\CFour
  e, c'^\CFour
  f, c'^\CFour
  fs, c'^\CFour
  gf c^\CFour
  g c^\CFour
  af c^\CFour
  a c^\CFour
  bf c^\CFour
  b c^\CFour
  \clef treble
  c c^\CFour
  cs c^\CFour
  d c^\CFour
  ef c^\CFour
  e c^\CFour
  f c^\CFour
  fs c^\CFour
  gf' c,^\CFour
  g' c,^\CFour
  af' c,^\CFour
  a' c,^\CFour
  bf' c,^\CFour
  b' c,^\CFour
  c' c,^\CFour
  cs' c,^\CFour
  d' c,^\CFour
  ef' c,^\CFour
  e' c,^\CFour
  f' c,^\CFour
  fs' c,^\CFour
  gf'' c,,^\CFour
  g'' c,,^\CFour
  af'' c,,^\CFour
  a'' c,,^\CFour
  bf'' c,,^\CFour
  b'' c,,^\CFour
  c'' c,,^\CFour
  cs'' c,,^\CFour
}


fsFive = \relative c'' {
  f,,, fs'''^\FSFive
  fs,,, fs'''^\FSFive
  g,,, fs'''^\FSFive
  f'' fs,,^\FSFive
  fs'' fs,,^\FSFive
  g'' fs,,^\FSFive
}


cThree = \relative c' {
  \clef bass
  \time 2/4
  c c,^\CThree
  d c^\CThree
  fs c^\CThree
  gf' c,^\CThree
  fs, c'^\CThree
  gf c^\CThree
}

asFive = \relative c' {
  \clef treble
  c as''^\ASFive
  d, as'^\ASFive
  e as^\ASFive
  e' as,^\ASFive
  e, as'^\ASFive
}

bfFour = \relative c' {
  \clef treble
  c bf'^\BFFour
  c bf^\BFFour
  e, bf'^\BFFour
  e bf^\BFFour
  e' bf,^\BFFour
}

\score {
  <<
    \new Staff {
      \cFour
      \bar "||"
      \fsFive
      \bar "||"
      \cThree
      \bar "||"
      \asFive
      \bar "||"
      \bfFour
    }
  >>
}