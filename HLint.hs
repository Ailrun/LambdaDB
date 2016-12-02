module HLint.HLint where

import "hint" HLint.Default
import "hint" HLint.Generalise
import "hint" HLint.Builtin.All

ignore "Use list comprehesion"
ignore "Use fmap"
-- Response of Compiler, not HLint.
ignore "Parse error"
