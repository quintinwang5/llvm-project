; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes='lower-matrix-intrinsics' -S < %s | FileCheck %s


define <4 x float> @multiply_2x2(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: @multiply_2x2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SPLIT:%.*]] = shufflevector <4 x float> [[A:%.*]], <4 x float> poison, <2 x i32> <i32 0, i32 1>
; CHECK-NEXT:    [[SPLIT1:%.*]] = shufflevector <4 x float> [[A]], <4 x float> poison, <2 x i32> <i32 2, i32 3>
; CHECK-NEXT:    [[SPLIT2:%.*]] = shufflevector <4 x float> [[B:%.*]], <4 x float> poison, <2 x i32> <i32 0, i32 1>
; CHECK-NEXT:    [[SPLIT3:%.*]] = shufflevector <4 x float> [[B]], <4 x float> poison, <2 x i32> <i32 2, i32 3>
; CHECK-NEXT:    [[BLOCK:%.*]] = shufflevector <2 x float> [[SPLIT]], <2 x float> poison, <1 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP0:%.*]] = extractelement <2 x float> [[SPLIT2]], i64 0
; CHECK-NEXT:    [[SPLAT_SPLATINSERT:%.*]] = insertelement <1 x float> poison, float [[TMP0]], i64 0
; CHECK-NEXT:    [[SPLAT_SPLAT:%.*]] = shufflevector <1 x float> [[SPLAT_SPLATINSERT]], <1 x float> poison, <1 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP1:%.*]] = fmul contract <1 x float> [[BLOCK]], [[SPLAT_SPLAT]]
; CHECK-NEXT:    [[BLOCK4:%.*]] = shufflevector <2 x float> [[SPLIT1]], <2 x float> poison, <1 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP2:%.*]] = extractelement <2 x float> [[SPLIT2]], i64 1
; CHECK-NEXT:    [[SPLAT_SPLATINSERT5:%.*]] = insertelement <1 x float> poison, float [[TMP2]], i64 0
; CHECK-NEXT:    [[SPLAT_SPLAT6:%.*]] = shufflevector <1 x float> [[SPLAT_SPLATINSERT5]], <1 x float> poison, <1 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP3:%.*]] = call contract <1 x float> @llvm.fmuladd.v1f32(<1 x float> [[BLOCK4]], <1 x float> [[SPLAT_SPLAT6]], <1 x float> [[TMP1]])
; CHECK-NEXT:    [[TMP4:%.*]] = shufflevector <1 x float> [[TMP3]], <1 x float> poison, <2 x i32> <i32 0, i32 poison>
; CHECK-NEXT:    [[TMP5:%.*]] = shufflevector <2 x float> poison, <2 x float> [[TMP4]], <2 x i32> <i32 2, i32 1>
; CHECK-NEXT:    [[BLOCK7:%.*]] = shufflevector <2 x float> [[SPLIT]], <2 x float> poison, <1 x i32> <i32 1>
; CHECK-NEXT:    [[TMP6:%.*]] = extractelement <2 x float> [[SPLIT2]], i64 0
; CHECK-NEXT:    [[SPLAT_SPLATINSERT8:%.*]] = insertelement <1 x float> poison, float [[TMP6]], i64 0
; CHECK-NEXT:    [[SPLAT_SPLAT9:%.*]] = shufflevector <1 x float> [[SPLAT_SPLATINSERT8]], <1 x float> poison, <1 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP7:%.*]] = fmul contract <1 x float> [[BLOCK7]], [[SPLAT_SPLAT9]]
; CHECK-NEXT:    [[BLOCK10:%.*]] = shufflevector <2 x float> [[SPLIT1]], <2 x float> poison, <1 x i32> <i32 1>
; CHECK-NEXT:    [[TMP8:%.*]] = extractelement <2 x float> [[SPLIT2]], i64 1
; CHECK-NEXT:    [[SPLAT_SPLATINSERT11:%.*]] = insertelement <1 x float> poison, float [[TMP8]], i64 0
; CHECK-NEXT:    [[SPLAT_SPLAT12:%.*]] = shufflevector <1 x float> [[SPLAT_SPLATINSERT11]], <1 x float> poison, <1 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP9:%.*]] = call contract <1 x float> @llvm.fmuladd.v1f32(<1 x float> [[BLOCK10]], <1 x float> [[SPLAT_SPLAT12]], <1 x float> [[TMP7]])
; CHECK-NEXT:    [[TMP10:%.*]] = shufflevector <1 x float> [[TMP9]], <1 x float> poison, <2 x i32> <i32 0, i32 poison>
; CHECK-NEXT:    [[TMP11:%.*]] = shufflevector <2 x float> [[TMP5]], <2 x float> [[TMP10]], <2 x i32> <i32 0, i32 2>
; CHECK-NEXT:    [[BLOCK13:%.*]] = shufflevector <2 x float> [[SPLIT]], <2 x float> poison, <1 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP12:%.*]] = extractelement <2 x float> [[SPLIT3]], i64 0
; CHECK-NEXT:    [[SPLAT_SPLATINSERT14:%.*]] = insertelement <1 x float> poison, float [[TMP12]], i64 0
; CHECK-NEXT:    [[SPLAT_SPLAT15:%.*]] = shufflevector <1 x float> [[SPLAT_SPLATINSERT14]], <1 x float> poison, <1 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP13:%.*]] = fmul contract <1 x float> [[BLOCK13]], [[SPLAT_SPLAT15]]
; CHECK-NEXT:    [[BLOCK16:%.*]] = shufflevector <2 x float> [[SPLIT1]], <2 x float> poison, <1 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP14:%.*]] = extractelement <2 x float> [[SPLIT3]], i64 1
; CHECK-NEXT:    [[SPLAT_SPLATINSERT17:%.*]] = insertelement <1 x float> poison, float [[TMP14]], i64 0
; CHECK-NEXT:    [[SPLAT_SPLAT18:%.*]] = shufflevector <1 x float> [[SPLAT_SPLATINSERT17]], <1 x float> poison, <1 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP15:%.*]] = call contract <1 x float> @llvm.fmuladd.v1f32(<1 x float> [[BLOCK16]], <1 x float> [[SPLAT_SPLAT18]], <1 x float> [[TMP13]])
; CHECK-NEXT:    [[TMP16:%.*]] = shufflevector <1 x float> [[TMP15]], <1 x float> poison, <2 x i32> <i32 0, i32 poison>
; CHECK-NEXT:    [[TMP17:%.*]] = shufflevector <2 x float> poison, <2 x float> [[TMP16]], <2 x i32> <i32 2, i32 1>
; CHECK-NEXT:    [[BLOCK19:%.*]] = shufflevector <2 x float> [[SPLIT]], <2 x float> poison, <1 x i32> <i32 1>
; CHECK-NEXT:    [[TMP18:%.*]] = extractelement <2 x float> [[SPLIT3]], i64 0
; CHECK-NEXT:    [[SPLAT_SPLATINSERT20:%.*]] = insertelement <1 x float> poison, float [[TMP18]], i64 0
; CHECK-NEXT:    [[SPLAT_SPLAT21:%.*]] = shufflevector <1 x float> [[SPLAT_SPLATINSERT20]], <1 x float> poison, <1 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP19:%.*]] = fmul contract <1 x float> [[BLOCK19]], [[SPLAT_SPLAT21]]
; CHECK-NEXT:    [[BLOCK22:%.*]] = shufflevector <2 x float> [[SPLIT1]], <2 x float> poison, <1 x i32> <i32 1>
; CHECK-NEXT:    [[TMP20:%.*]] = extractelement <2 x float> [[SPLIT3]], i64 1
; CHECK-NEXT:    [[SPLAT_SPLATINSERT23:%.*]] = insertelement <1 x float> poison, float [[TMP20]], i64 0
; CHECK-NEXT:    [[SPLAT_SPLAT24:%.*]] = shufflevector <1 x float> [[SPLAT_SPLATINSERT23]], <1 x float> poison, <1 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP21:%.*]] = call contract <1 x float> @llvm.fmuladd.v1f32(<1 x float> [[BLOCK22]], <1 x float> [[SPLAT_SPLAT24]], <1 x float> [[TMP19]])
; CHECK-NEXT:    [[TMP22:%.*]] = shufflevector <1 x float> [[TMP21]], <1 x float> poison, <2 x i32> <i32 0, i32 poison>
; CHECK-NEXT:    [[TMP23:%.*]] = shufflevector <2 x float> [[TMP17]], <2 x float> [[TMP22]], <2 x i32> <i32 0, i32 2>
; CHECK-NEXT:    [[TMP24:%.*]] = shufflevector <2 x float> [[TMP11]], <2 x float> [[TMP23]], <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    ret <4 x float> [[TMP24]]
;
entry:
  %c = call contract <4 x float> @llvm.matrix.multiply.v4f32.v4f32.v4f32(<4 x float> %a, <4 x float> %b, i32 2, i32 2, i32 2)
  ret <4 x float> %c
}

declare <4 x float> @llvm.matrix.multiply.v4f32.v4f32.v4f32(<4 x float>, <4 x float>, i32, i32, i32)
