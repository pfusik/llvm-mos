; REQUIRES: x86
; RUN: opt -module-summary %s -o %t.o

; Test debug-pass-manager option
; RUN: ld.lld --plugin-opt=debug-pass-manager -o /dev/null %t.o 2>&1 | FileCheck %s
; RUN: ld.lld --lto-debug-pass-manager -o /dev/null %t.o 2>&1 | FileCheck %s

; CHECK: Running pass: GlobalOptPass

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @foo() {
  ret void
}
