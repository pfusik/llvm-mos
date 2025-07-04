; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -O2 --filetype=asm -zp-avail=224 < %s | FileCheck %s

target datalayout = "e-m:e-p:16:8-p1:8:8-i16:8-i32:8-i64:8-f32:8-f64:8-a:8-Fi8-n8"
target triple = "mos-sim"

@global = global i8 0, align 1
@global_noinit = global i8 undef, align 1
@global_alias = alias i8, ptr @global_noinit

define i64 @foo(i64 %live_across_call) norecurse {
; CHECK-LABEL: foo:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    sta mos8(.Lfoo_zp_stk) ; 1-byte Folded Spill
; CHECK-NEXT:    stx mos8(.Lfoo_zp_stk+1) ; 1-byte Folded Spill
; CHECK-NEXT:    ldx __rc2
; CHECK-NEXT:    stx mos8(.Lfoo_zp_stk+2) ; 1-byte Folded Spill
; CHECK-NEXT:    ldx __rc3
; CHECK-NEXT:    stx mos8(.Lfoo_zp_stk+3) ; 1-byte Folded Spill
; CHECK-NEXT:    ldx __rc4
; CHECK-NEXT:    stx mos8(.Lfoo_zp_stk+4) ; 1-byte Folded Spill
; CHECK-NEXT:    ldx __rc5
; CHECK-NEXT:    stx mos8(.Lfoo_zp_stk+5) ; 1-byte Folded Spill
; CHECK-NEXT:    ldx __rc6
; CHECK-NEXT:    stx mos8(.Lfoo_zp_stk+6) ; 1-byte Folded Spill
; CHECK-NEXT:    ldx __rc7
; CHECK-NEXT:    stx mos8(.Lfoo_zp_stk+7) ; 1-byte Folded Spill
; CHECK-NEXT:    ldx global
; CHECK-NEXT:    stx mos8(global_noinit)
; CHECK-NEXT:    jsr bar
; CHECK-NEXT:    ldx mos8(.Lfoo_zp_stk+2) ; 1-byte Folded Reload
; CHECK-NEXT:    stx __rc2
; CHECK-NEXT:    ldx mos8(.Lfoo_zp_stk+3) ; 1-byte Folded Reload
; CHECK-NEXT:    stx __rc3
; CHECK-NEXT:    ldx mos8(.Lfoo_zp_stk+4) ; 1-byte Folded Reload
; CHECK-NEXT:    stx __rc4
; CHECK-NEXT:    ldx mos8(.Lfoo_zp_stk+5) ; 1-byte Folded Reload
; CHECK-NEXT:    stx __rc5
; CHECK-NEXT:    ldx mos8(.Lfoo_zp_stk+6) ; 1-byte Folded Reload
; CHECK-NEXT:    stx __rc6
; CHECK-NEXT:    ldx mos8(.Lfoo_zp_stk+7) ; 1-byte Folded Reload
; CHECK-NEXT:    stx __rc7
; CHECK-NEXT:    ldx mos8(.Lfoo_zp_stk+1) ; 1-byte Folded Reload
; CHECK-NEXT:    lda mos8(.Lfoo_zp_stk) ; 1-byte Folded Reload
; CHECK-NEXT:    rts
entry:
  %0 = load i8, ptr @global, align 1
  store i8 %0, ptr @global_noinit, align 1
  call void @bar()
  ret i64 %live_across_call
}

define void @bar() norecurse noinline {
; CHECK-LABEL: bar:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    ldx global
; CHECK-NEXT:    stx mos8(global_alias)
; CHECK-NEXT:    rts
entry:
  %0 = load i8, ptr @global, align 1
  store i8 %0, ptr @global_alias, align 1
  ret void
}

declare void @ext() nocallback

