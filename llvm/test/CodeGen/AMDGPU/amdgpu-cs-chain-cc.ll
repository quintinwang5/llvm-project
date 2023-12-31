; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -global-isel=1 -march=amdgcn -mcpu=gfx1100 -verify-machineinstrs < %s | FileCheck -check-prefix=GISEL-GFX11 %s
; RUN: llc -global-isel=1 -march=amdgcn -mcpu=gfx1030 -verify-machineinstrs < %s | FileCheck -check-prefix=GISEL-GFX10 %s
; RUN: llc -global-isel=0 -march=amdgcn -mcpu=gfx1100 -verify-machineinstrs < %s | FileCheck -check-prefix=DAGISEL-GFX11 %s
; RUN: llc -global-isel=0 -march=amdgcn -mcpu=gfx1030 -verify-machineinstrs < %s | FileCheck -check-prefix=DAGISEL-GFX10 %s

declare amdgpu_gfx void @use(...)

; FIXME: The values of the counters are undefined on entry to amdgpu_cs_chain functions, so these waits are unnecessary.

define amdgpu_cs_chain void @amdgpu_cs_chain_no_stack({ptr, i32, <4 x i32>} inreg %a, {ptr, i32, <4 x i32>} %b) {
; GISEL-GFX11-LABEL: amdgpu_cs_chain_no_stack:
; GISEL-GFX11:       ; %bb.0:
; GISEL-GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GISEL-GFX11-NEXT:    s_endpgm
;
; GISEL-GFX10-LABEL: amdgpu_cs_chain_no_stack:
; GISEL-GFX10:       ; %bb.0:
; GISEL-GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GISEL-GFX10-NEXT:    s_endpgm
;
; DAGISEL-GFX11-LABEL: amdgpu_cs_chain_no_stack:
; DAGISEL-GFX11:       ; %bb.0:
; DAGISEL-GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; DAGISEL-GFX11-NEXT:    s_endpgm
;
; DAGISEL-GFX10-LABEL: amdgpu_cs_chain_no_stack:
; DAGISEL-GFX10:       ; %bb.0:
; DAGISEL-GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; DAGISEL-GFX10-NEXT:    s_endpgm
  ret void
}

