
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; MODULE      : math-speech-en.scm
;; DESCRIPTION : mathematical editing using English speech
;; COPYRIGHT   : (C) 2022  Joris van der Hoeven
;;
;; This software falls under the GNU general public license version 3 or later.
;; It comes WITHOUT ANY WARRANTY WHATSOEVER. For details, see the file LICENSE
;; in the root directory or <http://www.gnu.org/licenses/gpl-3.0.html>.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(texmacs-module (math math-speech-en)
  (:use (math math-speech)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Sanitize input
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-table english-numbers
  ("0" "zero") ("1" "one") ("2" "two") ("3" "three") ("4" "four")
  ("5" "five") ("6" "six") ("7" "seven") ("8" "eight") ("9" "nine"))

(define-table english-ambiguate
  ("m" "m/n"))

(define (string-table-replace s t)
  (with repl (lambda (x) (with y (ahash-ref t x) (if y (car y) x)))
    (with l (string-decompose s " ")
      (string-recompose (map repl l) " "))))

(tm-define (speech-sanitize lan mode s)
  (:require (and (== lan 'english) (== mode 'math)))
  (set! s (locase-all s))
  (set! s (list->tmstring (clean-letter-digit (tmstring->list s))))
  (set! s (string-replace s "+" " plus "))
  (set! s (string-replace-trailing s "-" " minus "))
  (set! s (string-replace s "<times>" " times "))
  (set! s (string-replace s "/" " slash "))
  (set! s (string-replace s "," " comma "))
  (set! s (string-replace-trailing s "." " period "))
  (set! s (string-replace s ":" " colon "))
  (set! s (string-replace s ";" " semicolon "))
  (set! s (string-replace s "^" " hat "))
  (set! s (string-replace s "~" " tilda "))
  (set! s (string-replace s "<ldots>" " dots "))
  (set! s (string-replace s "<cdots>" " dots "))
  (set! s (string-table-replace s english-numbers))
  (set! s (string-table-replace s english-ambiguate))
  (set! s (string-replace s "  " " "))
  (set! s (string-replace s "  " " "))
  (set! s (tm-string-trim-both s))
  s)