define void @csr() norecurse {
; CHECK-LABEL: csr:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    ldx #48
; CHECK-NEXT:    ldy #57
; CHECK-NEXT:    sty mos8(.Lcsr_zp_stk)
; CHECK-NEXT:    stx mos8(.Lcsr_zp_stk+1)
; CHECK-NEXT:    jmp .LBB2_2
; CHECK-NEXT:  .LBB2_1: ; %for.body
; CHECK-NEXT:    ; in Loop: Header=BB2_2 Depth=1
; CHECK-NEXT:    lda mos8(.Lcsr_zp_stk+1)
; CHECK-NEXT:    beq .LBB2_4
; CHECK-NEXT:  .LBB2_2: ; %for.body
; CHECK-NEXT:    ; =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    jsr ext
; CHECK-NEXT:    ldx #255
; CHECK-NEXT:    dec mos8(.Lcsr_zp_stk)
; CHECK-NEXT:    cpx mos8(.Lcsr_zp_stk)
; CHECK-NEXT:    bne .LBB2_1
; CHECK-NEXT:  ; %bb.3: ; %for.body
; CHECK-NEXT:    ; in Loop: Header=BB2_2 Depth=1
; CHECK-NEXT:    dec mos8(.Lcsr_zp_stk+1)
; CHECK-NEXT:    jmp .LBB2_1
; CHECK-NEXT:  .LBB2_4: ; %for.body
; CHECK-NEXT:    ; in Loop: Header=BB2_2 Depth=1
; CHECK-NEXT:    lda mos8(.Lcsr_zp_stk)
; CHECK-NEXT:    bne .LBB2_2
; CHECK-NEXT:  ; %bb.5: ; %for.cond.cleanup
; CHECK-NEXT:    rts
entry:
  br label %for.body

for.cond.cleanup:
  ret void

for.body:
  %i = phi i16 [ 0, %entry ], [ %inc1, %for.body ]
  tail call void @ext()
  %inc1 = add i16 %i, 1
  %exitcond.not = icmp eq i16 %inc1, 12345
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body
}

declare void @ext_ptr(ptr %p) nocallback

define void @alloca() norecurse {
; CHECK-LABEL: alloca:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    ldx #mos8(.Lalloca_zp_stk)
; CHECK-NEXT:    ldy #mos8(0)
; CHECK-NEXT:    stx __rc2
; CHECK-NEXT:    sty __rc3
; CHECK-NEXT:    jmp ext_ptr
entry:
  %0 = alloca i8
  call void @ext_ptr(ptr %0)
  ret void
}

@extern_global = external dso_local global i8

define void @extern_global_user(i8 %i) norecurse {
; CHECK-LABEL: extern_global_user:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    sta extern_global
; CHECK-NEXT:    rts
entry:
  store volatile i8 %i, ptr @extern_global, align 1
  ret void
}

@vol = global i8 undef, align 1