define amdgpu_cs_chain void @amdgpu_cs_chain_simple_call(<4 x i32> inreg %sgpr, <4 x i32> %vgpr) {
; GISEL-GFX11-LABEL: amdgpu_cs_chain_simple_call:
; GISEL-GFX11:       ; %bb.0:
; GISEL-GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GISEL-GFX11-NEXT:    s_getpc_b64 s[4:5]
; GISEL-GFX11-NEXT:    s_add_u32 s4, s4, use@gotpcrel32@lo+4
; GISEL-GFX11-NEXT:    s_addc_u32 s5, s5, use@gotpcrel32@hi+12
; GISEL-GFX11-NEXT:    v_dual_mov_b32 v4, v8 :: v_dual_mov_b32 v5, v9
; GISEL-GFX11-NEXT:    s_load_b64 s[4:5], s[4:5], 0x0
; GISEL-GFX11-NEXT:    v_dual_mov_b32 v6, v10 :: v_dual_mov_b32 v7, v11
; GISEL-GFX11-NEXT:    v_dual_mov_b32 v0, s0 :: v_dual_mov_b32 v1, s1
; GISEL-GFX11-NEXT:    v_dual_mov_b32 v2, s2 :: v_dual_mov_b32 v3, s3
; GISEL-GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GISEL-GFX11-NEXT:    s_swappc_b64 s[30:31], s[4:5]
; GISEL-GFX11-NEXT:    s_endpgm
;
; GISEL-GFX10-LABEL: amdgpu_cs_chain_simple_call:
; GISEL-GFX10:       ; %bb.0:
; GISEL-GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GISEL-GFX10-NEXT:    s_getpc_b64 s[4:5]
; GISEL-GFX10-NEXT:    s_add_u32 s4, s4, use@gotpcrel32@lo+4
; GISEL-GFX10-NEXT:    s_addc_u32 s5, s5, use@gotpcrel32@hi+12
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v4, v8
; GISEL-GFX10-NEXT:    s_load_dwordx2 s[4:5], s[4:5], 0x0
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v5, v9
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v6, v10
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v7, v11
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v0, s0
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v1, s1
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v2, s2
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v3, s3
; GISEL-GFX10-NEXT:    s_mov_b64 s[0:1], s[48:49]
; GISEL-GFX10-NEXT:    s_mov_b64 s[2:3], s[50:51]
; GISEL-GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GISEL-GFX10-NEXT:    s_swappc_b64 s[30:31], s[4:5]
; GISEL-GFX10-NEXT:    s_endpgm
;
; DAGISEL-GFX11-LABEL: amdgpu_cs_chain_simple_call:
; DAGISEL-GFX11:       ; %bb.0:
; DAGISEL-GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; DAGISEL-GFX11-NEXT:    s_getpc_b64 s[4:5]
; DAGISEL-GFX11-NEXT:    s_add_u32 s4, s4, use@gotpcrel32@lo+4
; DAGISEL-GFX11-NEXT:    s_addc_u32 s5, s5, use@gotpcrel32@hi+12
; DAGISEL-GFX11-NEXT:    v_dual_mov_b32 v7, v11 :: v_dual_mov_b32 v6, v10
; DAGISEL-GFX11-NEXT:    s_load_b64 s[4:5], s[4:5], 0x0
; DAGISEL-GFX11-NEXT:    v_dual_mov_b32 v5, v9 :: v_dual_mov_b32 v4, v8
; DAGISEL-GFX11-NEXT:    v_dual_mov_b32 v0, s0 :: v_dual_mov_b32 v1, s1
; DAGISEL-GFX11-NEXT:    v_dual_mov_b32 v2, s2 :: v_dual_mov_b32 v3, s3
; DAGISEL-GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; DAGISEL-GFX11-NEXT:    s_swappc_b64 s[30:31], s[4:5]
; DAGISEL-GFX11-NEXT:    s_endpgm
;
; DAGISEL-GFX10-LABEL: amdgpu_cs_chain_simple_call:
; DAGISEL-GFX10:       ; %bb.0:
; DAGISEL-GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; DAGISEL-GFX10-NEXT:    s_getpc_b64 s[4:5]
; DAGISEL-GFX10-NEXT:    s_add_u32 s4, s4, use@gotpcrel32@lo+4
; DAGISEL-GFX10-NEXT:    s_addc_u32 s5, s5, use@gotpcrel32@hi+12
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v7, v11
; DAGISEL-GFX10-NEXT:    s_load_dwordx2 s[4:5], s[4:5], 0x0
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v6, v10
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v5, v9
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v4, v8
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v0, s0
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v1, s1
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v2, s2
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v3, s3
; DAGISEL-GFX10-NEXT:    s_mov_b64 s[0:1], s[48:49]
; DAGISEL-GFX10-NEXT:    s_mov_b64 s[2:3], s[50:51]
; DAGISEL-GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; DAGISEL-GFX10-NEXT:    s_swappc_b64 s[30:31], s[4:5]
; DAGISEL-GFX10-NEXT:    s_endpgm
  call amdgpu_gfx void @use(<4 x i32> %sgpr, <4 x i32> %vgpr)
  ret void
}

; FIXME: Setup s32.