(speech-collection dont-break english
  "ad" "ag" "ah" "al" "an" "ar" "as" "eg" "el" "em" "en" "ex"
  "if" "in" "is" "it" "of" "oh" "ok" "ol" "or" "up"
  "be" "de" "he" "pe" "se" "ve" "we"
  "ma" "va" "bi" "hi" "ji" "pi" "si" "xi" "yi"
  "do" "fo" "ho" "jo" "ko" "lo" "no" "po" "so" "to" "vo" "wo"
  "mu" "nu" "by" "hy" "ky" "my" "sy")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Entering mathematical symbols via English speech
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(speech-symbols english
  ("zero" "0")
  ("one" "1")
  ("two" "2")
  ("three" "3")
  ("four" "4")
  ("five" "5")
  ("six" "6")
  ("seven" "7")
  ("eight" "8")
  ("nine" "9")
  ("ten" "10")
  ("hundred" "100")
  ("thousand" "1000")
  ("million" "1000000")
  ("billion" "1000000000")

  ("a" "a")
  ("b" "b")
  ("c" "c")
  ("d" "d")
  ("e" "e")
  ("f" "f")
  ("g" "g")
  ("h" "h")
  ("i" "i")
  ("j" "j")
  ("k" "k")
  ("l" "l")
  ("m" "m")
  ("n" "n")
  ("o" "o")
  ("p" "p")
  ("q" "q")
  ("r" "r")
  ("s" "s")
  ("t" "t")
  ("u" "u")
  ("v" "v")
  ("w" "w")
  ("x" "x")
  ("y" "y")
  ("z" "z")

  ("alpha" "<alpha>")
  ("beta" "<beta>")
  ("gamma" "<gamma>")
  ("delta" "<delta>")
  ("epsilon" "<epsilon>")
  ("zeta" "<zeta>")
  ("eta" "<eta>")
  ("theta" "<theta>")
  ("iota" "<iota>")
  ("kappa" "<kappa>")
  ("lambda" "<lambda>")
  ("mu" "<mu>")
  ("nu" "<nu>")
  ("xi" "<xi>")
  ("omicron" "<omicron>")
  ("pi" "<pi>")
  ("rho" "<rho>")
  ("sigma" "<sigma>")
  ("tau" "<tau>")
  ("upsilon" "<upsilon>")
  ("phi" "<phi>")
  ("psi" "<psi>")
  ("chi" "<chi>")
  ("omega" "<omega>")

  ("constant e" "<mathe>")
  ("constant i" "<mathi>")
  ("constant pi" "<mathpi>")
  ("constant gamma" "<mathgamma>")
  ("euler constant" "<mathgamma>")

  ("infinity" "<infty>")
  ("complex numbers" "<bbb-C>")
  ("positive integers" "<bbb-N>")
  ("rationals" "<bbb-Q>")
  ("reals" "<bbb-R>")
  ("integers" "<bbb-Z>")

  ("plus" "+")
  ("minus" "-")
  ("times" "*")
  ("cross" "<times>")
  ("slash" "/")
  ("apply" " ")
  ("space" " ")
  ("after" "<circ>")
  ("tensor" "<otimes>")
  ("factorial" "!")

  ("equal" "=")
  ("not equal" "<neq>")
  ("assign" "<assign>")
  ("less" "<less>")
  ("less equal" "<leqslant>")
  ("greater" "<gtr>")
  ("greater equal" "<geqslant>")
  ("is in" "<in>")
  ("contains the element" "<ni>")
  ("subset" "<subset>")
  ("superset" "<supset>")

  ("similar" "<sim>")
  ("asymptotic" "<asymp>")
  ("approx" "<approx>")
  ("isomorphic" "<cong>")
  ("negligible" "<prec>")
  ("dominated" "<preccurlyeq>")
  ("dominates" "<succcurlyeq>")
  ("strictly dominates" "<succ>")

  ("for all" "<forall>")
  ("exists" "<exists>")
  ("or" "<vee>")
  ("logical and" "<wedge>")
  ("implies" "<Rightarrow>")
  ("equivalent" "<Leftrightarrow>")

  ("right arrow" "<rightarrow>")
  ("long right arrow" "<rightarrow>")
  ("maps to" "<mapsto>")
  ("long maps to" "<longmapsto>")

  ("period" ".")
  ("comma" ",")
  ("colon" ":")
  ("semicolon" ";")
  ("exclamation mark" "!")
  ("question mark" "?")
  ("." ".")
  ("," ",")
  (":" ":")
  (";" ";")
  ("!" "!")
  ("?" "?")
  ("such that" "<suchthat>")
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; More complex mathematical speech commands
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(speech-map english math
  ("uppercase" (speech-alter-letter :big))
  ("lowercase" (speech-alter-letter :small))
  ("bold" (speech-alter-letter :bold))
  ("medium" (speech-alter-letter :medium))
  ("upright" (speech-alter-letter :up))
  ("italic" (speech-alter-letter :it))
  ("calligraphic" (speech-alter-letter :cal))
  ("fraktur" (speech-alter-letter :frak))
  ("gothic" (speech-alter-letter :frak))
  ("blackboard bold" (speech-alter-letter :bbb))
  ("normal" (speech-alter-letter :normal))
  ("sans serif" (speech-alter-letter :ss))
  ("typewriter" (speech-alter-letter :tt))
  ("operator" (speech-operator))
 
  ("factor" (speech-factor))
  ("inverse" (speech-insert-superscript "-1"))
  ("square" (speech-insert-superscript "2"))
  ("cube" (speech-insert-superscript "3"))
  ("sub" (speech-subscript))
  ("power" (speech-superscript))
  ("subscript" (make 'rsub))
  ("superscript" (make 'rsup))

  ("prime" (make-rprime "'"))
  ("double prime" (make-rprime "'") (make-rprime "'"))
  ("triple prime" (make-rprime "'") (make-rprime "'") (make-rprime "'"))
  ("dagger" (make-rprime "<dag>"))

  ("hat" (speech-accent "^"))
  ("tilda" (speech-accent "~"))
  ("bar" (speech-accent "<bar>"))
  ("wide hat" (speech-wide "^"))
  ("wide tilda" (speech-wide "~"))
  ("wide bar" (speech-wide "<bar>"))
  ("under" (speech-under))

  ("of" (speech-of))
  ("open" (speech-open "(" ")"))
  ("close" (speech-close))
  ("parentheses" (speech-brackets "(" ")"))
  ("brackets" (speech-brackets "[" "]"))
  ("braces" (speech-brackets "{" "}"))
  ("chevrons" (speech-brackets "<langle>" "<rangle>"))
  ("floor" (speech-brackets "<lfloor>" "<rfloor>"))
  ("ceiling" (speech-brackets "<lceil>" "<rceil>"))
  ("open parentheses" (speech-open "(" ")"))
  ("open open" (speech-open "[" "]"))
  ("open braces" (speech-open "{" "}"))
  ("open chevrons" (speech-open "<langle>" "<rangle>"))
  ("open floor" (speech-open "<lfloor>" "<rfloor>"))
  ("open ceiling" (speech-open "<lceil>" "<rceil>"))

  ("(" (speech-open "(" ")"))
  ("[" (speech-open "[" "]"))
  ("{" (speech-open "{" "}"))
  (")" (speech-close))
  ("]" (speech-close))
  ("}" (speech-close))
  
  ("arc cos" (speech-insert-operator "arccos"))
  ("arc sin" (speech-insert-operator "arcsin"))
  ("arc tan" (speech-insert-operator "arctan"))
  ("arg" (speech-insert-operator "arg"))
  ("cos" (speech-insert-operator "cos"))
  ("deg" (speech-insert-operator "deg"))
  ("det" (speech-insert-operator "det"))
  ("dim" (speech-insert-operator "dim"))
  ("exp" (speech-insert-operator "exp"))
  ("gcd" (speech-insert-operator "gcd"))
  ("log" (speech-insert-operator "log"))
  ("hom" (speech-insert-operator "hom"))
  ("inf" (speech-insert-operator "inf"))
  ("ker" (speech-insert-operator "ker"))
  ("lcm" (speech-insert-operator "lcm"))
  ("lim" (speech-insert-operator "lim"))
  ("lim inf" (speech-insert-operator "liminf"))
  ("lim sup" (speech-insert-operator "limsup"))
  ("ln" (speech-insert-operator "ln"))
  ("log" (speech-insert-operator "log"))
  ("max" (speech-insert-operator "max"))
  ("min" (speech-insert-operator "min"))
  ("Pr" (speech-insert-operator "Pr"))
  ("sin" (speech-insert-operator "sin"))
  ("supremum" (speech-insert-operator "sup"))
  ("tan" (speech-insert-operator "tan"))
  
  ("plus dots plus" (speech-dots "+" "<cdots>"))
  ("minus dots minus" (speech-dots "-" "<cdots>"))
  ("times dots times" (speech-dots "*" "<cdots>"))
  ("comma dots comma" (speech-dots "," "<ldots>"))
  ("colon dots colon" (speech-dots ":" "<ldots>"))
  ("semicolon dots semicolon" (speech-dots ";" "<ldots>"))
  ("and dots and" (speech-dots "<wedge>" "<cdots>"))
  ("or dots or" (speech-dots "<vee>" "<cdots>"))
  ("equal dots equal" (speech-dots "=" "<cdots>"))
  ("similar dots similar" (speech-dots "<sim>" "<cdots>"))
  ("less dots less" (speech-dots "<less>" "<cdots>"))
  ("less equal dots less equal" (speech-dots "<leqslant>" "<cdots>"))
  ("greater dots greater" (speech-dots "<gtr>" "<cdots>"))
  ("greater equal dots greater equal" (speech-dots "<geqslant>" "<cdots>"))
  ("tensor dots tensor" (speech-dots "<otimes>" "<cdots>"))

  ("sum" (math-big-operator "sum"))
  ("product" (math-big-operator "prod"))
  ("integral" (math-big-operator "int"))
  ("contour integral" (math-big-operator "oint"))
  ("double integral" (math-big-operator "iint"))
  ("triple integral" (math-big-operator "iiint"))
  ("for" (speech-for))
  ("from" (speech-for))
  ("until" (speech-until))
  ("to" (speech-to))
  ("d u" (speech-insert-d "u"))
  ("d v" (speech-insert-d "v"))
  ("d w" (speech-insert-d "w"))
  ("d x" (speech-insert-d "x"))
  ("d y" (speech-insert-d "y"))
  ("d z" (speech-insert-d "z"))

  ("square root" (speech-sqrt))
  ("square root of" (speech-sqrt-of))
  ("fraction" (speech-fraction))
  ("over" (speech-over))
  ("numerator" (go-to-fraction :numerator))
  ("denominator" (go-to-fraction :denominator))

  ("matrix" (make 'matrix))
  ("determinant" (make 'det))
  ("choice" (make 'choice))
  ("horizontal dots" (insert "<cdots>"))
  ("vertical dots" (insert "<vdots>"))
  ("diagonal dots" (insert "<ddots>"))
  ("upward dots" (insert "<udots>"))

  ;;("more" "var")
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Speech reductions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(speech-reduce english math
  ("letter a" "a")
  ("letter b" "b")
  ("letter c" "c")
  ("letter d" "d")
  ("letter e" "e")
  ("letter f" "f")
  ("letter g" "g")
  ("letter h" "h")
  ("letter i" "i")
  ("letter j" "j")
  ("letter k" "k")
  ("letter l" "l")
  ("letter m" "m")
  ("letter n" "n")
  ("letter o" "o")
  ("letter p" "p")
  ("letter q" "q")
  ("letter r" "r")
  ("letter s" "s")
  ("letter t" "t")
  ("letter u" "u")
  ("letter v" "v")
  ("letter w" "w")
  ("letter x" "x")
  ("letter y" "y")
  ("letter z" "z")

  ("greek phi" "phi")

  ("big" "uppercase")
  ("capital" "uppercase")
  ("small" "lowercase")

  ("the complex" "complex")
  ("the positive integers" "positive integers")
  ("the rationals" "rationals")
  ("the reals" "reals")
  ("the integers" "integers")
  ("rational" "rationals")
  ("rational numbers" "rationals")
  ("real" "reals")
  ("real numbers" "reals")
  ("double stroke" "blackboard bold")

  ("parenthesis" "parentheses")
  ("bracket" "brackets")
  ("brace" "braces")
  ("chevron" "chevrons")
  ("round brackets" "parentheses")
  ("square brackets" "brackets")
  ("curly brackets" "braces")
  ("angular brackets" "chevrons")
  ("close parentheses" "close")
  ("close brackets" "close")
  ("close braces" "close")
  ("close chevrons" "close")
  ("close floor" "close")
  ("close ceiling" "close")

  ("set" "braces")
  ("set of" "braces")
  ("the set" "braces")
  ("the set of" "braces")

  ("equals" "equal")
  ("equal to" "equal")
  ("is equal to" "equal")

  ("not equal to" "not equal")
  ("is not equal" "not equal")
  ("is not equal to" "not equal")
  ("unequal" "not equal")
  ("unequal to" "not equal")
  ("is unequal to" "not equal")
  ("different" "not equal")
  ("different from" "not equal")
  ("is different from" "not equal")

  ("inferior" "less")
  ("inferior to" "less")
  ("inferior" "less")
  ("is less" "less")
  ("less than" "less")
  ("less or equal" "less equal")

  ("superior" "greater")
  ("superior to" "greater")
  ("is greater" "greater")
  ("greater than" "greater")
  ("greater or equal to" "greater equal")

  ("is a subset of" "subset")
  ("contains" "superset")
  ("into" "right arrow")
  
  ("there exists a" "exists")
  ("there exists an" "exists")
  ("there exists" "exists")
  ("if and only if" "equivalent")

  ("argument" "arg")
  ("cosine" "cos")
  ("degree" "deg")
  ("dimension" "dim")
  ("exponential" "exp")
  ("greatest common divisor" "gcd")
  ("homomorphisms" "hom")
  ("infimum" "inf")
  ("kernel" "ker")
  ("least common multiple" "lcm")
  ("limit" "lim")
  ("inferior lim" "lim inf")
  ("superior sup" "lim sup")
  ("natural logarithm" "ln")
  ("logarithm" "log")
  ("maximum" "max")
  ("minimum" "min")
  ("probability" "Pr")
  ("sine" "sin")
  ("tangent" "tan")

  ("the arg" "arg")
  ("the cos" "cos")
  ("the deg" "deg")
  ("the det" "det")
  ("the dim" "dim")
  ("the exp" "exp")
  ("the gcd" "gcd")
  ("the hom" "hom")
  ("the inf" "inf")
  ("the ker" "ker")
  ("the lcm" "lcm")
  ("the lim" "lim")
  ("the lim inf" "lim inf")
  ("the lim sup" "lim sup")
  ("the ln" "ln")
  ("the log" "log")
  ("the max" "max")
  ("the min" "min")
  ("the Pr" "Pr")
  ("the sin" "sin")
  ("the supremum" "supremum")
  ("the tan" "tan")
  ("the square root" "square root")

  ("etc." "dots")
  ("etcetera" "dots")
  ("little dots" "dots")
  ("three little dots" "dots")
  ("dot dot dot" "dots")
  ("plus plus" "plus dots plus")
  ("times times" "times dots times")
  ("comma comma" "comma dots comma")
  ("colon colon" "colon dots colon")
  ("semicolon semicolon" "semicolon dots semicolon")
  ("tensor tensor" "tensor dots tensor")
  ("plus until" "plus dots plus")
  ("times until" "times dots times")
  ("comma until" "comma dots comma")
  ("colon until" "colon dots colon")
  ("semicolon until" "semicolon dots semicolon")
  ("and until" "and dots and")
  ("or until" "or dots or")
  ("equal until" "equal dots equal")
  ("similar until" "similar dots similar")
  ("less until" "less dots less")
  ("less equal until" "less equal dots less equal")
  ("greater until" "greater dots greater")
  ("greater equal until" "greater equal dots greater equal")
  ("tensor until" "tensor dots tensor")

  ("similar to" "similar")
  ("is similar to" "similar")
  ("equivalent" "similar")
  ("equivalent to" "equivalent")
  ("is equivalent to" "equivalent")
  ("asymptotic to" "asymptotic")
  ("is asymptotic to" "asymptotic")
  ("approximately" "approx")
  ("approximately equal" "approx")
  ("approximately equal to" "approx")
  ("is approximately" "approximately")
  ("isomorphic to" "isomorphic")
  ("is isomorphic to" "isomorphic")
  
  ("negligible with respect to" "negligible")
  ("is negligible with respect to" "negiglible")
  ("is strictly dominated by" "negligible")
  ("dominated by" "dominated")
  ("is dominated by" "dominated")
  ("dominates" "dominates")

  ("tilde" "tilda")
  ("big hat" "wide hat")
  ("big tilda" "wide tilda")
  ("big tilde" "wide tilda")
  ("big bar" "wide bar")

  ("big sum" "sum")
  ("big product" "product")
  ("big integral" "integral")
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Disambiguation
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (english-m/n)
  (if (stats-prefer? "n" "m" :strong)
      (speech-insert-symbol "n")
      (speech-insert-symbol "m")))

(define (english-and)
  (if (stats-prefer? "<wedge>" "n" :normal)
      (speech-insert-symbol "<wedge>")
      (speech-insert-symbol "n")))

(define (english-in)
  (if (stats-prefer? "n" "<in>" :strong)
      (speech-insert-symbol "n")
      (speech-insert-symbol "<in>")))

(define (english-the)
  (speech-insert-symbol "d"))

(speech-map english math
  ("a/e/8" (speech-best-letter "a" "e" "8"))
  ("a/e/8 hat" (speech-best-accent "^" "a" "e"))
  ("a/e/8 tilda" (speech-best-accent "~" "a" "e"))
  ("a/e/8 bar" (speech-best-accent "<bar>" "a" "e"))
  ("b/p/d" (speech-best-letter "b" "p" "d" "b"))
  ("d/b" (speech-best-letter "d" "b" "d"))
  ("v/t/d/3" (speech-best-letter "v" "t" "d" "3"))
  ("d/t/v/3" (speech-best-letter "d" "t" "v" "3"))
  ("t/d/v/3" (speech-best-letter "t" "d" "v" "3"))
  ("t/d/v/3 hat" (speech-best-accent "^" "t" "d" "v"))
  ("t/d/v/3 tilda" (speech-best-accent "~" "t" "d" "v"))
  ("t/d/v/3 bar" (speech-best-accent "<bar>" "t" "d" "v"))
  ("phi/5" (speech-best-letter "<phi>" "5"))
  ("s/f" (speech-best-letter "s" "f" "s"))
  ("l/i" (speech-best-letter "l" "i" "l"))
  ("xi/psi" (speech-best-letter "<xi>" "<psi>" "<xi>"))
  ("m/n" (english-m/n))
  ("in" (english-in))
  ("and" (english-and))
  ("the" (speech-best-letter "d" "v" "d"))
  )

(speech-reduce english math
  ("plus eight" "plus a/e/8")
  ("minus eight" "minus a/e/8")
  ("times eight" "times a/e/8")
  ("eight plus" "a/e/8 plus")
  ("eight minus" "a/e/8 minus")
  ("eight times" "a/e/8 times")
  ("eight hat" "a/e/8 hat")
  ("eight tilda" "a/e/8 tilda")
  ("eight bar" "a/e/8 bar")

  ("bold three" "bold v/t/d/3")
  ("times three" "times d/t/v/3")
  ("three hat" "t/d/v/3 hat")
  ("three tilda" "t/d/v/3 tilda")
  ("three bar" "t/d/v/3 bar")

  ("greek five" "phi")
  ("times five" "times phi/5")
  ("big five" "big phi")
  ("bold five" "bold phi/5")
  ("upright five" "upright phi")
  ("five hat" "phi hat")
  ("five tilda" "phi tilda")
  ("five bar" "phi bar")
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Adjust wrongly recognized words
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(speech-adjust english math
  ;; Adjust latin letters
  ("hey" "a")
  ("be" "b")
  ("bee" "b")
  ("see" "c")
  ("siri" "c")
  ("day" "d")
  ("de" "d")
  ("dee" "d")
  ("he" "e")
  ("eat" "e")
  ("each" "e")
  ("if" "f")
  ("ji" "g")
  ("age" "h")
  ("edge" "h")
  ("hi" "i")
  ("eye" "i")
  ("eyes" "i")
  ("either" "i")
  ("i've" "i")
  ("iron" "i")
  ("jade" "j")
  ("jay" "j")
  ("ok" "k")
  ("kate" "k")
  ("katie" "k")
  ("cake" "k")
  ("care" "k")
  ("case" "k")
  ("que" "k")
  ("al" "l")
  ("el" "l")
  ("i'll" "l/i")
  ("em" "m/n")
  ("an" "n")
  ("oh" "o")
  ("all" "o")
  ("old" "o")
  ("00" "o")
  ("piece" "p")
  ("pee" "p")
  ("pete" "p")
  ("queue" "q")
  ("cues" "q")
  ("cute" "q")
  ("are" "r")
  ("art" "r")
  ("our" "r")
  ("cute" "q")
  ("yes" "s/f")
  ("ass" "s")
  ("cheese" "t")
  ("tea" "t")
  ("team" "t")
  ("tee" "t")
  ("you" "u")
  ("via" "v")
  ("va" "v")
  ("ve" "v")
  ("ask" "x")
  ("ex" "x")
  ("eggs" "x")
  ("why" "y")
  
  ;; Adjust greek letters
  ("l5" "alpha")
  ("b that" "beta")
  ("beata" "beta")
  ("peta" "beta")
  ("vita" "beta")
  ("bita" "beta")
  ("beat a" "beta")
  ("gonna" "gamma")
  ("got my" "gamma")
  ("gummer" "gamma")
  ("add simon" "epsilon")
  ("add cylon" "epsilon")
  ("abseiling" "epsilon")
  ("simon" "epsilon")
  ("atta" "eta")
  ("eat a" "eta")
  ("eater" "eta")
  ("cheetah" "theta")
  ("tita" "theta")
  ("cita" "theta")
  ("theater" "theta")
  ("tata" "theta")
  ("santa" "theta")
  ("sciota" "iota")
  ("utah" "iota")
  ("yota" "iota")
  ("capa" "kappa")
  ("capela" "kappa")
  ("carpet" "kappa")
  ("copper" "kappa")
  ("coppa" "kappa")
  ("cuppa" "kappa")
  ("scopa" "kappa")
  ("lanta" "lambda")
  ("lampa" "lambda")
  ("lamp that" "lambda")
  ("llamada" "lambda")
  ("mantha" "lambda")
  ("manta" "lambda")
  ("mamta" "lambda")
  ("mute" "mu")
  ("moo" "mu")
  ("mood" "mu")
  ("no" "nu")
  ("new" "nu")
  ("gnu" "nu")
  ("knew" "nu")
  ("all my chrome" "omicron")
  ("o n my chrome" "omicron")
  ("o my crumb" "omicron")
  ("oh my chrome" "omicron")
  ("omi chrome" "omicron")
  ("omi cron" "omicron")
  ("bye" "pi")
  ("pie" "pi")
  ("road" "rho")
  ("row" "rho")
  ("role" "rho")
  ("roll" "rho")
  ("set my" "sigma")
  ("sick my" "sigma")
  ("suck my" "sigma")
  ("sync my" "sigma")
  ("ciao" "tau")
  ("towel" "tau")
  ("tall" "tau")
  ("tao" "tau")
  ("toe" "tau")
  ("toll" "tau")
  ("town" "tau")
  ("absolem" "upsilon")
  ("absalom" "upsilon")
  ("absalon" "upsilon")
  ("upside down" "upsilon")
  ("up so long" "upsilon")
  ("u p so long" "upsilon")
  ("fight" "phi")
  ("fine" "phi")
  ("sigh" "xi/psi")
  ("size" "psi")
  ("kai" "chi")
  ("kite" "chi")
  ("kind" "chi")
  ("sky" "chi")
  ("amiga" "omega")
  ("oh my god" "omega")

  ;; Adjust letter combinations
  ("ah" "a h")
  ("ai" "a i")
  ("ecu" "a q")
  ("ar" "a r")
  ("easy" "a z")
  ("be my" "b i")
  ("decu" "d/b q")
  ("busy" "b z")
  ("the u" "d u")
  ("the v" "d v")
  ("the w" "d w")
  ("the x" "d x")
  ("the y" "d y")
  ("dez" "d z")
  ("the z" "d z")
  ("ea" "e a")
  ("e.g." "e g")
  ("ei" "e i")
  ("en" "e n")
  ("eo" "e o")
  ("eu" "e u")
  ("eax" "e x")
  ("exo" "e x")
  ("eyi" "e y")
  ("eli" "e y")
  ("iwai" "e y")
  ("is z" "e z")
  ("fo" "f o")
  ("fav" "f v")
  ("fve" "f v")
  ("fyi" "f y")
  ("g.i." "g i")
  ("g-eazy" "g z")
  ("hiv" "h v")
  ("hve" "h v")
  ("hy" "h y")
  ("agency" "h z")
  ("ia" "i a")
  ("icy" "i c")
  ("i.e." "i e")
  ("iah" "i h")
  ("i/o" "i o")
  ("ize" "i z")
  ("jo" "j o")
  ("jav" "j v")
  ("javy" "j v")
  ("ok baby" "k b")
  ("katie" "k t")
  ("ky" "k y")
  ("casey" "k z")
  ("aldi" "l d")
  ("lo" "l o")
  ("elzhi" "l z")
  ("pedi" "p d")
  ("pei" "p i")
  ("pique" "p k")
  ("sy" "s y")
  ("buy ice" "pi i")
  ("bye bye" "pi i")
  ("bye-bye" "pi i")
  ("bye i" "pi i")
  ("to fight i" "two pi i")
  ("to buy i" "two pi i")

  ;; Adjust capitalized letters
  ("dick" "big")
  ("pick" "big")
  ("beck" "big")
  ("plastic" "plus big")
  ("dixie" "big c")
  ("digby" "big b/p/d")
  ("make f" "big f")
  ("did g" "big g")
  ("bigeye" "big i")
  ("big guy" "big i")
  ("biko" "big o")
  ("waco" "big o")
  ("biggby" "big b/p/d")
  ("pick hour" "big r")
  ("make u" "big u")
  ("bequita" "big eta")
  ("bixi" "big xi")
  ("big side" "big xi")
  ("big site" "big xi")
  ("big five" "big phi")
  ("becky" "big chi")

  ;; Adjust bold variants
  ("bol" "bold")
  ("bolt" "bold")
  ("both" "bold")
  ("bowl" "bold")
  ("build" "bold")
  ("that's bold" "plus bold")
  ("bobby" "bold b")
  ("bowlby" "bold b")
  ("baldy" "bold d")
  ("boke" "bold k")
  ("bouquet" "bold k")
  ("volpe" "bold p")
  ("baltar" "bold r")
  ("bote" "bold t")
  ("bold wi‑fi" "bold v")
  ("bold fee" "bold v")
  ("bold feet" "bold v")
  ("volví" "bold v")
  ("bullseye" "bold z")
  ("bold laptop" "bold lambda")
  ("bold five" "bold phi")
  ("bullfight" "bold phi")

  ;; Adjust upright variants
  ("a bright" "upright")
  ("a pride" "upright")
  ("upright five" "upright phi")

  ;; Adjust blackboard bold variants
  ("blackboard bolt" "blackboard bold")
  ("blackboard bolte" "blackboard bold")
  ("blackboard both" "blackboard bold")
  ("blackboard bowl" "blackboard bold")
  ("blackboard bull" "blackboard bold")
  ("blackboard volt" "blackboard bold")
  ("backward bold" "blackboard bold")
  ("blackbird" "blackboard")
  ("reels" "reals")

  ;; Adjust fraktur variants
  ("fractura" "fraktur")
  ("fracture" "fraktur")
  ("tractor" "fraktur")
  ("track to her" "fraktur")
  ("wreck to" "fraktur")
  ("plus factor" "plus fraktur")
  ("fraktur version" "fraktur v")

  ;; Adjust calligraphic variants
  ("carrie graphic" "calligraphic")
  ("carry graphic" "calligraphic")
  ("kelly graphic" "calligraphic")
  ("kenny graphic" "calligraphic")
  ("kevin graphic" "calligraphic")
  ("scary graphic" "calligraphic")
  ("skelly graphic" "calligraphic")
  ("skinny graphic" "calligraphic")
  ("tabby graphic" "calligraphic")

  ;; Adjust sans serif variants
  ("salsarita" "sans serif")
  ("salsaritas" "sans serif")
  ("salsa refill" "sans serif")
  ("salsa wreath" "sans serif")
  ("san sarith" "sans serif")
  ("san siri" "sans serif")
  ("sans sarith" "sans serif")
  ("sarith" "sans serif")
  ("saucer a" "sans serif")
  ("saucery" "sans serif")
  ("saulsberry" "sans serif")
  ("sensory" "sans serif")
  ("size siri" "sans serif")
  ("sounds arif" "sans serif")
  ("some sarife" "sans serif")
  ("some siri" "sans serif")
  ("sorcery" "sans serif")
  ("sounds sarith" "sans serif")
  ("sounds to reefs" "sans serif")
  ("sounds to reach" "sans serif")
  ("sarife" "sans serif")
  ("sunseri" "sans serif")
  ("seven siri" "sans serif")
  ("sans serif day" "sans serif d")
  ("sans serif femme" "sans serif m")
  ("sans serif 50" "sans serif t")
  ("sans serif vive" "sans serif v")
  ("sans serif v r" "sans serif v")
  ("sans serif v data" "sans serif beta")
  ("sans serif side" "sans serif psi")
  
  ;; Adjust 'letter plus' and 'plus letter'
  ("does" "plus")
  ("play" "plus")
  ("blessed" "plus")
  ("please" "plus")
  ("press" "plus")
  ("plusa" "plus a")
  ("iplus" "i plus")
  ("ipads" "i plus")
  ("busqué" "plus k")
  ("plus speed" "plus p")
  
  ;; Adjust 'letter minus' and 'minus letter'
  ("midas" "minus")
  ("mine is" "minus")
  ("minus vive" "minus v")

  ;; Adjust 'letter times' and 'times letter'
  ("time" "times")
  ("and times" "n times")
  ("endtimes" "n times")
  ("times a day" "times d")
  ("times day" "times d")
  ("times speed" "times p")
  ("times vive" "times v")
  ("times we" "times v")

  ;; Adjust basic relations
  ("smaller" "less")
  ("bigger" "greater")
  ("larger" "greater")
  ("less then" "less than")
  ("greater then" "greater than")
  ("difference" "different")
  ("and less" "n less")
  ("and greater" "n greater")

  ;; Adjust further binary relations
  ("10 sir" "tensor")
  ("dancer" "tensor")

  ;; Adjust operator names
  ("cosign" "cosine")
  ("lock" "log")
  ("luck" "log")
  ("look" "log")
  ("clock" "log")
  ("log and" "log n")
  ("log in" "log n")
  ("unlock" "n log")
  ("timeslot" "times log")

  ;; Adjust punctuation
  ("call ma" "comma")
  ("call matt" "comma")
  ("call mark" "comma")
  ("call mom" "comma")
  ("docs" "dots")
  ("dutch" "dots")
  ("ducks" "dots")

  ;; Adjust brackets
  ("off" "of")
  ("fof" "f of")
  ("fof" "f of")
  ("find of" "phi of")
  ("rackets" "brackets")

  ;; Adjust big operators
  ("sam" "sum")
  ("some" "sum")
  ("sum four" "sum for")
  ("product four" "sum for")
  ("enter girl" "integral")

  ;; Adjust subscripts
  ("sab" "sub")
  ("sup" "sub")
  ("subscripts" "subscript")
  ("subscribe" "subscript")
  ("subscribed" "subscript")
  ("sabe" "sub a")
  ("subsea" "sub c")
  ("sera d" "sub d")
  ("sub g e" "sub g")
  ("subject" "sub g")
  ("sake" "sub k")
  ("subkey" "sub k")
  ("sub and" "sub n")
  ("sub end" "sub n")
  ("sub in" "sub n")
  ("sabol" "sub o")
  ("syrupy" "sub p")
  ("sub t v" "sub t")
  ("subversion" "sub v")
  ("subway" "sub y")
  ("sabzi" "sub z")
  ("subzero" "sub z")
  ("sabeta" "sub beta")
  ("asap" "a sub")
  ("bishop" "b sub")
  ("this up" "d sub")
  ("aesop" "e sub")
  ("isa" "i sub")
  ("i suck" "i sub")
  ("geez up" "g sub")
  ("case of" "k sub")
  ("quesadilla" "k sub d")
  ("elsa" "l sub")
  ("anseth" "n sub")
  ("pizza" "p sub")
  ("cues of" "q sub")
  ("cute up" "q sub")
  ("cusack" "q sub")
  ("tsop" "t sub")
  ("tsopk" "t sub k")
  ("visa" "v sub")
  ("my sub" "y sub")
  ("why is a" "y sub")
  ("zisa" "z sub")
  ("by sub" "pi sub")

  ;; Adjust powers and superscripts
  ("exponent" "superscript")
  ("powerbeats" "power b")
  ("power and" "power n")
  ("power in" "power n")
  ("powers e" "power z")
  ("empower" "m power")
  ("in power" "n power")
  ("is power" "e power")
  ("is superscript" "e superscript")
  ("squared" "square")
  ("e xquire" "x square")
  ("exquire" "x square")
  ("by square" "pi square")
  ("cubed" "cube")

  ;; Adjust fractions
  ("o for" "over")
  ("o from" "over")
  ("offer" "over")
  ("ayo for" "a over")
  ("do for" "d over")
  ("eo for" "e over")
  ("fo for" "f over")
  ("geo for" "g over")
  ("ho for" "h over")
  ("eye-opener" "i over")
  ("hi oh for" "i over")
  ("iovu" "i over")
  ("i'll old for" "i over")
  ("jo for" "j over")
  ("ko for" "k over")
  ("lo for" "l over")
  ("i'm over" "m over")
  ("eno for" "n over")
  ("po for" "p over")
  ("so for" "s over")
  ("to for" "t over")
  ("vo for" "v over")
  ("voo for" "v over")
  ("exo for" "x over")
  ("roll over" "rho over")
  ("find over" "phi over")
  ("fine over" "phi over")
  ("fios for" "phi over")
  ("overby" "over b")
  ("oversee" "over c")
  ("overall" "over o")
  ("overview" "over v")
  ("over laptop" "over lambda")
  ("overtone" "over tau")

  ;; Adjust hat accents
  ("white" "wide")
  ("head" "hat")
  ("had" "hat")
  ("hit" "hat")
  ("hunt" "hat")
  ("hurt" "hat")
  ("pet" "hat")
  ("light head" "wide hat")
  ("why hat" "wide hat")
  ("why tilda" "wide tilda")
  ("why tilde" "wide tilda")
  ("why bar" "wide bar")
  ("my hat" "wide hat")
  ("my tilda" "wide tilda")
  ("my tilde" "wide tilda")
  ("my bar" "wide bar")
  ("the hat" "d hat")
  ("he had" "e hat")
  ("jihad" "g hat")
  ("ipad" "i hat")
  ("in hat" "n hat")
  ("and hat" "n hat")
  ("asshat" "s hat")
  ("you had" "u hat")
  ("we hat" "v hat")
  ("we had" "v hat")
  ("cupperhead" "kappa hat")
  ("rohat" "rho hat")
  ("find hat" "phi hat")
  ("sign hat" "psi hat")
  ("side hat" "psi hat")

  ;; Adjust tilda accents
  ("in tilda" "n tilda")
  ("and tilda" "n tilda")
  ("find tilda" "phi tilda")
  ("sign tilda" "psi tilda")
  ("side tilda" "psi tilda")

  ;; Adjust bar accents
  ("bieber" "b bar")
  ("the bar" "d bar")
  ("ebar" "e bar")
  ("aybar" "i bar")
  ("al-bahr" "l bar")
  ("embar" "m bar")
  ("end bar" "n bar")
  ("in bar" "n bar")
  ("and bar" "n bar")
  ("p b r" "p bar")
  ("q b r" "q bar")
  ("cuba" "q bar")
  ("eubar" "u bar")
  ("rebar" "v bar")
  ("laptop bar" "lambda bar")
  ("rober" "rho bar")
  ("robert" "rho bar")
  ("robar" "rho bar")
  ("rovar" "rho bar")
  ("tovar" "tau bar")
  ("find bar" "phi bar")
  ("sign bar" "psi bar")
  ("side bar" "psi bar")

  ;; Miscellaneous
  ("it's" "is")
  ("write" "right")
  ("leaf" "leave")
  ("leafs" "leave")
  ("leaves" "leave")
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Further, more dangerous adjustments
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(speech-adjust english math
  ("28" "2 a")
  ("38" "3 a")
  ("48" "4 a")
  ("58" "5 a")
  ("81" "a 1")
  ("82" "a 2")
  ("83" "a 3")
  ("84" "a 4")
  ("85" "a 5")

  ("de de" "b d")
  ("by" "b y")
  ("my" "m y")

  ("plus 80" "plus e")
  ("power a power" "power e power")
  ("a power e" "e power e")

  ("and log" "n log")
  ("end" "and")
  ("times 10" "times n")
  ("a.m." "a n")
  ("p.m." "p n")

  ("40" "for all")
  ("408" "for all a")

  ("search that" "such that")
  ("sign" "sine")
  ("10 four" "one over")
  ("104" "one over")
  )