define void @inr() norecurse "interrupt-norecurse" {
; CHECK-LABEL: inr:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    cld
; CHECK-NEXT:    pha
; CHECK-NEXT:    clc
; CHECK-NEXT:    lda __rc1
; CHECK-NEXT:    adc #255
; CHECK-NEXT:    sta __rc1
; CHECK-NEXT:    pla
; CHECK-NEXT:    pha
; CHECK-NEXT:    txa
; CHECK-NEXT:    pha
; CHECK-NEXT:    tya
; CHECK-NEXT:    pha
; CHECK-NEXT:    lda __rc2
; CHECK-NEXT:    pha
; CHECK-NEXT:    ldx __rc3
; CHECK-NEXT:    stx .Linr_sstk ; 1-byte Folded Spill
; CHECK-NEXT:    ldx __rc4
; CHECK-NEXT:    stx .Linr_sstk+1 ; 1-byte Folded Spill
; CHECK-NEXT:    ldx __rc5
; CHECK-NEXT:    stx .Linr_sstk+2 ; 1-byte Folded Spill
; CHECK-NEXT:    ldx __rc6
; CHECK-NEXT:    stx .Linr_sstk+3 ; 1-byte Folded Spill
; CHECK-NEXT:    ldx __rc7
; CHECK-NEXT:    stx .Linr_sstk+4 ; 1-byte Folded Spill
; CHECK-NEXT:    ldx __rc8
; CHECK-NEXT:    stx .Linr_sstk+5 ; 1-byte Folded Spill
; CHECK-NEXT:    ldx __rc9
; CHECK-NEXT:    stx .Linr_sstk+6 ; 1-byte Folded Spill
; CHECK-NEXT:    ldx __rc10
; CHECK-NEXT:    stx .Linr_sstk+7 ; 1-byte Folded Spill
; CHECK-NEXT:    ldx __rc11
; CHECK-NEXT:    stx .Linr_sstk+8 ; 1-byte Folded Spill
; CHECK-NEXT:    ldx __rc12
; CHECK-NEXT:    stx .Linr_sstk+9 ; 1-byte Folded Spill
; CHECK-NEXT:    ldx __rc13
; CHECK-NEXT:    stx .Linr_sstk+10 ; 1-byte Folded Spill
; CHECK-NEXT:    ldx __rc14
; CHECK-NEXT:    stx .Linr_sstk+11 ; 1-byte Folded Spill
; CHECK-NEXT:    ldx __rc15
; CHECK-NEXT:    stx .Linr_sstk+12 ; 1-byte Folded Spill
; CHECK-NEXT:    ldx __rc16
; CHECK-NEXT:    stx .Linr_sstk+13 ; 1-byte Folded Spill
; CHECK-NEXT:    ldx __rc17
; CHECK-NEXT:    stx .Linr_sstk+14 ; 1-byte Folded Spill
; CHECK-NEXT:    ldx __rc18
; CHECK-NEXT:    stx .Linr_sstk+15 ; 1-byte Folded Spill
; CHECK-NEXT:    ldx __rc19
; CHECK-NEXT:    stx .Linr_sstk+16 ; 1-byte Folded Spill
; CHECK-NEXT:    ldx global
; CHECK-NEXT:    stx mos8(.Linr_zp_stk) ; 1-byte Folded Spill
; CHECK-NEXT:    jsr inr_callee
; CHECK-NEXT:    ldx mos8(.Linr_zp_stk) ; 1-byte Folded Reload
; CHECK-NEXT:    stx mos8(vol)
; CHECK-NEXT:    ldx .Linr_sstk+16 ; 1-byte Folded Reload
; CHECK-NEXT:    stx __rc19
; CHECK-NEXT:    ldx .Linr_sstk+15 ; 1-byte Folded Reload
; CHECK-NEXT:    stx __rc18
; CHECK-NEXT:    ldx .Linr_sstk+14 ; 1-byte Folded Reload
; CHECK-NEXT:    stx __rc17
; CHECK-NEXT:    ldx .Linr_sstk+13 ; 1-byte Folded Reload
; CHECK-NEXT:    stx __rc16
; CHECK-NEXT:    ldx .Linr_sstk+12 ; 1-byte Folded Reload
; CHECK-NEXT:    stx __rc15
; CHECK-NEXT:    ldx .Linr_sstk+11 ; 1-byte Folded Reload
; CHECK-NEXT:    stx __rc14
; CHECK-NEXT:    ldx .Linr_sstk+10 ; 1-byte Folded Reload
; CHECK-NEXT:    stx __rc13
; CHECK-NEXT:    ldx .Linr_sstk+9 ; 1-byte Folded Reload
; CHECK-NEXT:    stx __rc12
; CHECK-NEXT:    ldx .Linr_sstk+8 ; 1-byte Folded Reload
; CHECK-NEXT:    stx __rc11
; CHECK-NEXT:    ldx .Linr_sstk+7 ; 1-byte Folded Reload
; CHECK-NEXT:    stx __rc10
; CHECK-NEXT:    ldx .Linr_sstk+6 ; 1-byte Folded Reload
; CHECK-NEXT:    stx __rc9
; CHECK-NEXT:    ldx .Linr_sstk+5 ; 1-byte Folded Reload
; CHECK-NEXT:    stx __rc8
; CHECK-NEXT:    ldx .Linr_sstk+4 ; 1-byte Folded Reload
; CHECK-NEXT:    stx __rc7
; CHECK-NEXT:    ldx .Linr_sstk+3 ; 1-byte Folded Reload
; CHECK-NEXT:    stx __rc6
; CHECK-NEXT:    ldx .Linr_sstk+2 ; 1-byte Folded Reload
; CHECK-NEXT:    stx __rc5
; CHECK-NEXT:    ldx .Linr_sstk+1 ; 1-byte Folded Reload
; CHECK-NEXT:    stx __rc4
; CHECK-NEXT:    ldx .Linr_sstk ; 1-byte Folded Reload
; CHECK-NEXT:    stx __rc3
; CHECK-NEXT:    pla
; CHECK-NEXT:    sta __rc2
; CHECK-NEXT:    pla
; CHECK-NEXT:    tay
; CHECK-NEXT:    pla
; CHECK-NEXT:    tax
; CHECK-NEXT:    pla
; CHECK-NEXT:    pha
; CHECK-NEXT:    clc
; CHECK-NEXT:    lda __rc1
; CHECK-NEXT:    adc #1
; CHECK-NEXT:    sta __rc1
; CHECK-NEXT:    pla
; CHECK-NEXT:    rti
entry:
  %0 = load i8, ptr @global, align 1
  call void @inr_callee();
  store volatile i8 %0, ptr @vol, align 1
  ret void
}