define amdgpu_cs_chain void @amdgpu_cs_chain_spill(<24 x i32> inreg %sgprs, <24 x i32> %vgprs) {
; GISEL-GFX11-LABEL: amdgpu_cs_chain_spill:
; GISEL-GFX11:       ; %bb.0:
; GISEL-GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GISEL-GFX11-NEXT:    s_add_u32 s24, s32, 4
; GISEL-GFX11-NEXT:    scratch_store_b32 off, v16, s32
; GISEL-GFX11-NEXT:    scratch_store_b32 off, v17, s24
; GISEL-GFX11-NEXT:    s_add_u32 s24, s32, 8
; GISEL-GFX11-NEXT:    s_add_u32 s25, s32, 12
; GISEL-GFX11-NEXT:    scratch_store_b32 off, v18, s24
; GISEL-GFX11-NEXT:    scratch_store_b32 off, v19, s25
; GISEL-GFX11-NEXT:    s_add_u32 s24, s32, 16
; GISEL-GFX11-NEXT:    s_add_u32 s25, s32, 20
; GISEL-GFX11-NEXT:    scratch_store_b32 off, v20, s24
; GISEL-GFX11-NEXT:    scratch_store_b32 off, v21, s25
; GISEL-GFX11-NEXT:    s_add_u32 s24, s32, 24
; GISEL-GFX11-NEXT:    s_add_u32 s25, s32, 28
; GISEL-GFX11-NEXT:    scratch_store_b32 off, v22, s24
; GISEL-GFX11-NEXT:    scratch_store_b32 off, v23, s25
; GISEL-GFX11-NEXT:    s_add_u32 s24, s32, 32
; GISEL-GFX11-NEXT:    s_add_u32 s25, s32, 36
; GISEL-GFX11-NEXT:    scratch_store_b32 off, v24, s24
; GISEL-GFX11-NEXT:    scratch_store_b32 off, v25, s25
; GISEL-GFX11-NEXT:    s_add_u32 s24, s32, 40
; GISEL-GFX11-NEXT:    s_add_u32 s25, s32, 44
; GISEL-GFX11-NEXT:    scratch_store_b32 off, v26, s24
; GISEL-GFX11-NEXT:    scratch_store_b32 off, v27, s25
; GISEL-GFX11-NEXT:    s_add_u32 s24, s32, 48
; GISEL-GFX11-NEXT:    s_add_u32 s25, s32, 52
; GISEL-GFX11-NEXT:    scratch_store_b32 off, v28, s24
; GISEL-GFX11-NEXT:    scratch_store_b32 off, v29, s25
; GISEL-GFX11-NEXT:    s_getpc_b64 s[24:25]
; GISEL-GFX11-NEXT:    s_add_u32 s24, s24, use@gotpcrel32@lo+4
; GISEL-GFX11-NEXT:    s_addc_u32 s25, s25, use@gotpcrel32@hi+12
; GISEL-GFX11-NEXT:    v_dual_mov_b32 v32, v8 :: v_dual_mov_b32 v33, v9
; GISEL-GFX11-NEXT:    s_load_b64 s[24:25], s[24:25], 0x0
; GISEL-GFX11-NEXT:    v_dual_mov_b32 v34, v10 :: v_dual_mov_b32 v35, v11
; GISEL-GFX11-NEXT:    v_dual_mov_b32 v36, v12 :: v_dual_mov_b32 v37, v13
; GISEL-GFX11-NEXT:    v_dual_mov_b32 v38, v14 :: v_dual_mov_b32 v39, v15
; GISEL-GFX11-NEXT:    s_add_u32 s26, s32, 56
; GISEL-GFX11-NEXT:    s_add_u32 s27, s32, 60
; GISEL-GFX11-NEXT:    scratch_store_b32 off, v30, s26
; GISEL-GFX11-NEXT:    scratch_store_b32 off, v31, s27
; GISEL-GFX11-NEXT:    v_dual_mov_b32 v0, s0 :: v_dual_mov_b32 v1, s1
; GISEL-GFX11-NEXT:    v_dual_mov_b32 v2, s2 :: v_dual_mov_b32 v3, s3
; GISEL-GFX11-NEXT:    v_dual_mov_b32 v4, s4 :: v_dual_mov_b32 v5, s5
; GISEL-GFX11-NEXT:    v_dual_mov_b32 v6, s6 :: v_dual_mov_b32 v7, s7
; GISEL-GFX11-NEXT:    v_dual_mov_b32 v8, s8 :: v_dual_mov_b32 v9, s9
; GISEL-GFX11-NEXT:    v_dual_mov_b32 v10, s10 :: v_dual_mov_b32 v11, s11
; GISEL-GFX11-NEXT:    v_dual_mov_b32 v12, s12 :: v_dual_mov_b32 v13, s13
; GISEL-GFX11-NEXT:    v_dual_mov_b32 v14, s14 :: v_dual_mov_b32 v15, s15
; GISEL-GFX11-NEXT:    v_dual_mov_b32 v16, s16 :: v_dual_mov_b32 v17, s17
; GISEL-GFX11-NEXT:    v_dual_mov_b32 v18, s18 :: v_dual_mov_b32 v19, s19
; GISEL-GFX11-NEXT:    v_dual_mov_b32 v20, s20 :: v_dual_mov_b32 v21, s21
; GISEL-GFX11-NEXT:    v_dual_mov_b32 v22, s22 :: v_dual_mov_b32 v23, s23
; GISEL-GFX11-NEXT:    v_dual_mov_b32 v24, v32 :: v_dual_mov_b32 v25, v33
; GISEL-GFX11-NEXT:    v_dual_mov_b32 v26, v34 :: v_dual_mov_b32 v27, v35
; GISEL-GFX11-NEXT:    v_dual_mov_b32 v28, v36 :: v_dual_mov_b32 v29, v37
; GISEL-GFX11-NEXT:    v_dual_mov_b32 v30, v38 :: v_dual_mov_b32 v31, v39
; GISEL-GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GISEL-GFX11-NEXT:    s_swappc_b64 s[30:31], s[24:25]
; GISEL-GFX11-NEXT:    s_endpgm
;
; GISEL-GFX10-LABEL: amdgpu_cs_chain_spill:
; GISEL-GFX10:       ; %bb.0:
; GISEL-GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GISEL-GFX10-NEXT:    s_getpc_b64 s[24:25]
; GISEL-GFX10-NEXT:    s_add_u32 s24, s24, use@gotpcrel32@lo+4
; GISEL-GFX10-NEXT:    s_addc_u32 s25, s25, use@gotpcrel32@hi+12
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v32, v8
; GISEL-GFX10-NEXT:    s_load_dwordx2 s[24:25], s[24:25], 0x0
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v33, v9
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v34, v10
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v35, v11
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v36, v12
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v37, v13
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v38, v14
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v39, v15
; GISEL-GFX10-NEXT:    buffer_store_dword v16, off, s[48:51], s32
; GISEL-GFX10-NEXT:    buffer_store_dword v17, off, s[48:51], s32 offset:4
; GISEL-GFX10-NEXT:    buffer_store_dword v18, off, s[48:51], s32 offset:8
; GISEL-GFX10-NEXT:    buffer_store_dword v19, off, s[48:51], s32 offset:12
; GISEL-GFX10-NEXT:    buffer_store_dword v20, off, s[48:51], s32 offset:16
; GISEL-GFX10-NEXT:    buffer_store_dword v21, off, s[48:51], s32 offset:20
; GISEL-GFX10-NEXT:    buffer_store_dword v22, off, s[48:51], s32 offset:24
; GISEL-GFX10-NEXT:    buffer_store_dword v23, off, s[48:51], s32 offset:28
; GISEL-GFX10-NEXT:    buffer_store_dword v24, off, s[48:51], s32 offset:32
; GISEL-GFX10-NEXT:    buffer_store_dword v25, off, s[48:51], s32 offset:36
; GISEL-GFX10-NEXT:    buffer_store_dword v26, off, s[48:51], s32 offset:40
; GISEL-GFX10-NEXT:    buffer_store_dword v27, off, s[48:51], s32 offset:44
; GISEL-GFX10-NEXT:    buffer_store_dword v28, off, s[48:51], s32 offset:48
; GISEL-GFX10-NEXT:    buffer_store_dword v29, off, s[48:51], s32 offset:52
; GISEL-GFX10-NEXT:    buffer_store_dword v30, off, s[48:51], s32 offset:56
; GISEL-GFX10-NEXT:    buffer_store_dword v31, off, s[48:51], s32 offset:60
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v0, s0
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v1, s1
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v2, s2
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v3, s3
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v4, s4
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v5, s5
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v6, s6
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v7, s7
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v8, s8
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v9, s9
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v10, s10
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v11, s11
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v12, s12
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v13, s13
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v14, s14
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v15, s15
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v16, s16
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v17, s17
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v18, s18
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v19, s19
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v20, s20
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v21, s21
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v22, s22
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v23, s23
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v24, v32
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v25, v33
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v26, v34
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v27, v35
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v28, v36
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v29, v37
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v30, v38
; GISEL-GFX10-NEXT:    v_mov_b32_e32 v31, v39
; GISEL-GFX10-NEXT:    s_mov_b64 s[0:1], s[48:49]
; GISEL-GFX10-NEXT:    s_mov_b64 s[2:3], s[50:51]
; GISEL-GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GISEL-GFX10-NEXT:    s_swappc_b64 s[30:31], s[24:25]
; GISEL-GFX10-NEXT:    s_endpgm
;
; DAGISEL-GFX11-LABEL: amdgpu_cs_chain_spill:
; DAGISEL-GFX11:       ; %bb.0:
; DAGISEL-GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; DAGISEL-GFX11-NEXT:    s_add_i32 s24, s32, 60
; DAGISEL-GFX11-NEXT:    scratch_store_b32 off, v16, s32
; DAGISEL-GFX11-NEXT:    scratch_store_b32 off, v31, s24
; DAGISEL-GFX11-NEXT:    s_add_i32 s24, s32, 56
; DAGISEL-GFX11-NEXT:    s_add_i32 s25, s32, 52
; DAGISEL-GFX11-NEXT:    scratch_store_b32 off, v30, s24
; DAGISEL-GFX11-NEXT:    scratch_store_b32 off, v29, s25
; DAGISEL-GFX11-NEXT:    s_add_i32 s24, s32, 48
; DAGISEL-GFX11-NEXT:    s_add_i32 s25, s32, 44
; DAGISEL-GFX11-NEXT:    scratch_store_b32 off, v28, s24
; DAGISEL-GFX11-NEXT:    scratch_store_b32 off, v27, s25
; DAGISEL-GFX11-NEXT:    s_add_i32 s24, s32, 40
; DAGISEL-GFX11-NEXT:    s_add_i32 s25, s32, 36
; DAGISEL-GFX11-NEXT:    scratch_store_b32 off, v26, s24
; DAGISEL-GFX11-NEXT:    scratch_store_b32 off, v25, s25
; DAGISEL-GFX11-NEXT:    s_add_i32 s24, s32, 32
; DAGISEL-GFX11-NEXT:    s_add_i32 s25, s32, 28
; DAGISEL-GFX11-NEXT:    scratch_store_b32 off, v24, s24
; DAGISEL-GFX11-NEXT:    scratch_store_b32 off, v23, s25
; DAGISEL-GFX11-NEXT:    s_add_i32 s24, s32, 24
; DAGISEL-GFX11-NEXT:    s_add_i32 s25, s32, 20
; DAGISEL-GFX11-NEXT:    scratch_store_b32 off, v22, s24
; DAGISEL-GFX11-NEXT:    scratch_store_b32 off, v21, s25
; DAGISEL-GFX11-NEXT:    s_add_i32 s24, s32, 16
; DAGISEL-GFX11-NEXT:    s_add_i32 s25, s32, 12
; DAGISEL-GFX11-NEXT:    scratch_store_b32 off, v20, s24
; DAGISEL-GFX11-NEXT:    scratch_store_b32 off, v19, s25
; DAGISEL-GFX11-NEXT:    s_getpc_b64 s[24:25]
; DAGISEL-GFX11-NEXT:    s_add_u32 s24, s24, use@gotpcrel32@lo+4
; DAGISEL-GFX11-NEXT:    s_addc_u32 s25, s25, use@gotpcrel32@hi+12
; DAGISEL-GFX11-NEXT:    v_dual_mov_b32 v32, v15 :: v_dual_mov_b32 v33, v14
; DAGISEL-GFX11-NEXT:    s_load_b64 s[24:25], s[24:25], 0x0
; DAGISEL-GFX11-NEXT:    v_dual_mov_b32 v34, v13 :: v_dual_mov_b32 v35, v12
; DAGISEL-GFX11-NEXT:    v_dual_mov_b32 v36, v11 :: v_dual_mov_b32 v37, v10
; DAGISEL-GFX11-NEXT:    v_dual_mov_b32 v38, v9 :: v_dual_mov_b32 v39, v8
; DAGISEL-GFX11-NEXT:    s_add_i32 s26, s32, 8
; DAGISEL-GFX11-NEXT:    s_add_i32 s27, s32, 4
; DAGISEL-GFX11-NEXT:    scratch_store_b32 off, v18, s26
; DAGISEL-GFX11-NEXT:    scratch_store_b32 off, v17, s27
; DAGISEL-GFX11-NEXT:    v_dual_mov_b32 v0, s0 :: v_dual_mov_b32 v1, s1
; DAGISEL-GFX11-NEXT:    v_dual_mov_b32 v2, s2 :: v_dual_mov_b32 v3, s3
; DAGISEL-GFX11-NEXT:    v_dual_mov_b32 v4, s4 :: v_dual_mov_b32 v5, s5
; DAGISEL-GFX11-NEXT:    v_dual_mov_b32 v6, s6 :: v_dual_mov_b32 v7, s7
; DAGISEL-GFX11-NEXT:    v_dual_mov_b32 v8, s8 :: v_dual_mov_b32 v9, s9
; DAGISEL-GFX11-NEXT:    v_dual_mov_b32 v10, s10 :: v_dual_mov_b32 v11, s11
; DAGISEL-GFX11-NEXT:    v_dual_mov_b32 v12, s12 :: v_dual_mov_b32 v13, s13
; DAGISEL-GFX11-NEXT:    v_dual_mov_b32 v14, s14 :: v_dual_mov_b32 v15, s15
; DAGISEL-GFX11-NEXT:    v_dual_mov_b32 v16, s16 :: v_dual_mov_b32 v17, s17
; DAGISEL-GFX11-NEXT:    v_dual_mov_b32 v18, s18 :: v_dual_mov_b32 v19, s19
; DAGISEL-GFX11-NEXT:    v_dual_mov_b32 v20, s20 :: v_dual_mov_b32 v21, s21
; DAGISEL-GFX11-NEXT:    v_dual_mov_b32 v22, s22 :: v_dual_mov_b32 v23, s23
; DAGISEL-GFX11-NEXT:    v_dual_mov_b32 v24, v39 :: v_dual_mov_b32 v25, v38
; DAGISEL-GFX11-NEXT:    v_dual_mov_b32 v26, v37 :: v_dual_mov_b32 v27, v36
; DAGISEL-GFX11-NEXT:    v_dual_mov_b32 v28, v35 :: v_dual_mov_b32 v29, v34
; DAGISEL-GFX11-NEXT:    v_dual_mov_b32 v30, v33 :: v_dual_mov_b32 v31, v32
; DAGISEL-GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; DAGISEL-GFX11-NEXT:    s_swappc_b64 s[30:31], s[24:25]
; DAGISEL-GFX11-NEXT:    s_endpgm
;
; DAGISEL-GFX10-LABEL: amdgpu_cs_chain_spill:
; DAGISEL-GFX10:       ; %bb.0:
; DAGISEL-GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; DAGISEL-GFX10-NEXT:    s_getpc_b64 s[24:25]
; DAGISEL-GFX10-NEXT:    s_add_u32 s24, s24, use@gotpcrel32@lo+4
; DAGISEL-GFX10-NEXT:    s_addc_u32 s25, s25, use@gotpcrel32@hi+12
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v32, v15
; DAGISEL-GFX10-NEXT:    s_load_dwordx2 s[24:25], s[24:25], 0x0
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v33, v14
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v34, v13
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v35, v12
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v36, v11
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v37, v10
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v38, v9
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v39, v8
; DAGISEL-GFX10-NEXT:    buffer_store_dword v16, off, s[48:51], s32
; DAGISEL-GFX10-NEXT:    buffer_store_dword v17, off, s[48:51], s32 offset:4
; DAGISEL-GFX10-NEXT:    buffer_store_dword v18, off, s[48:51], s32 offset:8
; DAGISEL-GFX10-NEXT:    buffer_store_dword v19, off, s[48:51], s32 offset:12
; DAGISEL-GFX10-NEXT:    buffer_store_dword v20, off, s[48:51], s32 offset:16
; DAGISEL-GFX10-NEXT:    buffer_store_dword v21, off, s[48:51], s32 offset:20
; DAGISEL-GFX10-NEXT:    buffer_store_dword v22, off, s[48:51], s32 offset:24
; DAGISEL-GFX10-NEXT:    buffer_store_dword v23, off, s[48:51], s32 offset:28
; DAGISEL-GFX10-NEXT:    buffer_store_dword v24, off, s[48:51], s32 offset:32
; DAGISEL-GFX10-NEXT:    buffer_store_dword v25, off, s[48:51], s32 offset:36
; DAGISEL-GFX10-NEXT:    buffer_store_dword v26, off, s[48:51], s32 offset:40
; DAGISEL-GFX10-NEXT:    buffer_store_dword v27, off, s[48:51], s32 offset:44
; DAGISEL-GFX10-NEXT:    buffer_store_dword v28, off, s[48:51], s32 offset:48
; DAGISEL-GFX10-NEXT:    buffer_store_dword v29, off, s[48:51], s32 offset:52
; DAGISEL-GFX10-NEXT:    buffer_store_dword v30, off, s[48:51], s32 offset:56
; DAGISEL-GFX10-NEXT:    buffer_store_dword v31, off, s[48:51], s32 offset:60
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v0, s0
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v1, s1
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v2, s2
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v3, s3
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v4, s4
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v5, s5
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v6, s6
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v7, s7
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v8, s8
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v9, s9
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v10, s10
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v11, s11
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v12, s12
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v13, s13
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v14, s14
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v15, s15
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v16, s16
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v17, s17
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v18, s18
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v19, s19
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v20, s20
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v21, s21
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v22, s22
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v23, s23
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v24, v39
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v25, v38
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v26, v37
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v27, v36
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v28, v35
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v29, v34
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v30, v33
; DAGISEL-GFX10-NEXT:    v_mov_b32_e32 v31, v32
; DAGISEL-GFX10-NEXT:    s_mov_b64 s[0:1], s[48:49]
; DAGISEL-GFX10-NEXT:    s_mov_b64 s[2:3], s[50:51]
; DAGISEL-GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; DAGISEL-GFX10-NEXT:    s_swappc_b64 s[30:31], s[24:25]
; DAGISEL-GFX10-NEXT:    s_endpgm
  call amdgpu_gfx void @use(<24 x i32> %sgprs, <24 x i32> %vgprs)
  ret void
}
