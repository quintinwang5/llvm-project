; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch64 --mattr=+lasx < %s | FileCheck %s

declare <32 x i8> @llvm.loongarch.lasx.xvdiv.b(<32 x i8>, <32 x i8>)

define <32 x i8> @lasx_xvdiv_b(<32 x i8> %va, <32 x i8> %vb) nounwind {
; CHECK-LABEL: lasx_xvdiv_b:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvdiv.b $xr0, $xr0, $xr1
; CHECK-NEXT:    ret
entry:
  %res = call <32 x i8> @llvm.loongarch.lasx.xvdiv.b(<32 x i8> %va, <32 x i8> %vb)
  ret <32 x i8> %res
}

declare <16 x i16> @llvm.loongarch.lasx.xvdiv.h(<16 x i16>, <16 x i16>)

define <16 x i16> @lasx_xvdiv_h(<16 x i16> %va, <16 x i16> %vb) nounwind {
; CHECK-LABEL: lasx_xvdiv_h:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvdiv.h $xr0, $xr0, $xr1
; CHECK-NEXT:    ret
entry:
  %res = call <16 x i16> @llvm.loongarch.lasx.xvdiv.h(<16 x i16> %va, <16 x i16> %vb)
  ret <16 x i16> %res
}

declare <8 x i32> @llvm.loongarch.lasx.xvdiv.w(<8 x i32>, <8 x i32>)

define <8 x i32> @lasx_xvdiv_w(<8 x i32> %va, <8 x i32> %vb) nounwind {
; CHECK-LABEL: lasx_xvdiv_w:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvdiv.w $xr0, $xr0, $xr1
; CHECK-NEXT:    ret
entry:
  %res = call <8 x i32> @llvm.loongarch.lasx.xvdiv.w(<8 x i32> %va, <8 x i32> %vb)
  ret <8 x i32> %res
}

declare <4 x i64> @llvm.loongarch.lasx.xvdiv.d(<4 x i64>, <4 x i64>)

define <4 x i64> @lasx_xvdiv_d(<4 x i64> %va, <4 x i64> %vb) nounwind {
; CHECK-LABEL: lasx_xvdiv_d:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvdiv.d $xr0, $xr0, $xr1
; CHECK-NEXT:    ret
entry:
  %res = call <4 x i64> @llvm.loongarch.lasx.xvdiv.d(<4 x i64> %va, <4 x i64> %vb)
  ret <4 x i64> %res
}

declare <32 x i8> @llvm.loongarch.lasx.xvdiv.bu(<32 x i8>, <32 x i8>)

define <32 x i8> @lasx_xvdiv_bu(<32 x i8> %va, <32 x i8> %vb) nounwind {
; CHECK-LABEL: lasx_xvdiv_bu:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvdiv.bu $xr0, $xr0, $xr1
; CHECK-NEXT:    ret
entry:
  %res = call <32 x i8> @llvm.loongarch.lasx.xvdiv.bu(<32 x i8> %va, <32 x i8> %vb)
  ret <32 x i8> %res
}

declare <16 x i16> @llvm.loongarch.lasx.xvdiv.hu(<16 x i16>, <16 x i16>)

define <16 x i16> @lasx_xvdiv_hu(<16 x i16> %va, <16 x i16> %vb) nounwind {
; CHECK-LABEL: lasx_xvdiv_hu:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvdiv.hu $xr0, $xr0, $xr1
; CHECK-NEXT:    ret
entry:
  %res = call <16 x i16> @llvm.loongarch.lasx.xvdiv.hu(<16 x i16> %va, <16 x i16> %vb)
  ret <16 x i16> %res
}

declare <8 x i32> @llvm.loongarch.lasx.xvdiv.wu(<8 x i32>, <8 x i32>)

define <8 x i32> @lasx_xvdiv_wu(<8 x i32> %va, <8 x i32> %vb) nounwind {
; CHECK-LABEL: lasx_xvdiv_wu:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvdiv.wu $xr0, $xr0, $xr1
; CHECK-NEXT:    ret
entry:
  %res = call <8 x i32> @llvm.loongarch.lasx.xvdiv.wu(<8 x i32> %va, <8 x i32> %vb)
  ret <8 x i32> %res
}

declare <4 x i64> @llvm.loongarch.lasx.xvdiv.du(<4 x i64>, <4 x i64>)

define <4 x i64> @lasx_xvdiv_du(<4 x i64> %va, <4 x i64> %vb) nounwind {
; CHECK-LABEL: lasx_xvdiv_du:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvdiv.du $xr0, $xr0, $xr1
; CHECK-NEXT:    ret
entry:
  %res = call <4 x i64> @llvm.loongarch.lasx.xvdiv.du(<4 x i64> %va, <4 x i64> %vb)
  ret <4 x i64> %res
}