define void @inr_callee() norecurse noinline {
; CHECK-LABEL: inr_callee:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    rts
entry:
  ret void
}

declare void @ext_callback()

define void @apparent_recursion() norecurse {
; CHECK-LABEL: apparent_recursion:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    ldx global
; CHECK-NEXT:    stx mos8(.Lapparent_recursion_zp_stk) ; 1-byte Folded Spill
; CHECK-NEXT:    jsr apparent_recursion_callee
; CHECK-NEXT:    ldx mos8(.Lapparent_recursion_zp_stk) ; 1-byte Folded Reload
; CHECK-NEXT:    stx mos8(vol)
; CHECK-NEXT:    rts
entry:
  %0 = load i8, ptr @global, align 1
  call void @apparent_recursion_callee()
  store volatile i8 %0, ptr @vol, align 1
  ret void
}

define void @apparent_recursion_callee() norecurse {
; CHECK-LABEL: apparent_recursion_callee:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    ldx global
; CHECK-NEXT:    stx mos8(.Lapparent_recursion_callee_zp_stk) ; 1-byte Folded Spill
; CHECK-NEXT:    jsr ext_callback
; CHECK-NEXT:    ldx mos8(.Lapparent_recursion_callee_zp_stk) ; 1-byte Folded Reload
; CHECK-NEXT:    stx mos8(vol)
; CHECK-NEXT:    rts
entry:
  %0 = load i8, ptr @global, align 1
  call void @ext_callback()
  store volatile i8 %0, ptr @vol, align 1
  ret void
}

; CHECK-LABEL: .type global,@object
; CHECK-NEXT:  .bss
; CHECK-LABEL: .type global_noinit,@object
; CHECK-NEXT:  .zp.noinit

; CHECK-LABEL: .Lzp_stack:
; CHECK-NEXT:  	.zero	11
; CHECK-LABEL: .Lstatic_stack:
; CHECK-NEXT:  	.zero	17

; CHECK-LABEL: .Lfoo_zp_stk = .Lzp_stack+2
; CHECK-NEXT:  	.size	.Lfoo_zp_stk, 8
; CHECK-NEXT:  .Lcsr_zp_stk = .Lzp_stack+2
; CHECK-NEXT:  	.size	.Lcsr_zp_stk, 2
; CHECK-NEXT:  .Lalloca_zp_stk = .Lzp_stack+2
; CHECK-NEXT:  	.size	.Lalloca_zp_stk, 1
; CHECK-NEXT:  .Linr_zp_stk = .Lzp_stack+12
; CHECK-NEXT:  	.size	.Linr_zp_stk, 1
; CHECK-NEXT:  .Lapparent_recursion_callee_zp_stk = .Lzp_stack
; CHECK-NEXT:  	.size	.Lapparent_recursion_callee_zp_stk, 2
; CHECK-NEXT:  .Lapparent_recursion_zp_stk = .Lzp_stack
; CHECK-NEXT:  	.size	.Lapparent_recursion_zp_stk, 2
; CHECK-NEXT:  .Linr_sstk = .Lstatic_stack
; CHECK-NEXT:  	.size	.Linr_sstk, 17
