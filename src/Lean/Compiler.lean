/-
Copyright (c) 2019 Microsoft Corporation. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Leonardo de Moura
-/
prelude
import Lean.Compiler.InlineAttrs
import Lean.Compiler.Specialize
import Lean.Compiler.ClosedTermCache
import Lean.Compiler.ExternAttr
import Lean.Compiler.ImplementedByAttr
import Lean.Compiler.NeverExtractAttr
import Lean.Compiler.IR
import Lean.Compiler.CSimpAttr
import Lean.Compiler.FFI
import Lean.Compiler.MetaAttr
import Lean.Compiler.NoncomputableAttr
import Lean.Compiler.Main
import Lean.Compiler.Old -- TODO: delete after we port code generator to Lean
