; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc < %s -mtriple riscv64 -mattr=+zve64x | FileCheck %s

define void @bar(ptr %p) {
; CHECK-LABEL: bar:
; CHECK:       # %bb.0:
; CHECK-NEXT:    sd zero, 0(a0)
; CHECK-NEXT:    sd zero, 8(a0)
; CHECK-NEXT:    ret
  %v = insertelement <64 x i64> zeroinitializer, i64 0, i32 0
  %trunc = trunc <64 x i64> %v to <64 x i1>
  %p1 = getelementptr i8, ptr %p, i32 0
  %p2 = getelementptr i8, ptr %p, i32 8
  store <64 x i1> %trunc, ptr %p1
  store <8 x i8> zeroinitializer, ptr %p2
  ret void
}
