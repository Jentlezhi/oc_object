//
//  Person_Assemble.h
//  RuntimeDemo-LLVM
//
//  Created by Jentle on 2019/12/4.
//  Copyright © 2019 Jentle. All rights reserved.
//
    .section    __TEXT,__text,regular,pure_instructions
    .build_version macos, 10, 15    sdk_version 10, 15
    .file    1 "/Users/Jentle/Desktop/xmg_object/001.OC\345\257\271\350\261\241\347\232\204\346\234\254\350\264\250/RuntimeDemo-LLVM" "RuntimeDemo-LLVM/Person.h"
    .p2align    4, 0x90         ## -- Begin function -[Person other]
"-[Person other]":                      ## @"\01-[Person other]"
Lfunc_begin0:
    .file    2 "/Users/Jentle/Desktop/xmg_object/001.OC\345\257\271\350\261\241\347\232\204\346\234\254\350\264\250/RuntimeDemo-LLVM" "RuntimeDemo-LLVM/Person.m"
    .loc    2 15 0                  ## RuntimeDemo-LLVM/Person.m:15:0
    .cfi_startproc
## %bb.0:
    pushq    %rbp
    .cfi_def_cfa_offset 16
    .cfi_offset %rbp, -16
    movq    %rsp, %rbp
    .cfi_def_cfa_register %rbp
    subq    $16, %rsp
    leaq    L__unnamed_cfstring_(%rip), %rax
    movq    %rdi, -8(%rbp)
    movq    %rsi, -16(%rbp)
Ltmp0:
    .loc    2 17 5 prologue_end     ## RuntimeDemo-LLVM/Person.m:17:5
    movq    %rax, %rdi
    leaq    "L___func__.-[Person other]"(%rip), %rsi
    movb    $0, %al
    callq    _NSLog
    .loc    2 18 1                  ## RuntimeDemo-LLVM/Person.m:18:1
    addq    $16, %rsp
    popq    %rbp
    retq
Ltmp1:
Lfunc_end0:
    .cfi_endproc
                                        ## -- End function
    .p2align    4, 0x90         ## -- Begin function -[Person forwardingTargetForSelector:]
"-[Person forwardingTargetForSelector:]": ## @"\01-[Person forwardingTargetForSelector:]"
Lfunc_begin1:
    .loc    2 19 0                  ## RuntimeDemo-LLVM/Person.m:19:0
    .cfi_startproc
## %bb.0:
    pushq    %rbp
    .cfi_def_cfa_offset 16
    .cfi_offset %rbp, -16
    movq    %rsp, %rbp
    .cfi_def_cfa_register %rbp
    subq    $48, %rsp
    movq    %rdi, -16(%rbp)
    movq    %rsi, -24(%rbp)
    movq    %rdx, -32(%rbp)
Ltmp2:
    .loc    2 21 9 prologue_end     ## RuntimeDemo-LLVM/Person.m:21:9
    movq    -32(%rbp), %rdx
    .loc    2 21 19 is_stmt 0       ## RuntimeDemo-LLVM/Person.m:21:19
    cmpq    L_OBJC_SELECTOR_REFERENCES_(%rip), %rdx
Ltmp3:
    .loc    2 21 9                  ## RuntimeDemo-LLVM/Person.m:21:9
    jne    LBB1_2
## %bb.1:
Ltmp4:
    .loc    2 22 9 is_stmt 1        ## RuntimeDemo-LLVM/Person.m:22:9
    movq    $0, -8(%rbp)
    jmp    LBB1_3
Ltmp5:
LBB1_2:
    .loc    2 24 12                 ## RuntimeDemo-LLVM/Person.m:24:12
    movq    -16(%rbp), %rax
    .loc    2 24 47 is_stmt 0       ## RuntimeDemo-LLVM/Person.m:24:47
    movq    -32(%rbp), %rdx
    .loc    2 24 12                 ## RuntimeDemo-LLVM/Person.m:24:12
    movq    %rax, -48(%rbp)
    movq    L_OBJC_CLASSLIST_SUP_REFS_$_(%rip), %rax
    movq    %rax, -40(%rbp)
    movq    L_OBJC_SELECTOR_REFERENCES_.2(%rip), %rsi
    leaq    -48(%rbp), %rdi
    callq    _objc_msgSendSuper2
    movq    %rax, %rdi
    callq    _objc_retainAutoreleasedReturnValue
    .loc    2 24 5                  ## RuntimeDemo-LLVM/Person.m:24:5
    movq    %rax, -8(%rbp)
LBB1_3:
    .loc    2 25 1 is_stmt 1        ## RuntimeDemo-LLVM/Person.m:25:1
    movq    -8(%rbp), %rdi
    addq    $48, %rsp
    popq    %rbp
    jmp    _objc_autoreleaseReturnValue ## TAILCALL
Ltmp6:
Lfunc_end1:
    .cfi_endproc
                                        ## -- End function
    .p2align    4, 0x90         ## -- Begin function -[Person methodSignatureForSelector:]
"-[Person methodSignatureForSelector:]": ## @"\01-[Person methodSignatureForSelector:]"
Lfunc_begin2:
    .loc    2 27 0                  ## RuntimeDemo-LLVM/Person.m:27:0
    .cfi_startproc
## %bb.0:
    pushq    %rbp
    .cfi_def_cfa_offset 16
    .cfi_offset %rbp, -16
    movq    %rsp, %rbp
    .cfi_def_cfa_register %rbp
    subq    $48, %rsp
    movq    %rdi, -16(%rbp)
    movq    %rsi, -24(%rbp)
    movq    %rdx, -32(%rbp)
Ltmp7:
    .loc    2 29 9 prologue_end     ## RuntimeDemo-LLVM/Person.m:29:9
    movq    -32(%rbp), %rdx
    .loc    2 29 19 is_stmt 0       ## RuntimeDemo-LLVM/Person.m:29:19
    cmpq    L_OBJC_SELECTOR_REFERENCES_(%rip), %rdx
Ltmp8:
    .loc    2 29 9                  ## RuntimeDemo-LLVM/Person.m:29:9
    jne    LBB2_2
## %bb.1:
Ltmp9:
    .loc    2 31 16 is_stmt 1       ## RuntimeDemo-LLVM/Person.m:31:16
    movq    L_OBJC_CLASSLIST_REFERENCES_$_(%rip), %rax
    movq    L_OBJC_SELECTOR_REFERENCES_.5(%rip), %rsi
    movq    %rax, %rdi
    leaq    L_.str.3(%rip), %rdx
    callq    *_objc_msgSend@GOTPCREL(%rip)
    movq    %rax, %rdi
    callq    _objc_retainAutoreleasedReturnValue
    .loc    2 31 9 is_stmt 0        ## RuntimeDemo-LLVM/Person.m:31:9
    movq    %rax, -8(%rbp)
    jmp    LBB2_3
Ltmp10:
LBB2_2:
    .loc    2 33 12 is_stmt 1       ## RuntimeDemo-LLVM/Person.m:33:12
    movq    -16(%rbp), %rax
    .loc    2 33 46 is_stmt 0       ## RuntimeDemo-LLVM/Person.m:33:46
    movq    -32(%rbp), %rdx
    .loc    2 33 12                 ## RuntimeDemo-LLVM/Person.m:33:12
    movq    %rax, -48(%rbp)
    movq    L_OBJC_CLASSLIST_SUP_REFS_$_(%rip), %rax
    movq    %rax, -40(%rbp)
    movq    L_OBJC_SELECTOR_REFERENCES_.7(%rip), %rsi
    leaq    -48(%rbp), %rdi
    callq    _objc_msgSendSuper2
    movq    %rax, %rdi
    callq    _objc_retainAutoreleasedReturnValue
    .loc    2 33 5                  ## RuntimeDemo-LLVM/Person.m:33:5
    movq    %rax, -8(%rbp)
LBB2_3:
    .loc    2 34 1 is_stmt 1        ## RuntimeDemo-LLVM/Person.m:34:1
    movq    -8(%rbp), %rdi
    addq    $48, %rsp
    popq    %rbp
    jmp    _objc_autoreleaseReturnValue ## TAILCALL
Ltmp11:
Lfunc_end2:
    .cfi_endproc
                                        ## -- End function
    .p2align    4, 0x90         ## -- Begin function -[Person forwardInvocation:]
"-[Person forwardInvocation:]":         ## @"\01-[Person forwardInvocation:]"
Lfunc_begin3:
    .loc    2 36 0                  ## RuntimeDemo-LLVM/Person.m:36:0
    .cfi_startproc
## %bb.0:
    pushq    %rbp
    .cfi_def_cfa_offset 16
    .cfi_offset %rbp, -16
    movq    %rsp, %rbp
    .cfi_def_cfa_register %rbp
    subq    $48, %rsp
    movq    %rdi, -8(%rbp)
    movq    %rsi, -16(%rbp)
    movq    $0, -24(%rbp)
    leaq    -24(%rbp), %rsi
    movq    %rsi, %rdi
    movq    %rdx, %rsi
    callq    _objc_storeStrong
Ltmp12:
    .loc    2 38 6 prologue_end     ## RuntimeDemo-LLVM/Person.m:38:6
    movq    -24(%rbp), %rdx
    .loc    2 38 37 is_stmt 0       ## RuntimeDemo-LLVM/Person.m:38:37
    movq    L_OBJC_CLASSLIST_REFERENCES_$_.8(%rip), %rsi
    movq    %rsi, %rdi
    movq    %rdx, -32(%rbp)         ## 8-byte Spill
    callq    _objc_alloc
    .loc    2 38 36                 ## RuntimeDemo-LLVM/Person.m:38:36
    movq    L_OBJC_SELECTOR_REFERENCES_.10(%rip), %rsi
    movq    %rax, %rdi
    callq    *_objc_msgSend@GOTPCREL(%rip)
    movq    %rax, %rdx
    .loc    2 38 5                  ## RuntimeDemo-LLVM/Person.m:38:5
    movq    L_OBJC_SELECTOR_REFERENCES_.12(%rip), %rsi
    movq    -32(%rbp), %rdi         ## 8-byte Reload
    movq    %rax, -40(%rbp)         ## 8-byte Spill
    callq    *_objc_msgSend@GOTPCREL(%rip)
    movq    -40(%rbp), %rax         ## 8-byte Reload
    movq    %rax, %rdi
    callq    *_objc_release@GOTPCREL(%rip)
    xorl    %ecx, %ecx
    movl    %ecx, %esi
    .loc    2 39 1 is_stmt 1        ## RuntimeDemo-LLVM/Person.m:39:1
    leaq    -24(%rbp), %rax
    movq    %rax, %rdi
    callq    _objc_storeStrong
    addq    $48, %rsp
    popq    %rbp
    retq
Ltmp13:
Lfunc_end3:
    .cfi_endproc
                                        ## -- End function
    .section    __TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
    .asciz    "%s"

    .section    __DATA,__cfstring
    .p2align    3               ## @_unnamed_cfstring_
L__unnamed_cfstring_:
    .quad    ___CFConstantStringClassReference
    .long    1992                    ## 0x7c8
    .space    4
    .quad    L_.str
    .quad    2                       ## 0x2

    .section    __TEXT,__cstring,cstring_literals
"L___func__.-[Person other]":           ## @"__func__.-[Person other]"
    .asciz    "-[Person other]"

    .section    __TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_:                  ## @OBJC_METH_VAR_NAME_
    .asciz    "run"

    .section    __DATA,__objc_selrefs,literal_pointers,no_dead_strip
    .p2align    3               ## @OBJC_SELECTOR_REFERENCES_
L_OBJC_SELECTOR_REFERENCES_:
    .quad    L_OBJC_METH_VAR_NAME_

    .section    __DATA,__objc_data
    .globl    _OBJC_CLASS_$_Person    ## @"OBJC_CLASS_$_Person"
    .p2align    3
_OBJC_CLASS_$_Person:
    .quad    _OBJC_METACLASS_$_Person
    .quad    _OBJC_CLASS_$_NSObject
    .quad    __objc_empty_cache
    .quad    0
    .quad    l_OBJC_CLASS_RO_$_Person

    .section    __DATA,__objc_superrefs,regular,no_dead_strip
    .p2align    3               ## @"OBJC_CLASSLIST_SUP_REFS_$_"
L_OBJC_CLASSLIST_SUP_REFS_$_:
    .quad    _OBJC_CLASS_$_Person

    .section    __TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.1:                ## @OBJC_METH_VAR_NAME_.1
    .asciz    "forwardingTargetForSelector:"

    .section    __DATA,__objc_selrefs,literal_pointers,no_dead_strip
    .p2align    3               ## @OBJC_SELECTOR_REFERENCES_.2
L_OBJC_SELECTOR_REFERENCES_.2:
    .quad    L_OBJC_METH_VAR_NAME_.1

    .section    __DATA,__objc_classrefs,regular,no_dead_strip
    .p2align    3               ## @"OBJC_CLASSLIST_REFERENCES_$_"
L_OBJC_CLASSLIST_REFERENCES_$_:
    .quad    _OBJC_CLASS_$_NSMethodSignature

    .section    __TEXT,__cstring,cstring_literals
L_.str.3:                               ## @.str.3
    .asciz    "v16@0:8"

    .section    __TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.4:                ## @OBJC_METH_VAR_NAME_.4
    .asciz    "signatureWithObjCTypes:"

    .section    __DATA,__objc_selrefs,literal_pointers,no_dead_strip
    .p2align    3               ## @OBJC_SELECTOR_REFERENCES_.5
L_OBJC_SELECTOR_REFERENCES_.5:
    .quad    L_OBJC_METH_VAR_NAME_.4

    .section    __TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.6:                ## @OBJC_METH_VAR_NAME_.6
    .asciz    "methodSignatureForSelector:"

    .section    __DATA,__objc_selrefs,literal_pointers,no_dead_strip
    .p2align    3               ## @OBJC_SELECTOR_REFERENCES_.7
L_OBJC_SELECTOR_REFERENCES_.7:
    .quad    L_OBJC_METH_VAR_NAME_.6

    .section    __DATA,__objc_classrefs,regular,no_dead_strip
    .p2align    3               ## @"OBJC_CLASSLIST_REFERENCES_$_.8"
L_OBJC_CLASSLIST_REFERENCES_$_.8:
    .quad    _OBJC_CLASS_$_Test

    .section    __TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.9:                ## @OBJC_METH_VAR_NAME_.9
    .asciz    "init"

    .section    __DATA,__objc_selrefs,literal_pointers,no_dead_strip
    .p2align    3               ## @OBJC_SELECTOR_REFERENCES_.10
L_OBJC_SELECTOR_REFERENCES_.10:
    .quad    L_OBJC_METH_VAR_NAME_.9

    .section    __TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.11:               ## @OBJC_METH_VAR_NAME_.11
    .asciz    "invokeWithTarget:"

    .section    __DATA,__objc_selrefs,literal_pointers,no_dead_strip
    .p2align    3               ## @OBJC_SELECTOR_REFERENCES_.12
L_OBJC_SELECTOR_REFERENCES_.12:
    .quad    L_OBJC_METH_VAR_NAME_.11

    .section    __TEXT,__objc_classname,cstring_literals
L_OBJC_CLASS_NAME_:                     ## @OBJC_CLASS_NAME_
    .asciz    "Person"

    .section    __DATA,__objc_const
    .p2align    3               ## @"\01l_OBJC_METACLASS_RO_$_Person"
l_OBJC_METACLASS_RO_$_Person:
    .long    129                     ## 0x81
    .long    40                      ## 0x28
    .long    40                      ## 0x28
    .space    4
    .quad    0
    .quad    L_OBJC_CLASS_NAME_
    .quad    0
    .quad    0
    .quad    0
    .quad    0
    .quad    0

    .section    __DATA,__objc_data
    .globl    _OBJC_METACLASS_$_Person ## @"OBJC_METACLASS_$_Person"
    .p2align    3
_OBJC_METACLASS_$_Person:
    .quad    _OBJC_METACLASS_$_NSObject
    .quad    _OBJC_METACLASS_$_NSObject
    .quad    __objc_empty_cache
    .quad    0
    .quad    l_OBJC_METACLASS_RO_$_Person

    .section    __TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.13:               ## @OBJC_METH_VAR_NAME_.13
    .asciz    "other"

    .section    __TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_:                  ## @OBJC_METH_VAR_TYPE_
    .asciz    "v16@0:8"

L_OBJC_METH_VAR_TYPE_.14:               ## @OBJC_METH_VAR_TYPE_.14
    .asciz    "@24@0:8:16"

    .section    __TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.15:               ## @OBJC_METH_VAR_NAME_.15
    .asciz    "forwardInvocation:"

    .section    __TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_.16:               ## @OBJC_METH_VAR_TYPE_.16
    .asciz    "v24@0:8@16"

    .section    __DATA,__objc_const
    .p2align    3               ## @"\01l_OBJC_$_INSTANCE_METHODS_Person"
l_OBJC_$_INSTANCE_METHODS_Person:
    .long    24                      ## 0x18
    .long    4                       ## 0x4
    .quad    L_OBJC_METH_VAR_NAME_.13
    .quad    L_OBJC_METH_VAR_TYPE_
    .quad    "-[Person other]"
    .quad    L_OBJC_METH_VAR_NAME_.1
    .quad    L_OBJC_METH_VAR_TYPE_.14
    .quad    "-[Person forwardingTargetForSelector:]"
    .quad    L_OBJC_METH_VAR_NAME_.6
    .quad    L_OBJC_METH_VAR_TYPE_.14
    .quad    "-[Person methodSignatureForSelector:]"
    .quad    L_OBJC_METH_VAR_NAME_.15
    .quad    L_OBJC_METH_VAR_TYPE_.16
    .quad    "-[Person forwardInvocation:]"

    .p2align    3               ## @"\01l_OBJC_CLASS_RO_$_Person"
l_OBJC_CLASS_RO_$_Person:
    .long    128                     ## 0x80
    .long    8                       ## 0x8
    .long    8                       ## 0x8
    .space    4
    .quad    0
    .quad    L_OBJC_CLASS_NAME_
    .quad    l_OBJC_$_INSTANCE_METHODS_Person
    .quad    0
    .quad    0
    .quad    0
    .quad    0

    .section    __DATA,__objc_classlist,regular,no_dead_strip
    .p2align    3               ## @"OBJC_LABEL_CLASS_$"
L_OBJC_LABEL_CLASS_$:
    .quad    _OBJC_CLASS_$_Person

    .linker_option "-framework", "Foundation"
    .linker_option "-framework", "ApplicationServices"
    .linker_option "-framework", "CoreText"
    .linker_option "-framework", "CoreServices"
    .linker_option "-framework", "DiskArbitration"
    .linker_option "-framework", "CFNetwork"
    .linker_option "-framework", "Security"
    .linker_option "-framework", "ImageIO"
    .linker_option "-framework", "ColorSync"
    .linker_option "-framework", "CoreGraphics"
    .linker_option "-framework", "IOKit"
    .linker_option "-framework", "CoreFoundation"
    .section    __DATA,__objc_imageinfo,regular,no_dead_strip
L_OBJC_IMAGE_INFO:
    .long    0
    .long    64

    .file    3 "/Users/Jentle/Desktop/xmg_object/001.OC\345\257\271\350\261\241\347\232\204\346\234\254\350\264\250/RuntimeDemo-LLVM" "/Users/Jentle/Desktop/xmg_object/001.OC\345\257\271\350\261\241\347\232\204\346\234\254\350\264\250/RuntimeDemo-LLVM/RuntimeDemo-LLVM/Person.m"
    .section    __DWARF,__debug_str,regular,debug
Linfo_string:
    .asciz    "Apple clang version 11.0.0 (clang-1100.0.33.8)" ## string offset=0
    .asciz    "/Users/Jentle/Desktop/xmg_object/001.OC\345\257\271\350\261\241\347\232\204\346\234\254\350\264\250/RuntimeDemo-LLVM/RuntimeDemo-LLVM/Person.m" ## string offset=47
    .asciz    "/Users/Jentle/Desktop/xmg_object/001.OC\345\257\271\350\261\241\347\232\204\346\234\254\350\264\250/RuntimeDemo-LLVM" ## string offset=145
    .asciz    "Person"                ## string offset=217
    .asciz    "ObjectiveC"            ## string offset=224
    .asciz    "\"-DDEBUG=1\" \"-DOBJC_OLD_DISPATCH_PROTOTYPES=0\"" ## string offset=235
    .asciz    "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.15.sdk/usr/include/objc" ## string offset=282
    .asciz    "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.15.sdk" ## string offset=399
    .asciz    "NSObject"              ## string offset=499
    .asciz    "Foundation"            ## string offset=508
    .asciz    "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.15.sdk/System/Library/Frameworks/Foundation.framework" ## string offset=519
    .asciz    "-[Person other]"       ## string offset=666
    .asciz    "other"                 ## string offset=682
    .asciz    "-[Person forwardingTargetForSelector:]" ## string offset=688
    .asciz    "forwardingTargetForSelector:" ## string offset=727
    .asciz    "-[Person methodSignatureForSelector:]" ## string offset=756
    .asciz    "methodSignatureForSelector:" ## string offset=794
    .asciz    "-[Person forwardInvocation:]" ## string offset=822
    .asciz    "forwardInvocation:"    ## string offset=851
    .asciz    "id"                    ## string offset=870
    .asciz    "objc_object"           ## string offset=873
    .asciz    "isa"                   ## string offset=885
    .asciz    "objc_class"            ## string offset=889
    .asciz    "NSMethodSignature"     ## string offset=900
    .asciz    "self"                  ## string offset=918
    .asciz    "_cmd"                  ## string offset=923
    .asciz    "SEL"                   ## string offset=928
    .asciz    "objc_selector"         ## string offset=932
    .asciz    "aSelector"             ## string offset=946
    .asciz    "anInvocation"          ## string offset=956
    .asciz    "NSInvocation"          ## string offset=969
    .asciz    "/Users/Jentle/Library/Developer/Xcode/DerivedData/ModuleCache.noindex/RV23ZJ79OT5F/Foundation-2FJBXN8U6QRTS.pcm" ## string offset=982
    .asciz    "/Users/Jentle/Library/Developer/Xcode/DerivedData/ModuleCache.noindex/RV23ZJ79OT5F/ObjectiveC-1A3ZNHZR9RRLF.pcm" ## string offset=1094
    .section    __DWARF,__debug_abbrev,regular,debug
Lsection_abbrev:
    .byte    1                       ## Abbreviation Code
    .byte    17                      ## DW_TAG_compile_unit
    .byte    1                       ## DW_CHILDREN_yes
    .byte    37                      ## DW_AT_producer
    .byte    14                      ## DW_FORM_strp
    .byte    19                      ## DW_AT_language
    .byte    5                       ## DW_FORM_data2
    .byte    3                       ## DW_AT_name
    .byte    14                      ## DW_FORM_strp
    .byte    16                      ## DW_AT_stmt_list
    .byte    23                      ## DW_FORM_sec_offset
    .byte    27                      ## DW_AT_comp_dir
    .byte    14                      ## DW_FORM_strp
    .ascii    "\264B"                 ## DW_AT_GNU_pubnames
    .byte    25                      ## DW_FORM_flag_present
    .ascii    "\345\177"              ## DW_AT_APPLE_major_runtime_vers
    .byte    11                      ## DW_FORM_data1
    .byte    17                      ## DW_AT_low_pc
    .byte    1                       ## DW_FORM_addr
    .byte    18                      ## DW_AT_high_pc
    .byte    6                       ## DW_FORM_data4
    .byte    0                       ## EOM(1)
    .byte    0                       ## EOM(2)
    .byte    2                       ## Abbreviation Code
    .byte    19                      ## DW_TAG_structure_type
    .byte    1                       ## DW_CHILDREN_yes
    .ascii    "\354\177"              ## DW_AT_APPLE_objc_complete_type
    .byte    25                      ## DW_FORM_flag_present
    .byte    3                       ## DW_AT_name
    .byte    14                      ## DW_FORM_strp
    .byte    11                      ## DW_AT_byte_size
    .byte    11                      ## DW_FORM_data1
    .byte    58                      ## DW_AT_decl_file
    .byte    11                      ## DW_FORM_data1
    .byte    59                      ## DW_AT_decl_line
    .byte    11                      ## DW_FORM_data1
    .ascii    "\346\177"              ## DW_AT_APPLE_runtime_class
    .byte    11                      ## DW_FORM_data1
    .byte    0                       ## EOM(1)
    .byte    0                       ## EOM(2)
    .byte    3                       ## Abbreviation Code
    .byte    28                      ## DW_TAG_inheritance
    .byte    0                       ## DW_CHILDREN_no
    .byte    73                      ## DW_AT_type
    .byte    19                      ## DW_FORM_ref4
    .byte    56                      ## DW_AT_data_member_location
    .byte    11                      ## DW_FORM_data1
    .byte    0                       ## EOM(1)
    .byte    0                       ## EOM(2)
    .byte    4                       ## Abbreviation Code
    .byte    30                      ## DW_TAG_module
    .byte    1                       ## DW_CHILDREN_yes
    .byte    3                       ## DW_AT_name
    .byte    14                      ## DW_FORM_strp
    .ascii    "\201|"                 ## DW_AT_LLVM_config_macros
    .byte    14                      ## DW_FORM_strp
    .ascii    "\200|"                 ## DW_AT_LLVM_include_path
    .byte    14                      ## DW_FORM_strp
    .ascii    "\202|"                 ## DW_AT_LLVM_isysroot
    .byte    14                      ## DW_FORM_strp
    .byte    0                       ## EOM(1)
    .byte    0                       ## EOM(2)
    .byte    5                       ## Abbreviation Code
    .byte    19                      ## DW_TAG_structure_type
    .byte    0                       ## DW_CHILDREN_no
    .byte    3                       ## DW_AT_name
    .byte    14                      ## DW_FORM_strp
    .byte    60                      ## DW_AT_declaration
    .byte    25                      ## DW_FORM_flag_present
    .byte    0                       ## EOM(1)
    .byte    0                       ## EOM(2)
    .byte    6                       ## Abbreviation Code
    .byte    30                      ## DW_TAG_module
    .byte    1                       ## DW_CHILDREN_yes
    .byte    3                       ## DW_AT_name
    .byte    14                      ## DW_FORM_strp
    .ascii    "\201|"                 ## DW_AT_LLVM_config_macros
    .byte    14                      ## DW_FORM_strp
    .ascii    "\202|"                 ## DW_AT_LLVM_isysroot
    .byte    14                      ## DW_FORM_strp
    .byte    0                       ## EOM(1)
    .byte    0                       ## EOM(2)
    .byte    7                       ## Abbreviation Code
    .byte    8                       ## DW_TAG_imported_declaration
    .byte    0                       ## DW_CHILDREN_no
    .byte    58                      ## DW_AT_decl_file
    .byte    11                      ## DW_FORM_data1
    .byte    59                      ## DW_AT_decl_line
    .byte    11                      ## DW_FORM_data1
    .byte    24                      ## DW_AT_import
    .byte    19                      ## DW_FORM_ref4
    .byte    0                       ## EOM(1)
    .byte    0                       ## EOM(2)
    .byte    8                       ## Abbreviation Code
    .byte    46                      ## DW_TAG_subprogram
    .byte    1                       ## DW_CHILDREN_yes
    .byte    17                      ## DW_AT_low_pc
    .byte    1                       ## DW_FORM_addr
    .byte    18                      ## DW_AT_high_pc
    .byte    6                       ## DW_FORM_data4
    .byte    64                      ## DW_AT_frame_base
    .byte    24                      ## DW_FORM_exprloc
    .byte    100                     ## DW_AT_object_pointer
    .byte    19                      ## DW_FORM_ref4
    .byte    3                       ## DW_AT_name
    .byte    14                      ## DW_FORM_strp
    .byte    58                      ## DW_AT_decl_file
    .byte    11                      ## DW_FORM_data1
    .byte    59                      ## DW_AT_decl_line
    .byte    11                      ## DW_FORM_data1
    .byte    39                      ## DW_AT_prototyped
    .byte    25                      ## DW_FORM_flag_present
    .byte    0                       ## EOM(1)
    .byte    0                       ## EOM(2)
    .byte    9                       ## Abbreviation Code
    .byte    5                       ## DW_TAG_formal_parameter
    .byte    0                       ## DW_CHILDREN_no
    .byte    2                       ## DW_AT_location
    .byte    24                      ## DW_FORM_exprloc
    .byte    3                       ## DW_AT_name
    .byte    14                      ## DW_FORM_strp
    .byte    73                      ## DW_AT_type
    .byte    19                      ## DW_FORM_ref4
    .byte    52                      ## DW_AT_artificial
    .byte    25                      ## DW_FORM_flag_present
    .byte    0                       ## EOM(1)
    .byte    0                       ## EOM(2)
    .byte    10                      ## Abbreviation Code
    .byte    46                      ## DW_TAG_subprogram
    .byte    1                       ## DW_CHILDREN_yes
    .byte    17                      ## DW_AT_low_pc
    .byte    1                       ## DW_FORM_addr
    .byte    18                      ## DW_AT_high_pc
    .byte    6                       ## DW_FORM_data4
    .byte    64                      ## DW_AT_frame_base
    .byte    24                      ## DW_FORM_exprloc
    .byte    100                     ## DW_AT_object_pointer
    .byte    19                      ## DW_FORM_ref4
    .byte    3                       ## DW_AT_name
    .byte    14                      ## DW_FORM_strp
    .byte    58                      ## DW_AT_decl_file
    .byte    11                      ## DW_FORM_data1
    .byte    59                      ## DW_AT_decl_line
    .byte    11                      ## DW_FORM_data1
    .byte    39                      ## DW_AT_prototyped
    .byte    25                      ## DW_FORM_flag_present
    .byte    73                      ## DW_AT_type
    .byte    19                      ## DW_FORM_ref4
    .byte    0                       ## EOM(1)
    .byte    0                       ## EOM(2)
    .byte    11                      ## Abbreviation Code
    .byte    5                       ## DW_TAG_formal_parameter
    .byte    0                       ## DW_CHILDREN_no
    .byte    2                       ## DW_AT_location
    .byte    24                      ## DW_FORM_exprloc
    .byte    3                       ## DW_AT_name
    .byte    14                      ## DW_FORM_strp
    .byte    58                      ## DW_AT_decl_file
    .byte    11                      ## DW_FORM_data1
    .byte    59                      ## DW_AT_decl_line
    .byte    11                      ## DW_FORM_data1
    .byte    73                      ## DW_AT_type
    .byte    19                      ## DW_FORM_ref4
    .byte    0                       ## EOM(1)
    .byte    0                       ## EOM(2)
    .byte    12                      ## Abbreviation Code
    .byte    22                      ## DW_TAG_typedef
    .byte    0                       ## DW_CHILDREN_no
    .byte    73                      ## DW_AT_type
    .byte    19                      ## DW_FORM_ref4
    .byte    3                       ## DW_AT_name
    .byte    14                      ## DW_FORM_strp
    .byte    58                      ## DW_AT_decl_file
    .byte    11                      ## DW_FORM_data1
    .byte    59                      ## DW_AT_decl_line
    .byte    11                      ## DW_FORM_data1
    .byte    0                       ## EOM(1)
    .byte    0                       ## EOM(2)
    .byte    13                      ## Abbreviation Code
    .byte    15                      ## DW_TAG_pointer_type
    .byte    0                       ## DW_CHILDREN_no
    .byte    73                      ## DW_AT_type
    .byte    19                      ## DW_FORM_ref4
    .byte    0                       ## EOM(1)
    .byte    0                       ## EOM(2)
    .byte    14                      ## Abbreviation Code
    .byte    19                      ## DW_TAG_structure_type
    .byte    1                       ## DW_CHILDREN_yes
    .byte    3                       ## DW_AT_name
    .byte    14                      ## DW_FORM_strp
    .byte    11                      ## DW_AT_byte_size
    .byte    11                      ## DW_FORM_data1
    .byte    0                       ## EOM(1)
    .byte    0                       ## EOM(2)
    .byte    15                      ## Abbreviation Code
    .byte    13                      ## DW_TAG_member
    .byte    0                       ## DW_CHILDREN_no
    .byte    3                       ## DW_AT_name
    .byte    14                      ## DW_FORM_strp
    .byte    73                      ## DW_AT_type
    .byte    19                      ## DW_FORM_ref4
    .byte    56                      ## DW_AT_data_member_location
    .byte    11                      ## DW_FORM_data1
    .byte    0                       ## EOM(1)
    .byte    0                       ## EOM(2)
    .byte    16                      ## Abbreviation Code
    .byte    38                      ## DW_TAG_const_type
    .byte    0                       ## DW_CHILDREN_no
    .byte    73                      ## DW_AT_type
    .byte    19                      ## DW_FORM_ref4
    .byte    0                       ## EOM(1)
    .byte    0                       ## EOM(2)
    .byte    17                      ## Abbreviation Code
    .byte    22                      ## DW_TAG_typedef
    .byte    0                       ## DW_CHILDREN_no
    .byte    73                      ## DW_AT_type
    .byte    19                      ## DW_FORM_ref4
    .byte    3                       ## DW_AT_name
    .byte    14                      ## DW_FORM_strp
    .byte    0                       ## EOM(1)
    .byte    0                       ## EOM(2)
    .byte    18                      ## Abbreviation Code
    .byte    17                      ## DW_TAG_compile_unit
    .byte    0                       ## DW_CHILDREN_no
    .byte    37                      ## DW_AT_producer
    .byte    14                      ## DW_FORM_strp
    .byte    19                      ## DW_AT_language
    .byte    5                       ## DW_FORM_data2
    .byte    3                       ## DW_AT_name
    .byte    14                      ## DW_FORM_strp
    .byte    16                      ## DW_AT_stmt_list
    .byte    23                      ## DW_FORM_sec_offset
    .byte    27                      ## DW_AT_comp_dir
    .byte    14                      ## DW_FORM_strp
    .ascii    "\341\177"              ## DW_AT_APPLE_optimized
    .byte    25                      ## DW_FORM_flag_present
    .ascii    "\261B"                 ## DW_AT_GNU_dwo_id
    .byte    7                       ## DW_FORM_data8
    .ascii    "\260B"                 ## DW_AT_GNU_dwo_name
    .byte    14                      ## DW_FORM_strp
    .byte    0                       ## EOM(1)
    .byte    0                       ## EOM(2)
    .byte    0                       ## EOM(3)
    .section    __DWARF,__debug_info,regular,debug
Lsection_info:
Lcu_begin0:
.set Lset0, Ldebug_info_end0-Ldebug_info_start0 ## Length of Unit
    .long    Lset0
Ldebug_info_start0:
    .short    4                       ## DWARF version number
.set Lset1, Lsection_abbrev-Lsection_abbrev ## Offset Into Abbrev. Section
    .long    Lset1
    .byte    8                       ## Address Size (in bytes)
    .byte    1                       ## Abbrev [1] 0xb:0x1e5 DW_TAG_compile_unit
    .long    0                       ## DW_AT_producer
    .short    16                      ## DW_AT_language
    .long    47                      ## DW_AT_name
.set Lset2, Lline_table_start0-Lsection_line ## DW_AT_stmt_list
    .long    Lset2
    .long    145                     ## DW_AT_comp_dir
                                        ## DW_AT_GNU_pubnames
    .byte    2                       ## DW_AT_APPLE_major_runtime_vers
    .quad    Lfunc_begin0            ## DW_AT_low_pc
.set Lset3, Lfunc_end3-Lfunc_begin0     ## DW_AT_high_pc
    .long    Lset3
    .byte    2                       ## Abbrev [2] 0x2b:0x10 DW_TAG_structure_type
                                        ## DW_AT_APPLE_objc_complete_type
    .long    217                     ## DW_AT_name
    .byte    8                       ## DW_AT_byte_size
    .byte    1                       ## DW_AT_decl_file
    .byte    13                      ## DW_AT_decl_line
    .byte    16                      ## DW_AT_APPLE_runtime_class
    .byte    3                       ## Abbrev [3] 0x34:0x6 DW_TAG_inheritance
    .long    93                      ## DW_AT_type
    .byte    0                       ## DW_AT_data_member_location
    .byte    0                       ## End Of Children Mark
    .byte    4                       ## Abbrev [4] 0x3b:0x29 DW_TAG_module
    .long    224                     ## DW_AT_name
    .long    235                     ## DW_AT_LLVM_config_macros
    .long    282                     ## DW_AT_LLVM_include_path
    .long    399                     ## DW_AT_LLVM_isysroot
    .byte    4                       ## Abbrev [4] 0x4c:0x17 DW_TAG_module
    .long    499                     ## DW_AT_name
    .long    235                     ## DW_AT_LLVM_config_macros
    .long    282                     ## DW_AT_LLVM_include_path
    .long    399                     ## DW_AT_LLVM_isysroot
    .byte    5                       ## Abbrev [5] 0x5d:0x5 DW_TAG_structure_type
    .long    499                     ## DW_AT_name
                                        ## DW_AT_declaration
    .byte    0                       ## End Of Children Mark
    .byte    0                       ## End Of Children Mark
    .byte    4                       ## Abbrev [4] 0x64:0x38 DW_TAG_module
    .long    508                     ## DW_AT_name
    .long    235                     ## DW_AT_LLVM_config_macros
    .long    519                     ## DW_AT_LLVM_include_path
    .long    399                     ## DW_AT_LLVM_isysroot
    .byte    6                       ## Abbrev [6] 0x75:0x13 DW_TAG_module
    .long    900                     ## DW_AT_name
    .long    235                     ## DW_AT_LLVM_config_macros
    .long    399                     ## DW_AT_LLVM_isysroot
    .byte    5                       ## Abbrev [5] 0x82:0x5 DW_TAG_structure_type
    .long    900                     ## DW_AT_name
                                        ## DW_AT_declaration
    .byte    0                       ## End Of Children Mark
    .byte    6                       ## Abbrev [6] 0x88:0x13 DW_TAG_module
    .long    969                     ## DW_AT_name
    .long    235                     ## DW_AT_LLVM_config_macros
    .long    399                     ## DW_AT_LLVM_isysroot
    .byte    5                       ## Abbrev [5] 0x95:0x5 DW_TAG_structure_type
    .long    969                     ## DW_AT_name
                                        ## DW_AT_declaration
    .byte    0                       ## End Of Children Mark
    .byte    0                       ## End Of Children Mark
    .byte    7                       ## Abbrev [7] 0x9c:0x7 DW_TAG_imported_declaration
    .byte    1                       ## DW_AT_decl_file
    .byte    9                       ## DW_AT_decl_line
    .long    100                     ## DW_AT_import
    .byte    8                       ## Abbrev [8] 0xa3:0x32 DW_TAG_subprogram
    .quad    Lfunc_begin0            ## DW_AT_low_pc
.set Lset4, Lfunc_end0-Lfunc_begin0     ## DW_AT_high_pc
    .long    Lset4
    .byte    1                       ## DW_AT_frame_base
    .byte    86
    .long    188                     ## DW_AT_object_pointer
    .long    666                     ## DW_AT_name
    .byte    2                       ## DW_AT_decl_file
    .byte    15                      ## DW_AT_decl_line
                                        ## DW_AT_prototyped
    .byte    9                       ## Abbrev [9] 0xbc:0xc DW_TAG_formal_parameter
    .byte    2                       ## DW_AT_location
    .byte    145
    .byte    120
    .long    918                     ## DW_AT_name
    .long    461                     ## DW_AT_type
                                        ## DW_AT_artificial
    .byte    9                       ## Abbrev [9] 0xc8:0xc DW_TAG_formal_parameter
    .byte    2                       ## DW_AT_location
    .byte    145
    .byte    112
    .long    923                     ## DW_AT_name
    .long    471                     ## DW_AT_type
                                        ## DW_AT_artificial
    .byte    0                       ## End Of Children Mark
    .byte    10                      ## Abbrev [10] 0xd5:0x44 DW_TAG_subprogram
    .quad    Lfunc_begin1            ## DW_AT_low_pc
.set Lset5, Lfunc_end1-Lfunc_begin1     ## DW_AT_high_pc
    .long    Lset5
    .byte    1                       ## DW_AT_frame_base
    .byte    86
    .long    242                     ## DW_AT_object_pointer
    .long    688                     ## DW_AT_name
    .byte    2                       ## DW_AT_decl_file
    .byte    19                      ## DW_AT_decl_line
                                        ## DW_AT_prototyped
    .long    413                     ## DW_AT_type
    .byte    9                       ## Abbrev [9] 0xf2:0xc DW_TAG_formal_parameter
    .byte    2                       ## DW_AT_location
    .byte    145
    .byte    112
    .long    918                     ## DW_AT_name
    .long    461                     ## DW_AT_type
                                        ## DW_AT_artificial
    .byte    9                       ## Abbrev [9] 0xfe:0xc DW_TAG_formal_parameter
    .byte    2                       ## DW_AT_location
    .byte    145
    .byte    104
    .long    923                     ## DW_AT_name
    .long    471                     ## DW_AT_type
                                        ## DW_AT_artificial
    .byte    11                      ## Abbrev [11] 0x10a:0xe DW_TAG_formal_parameter
    .byte    2                       ## DW_AT_location
    .byte    145
    .byte    96
    .long    946                     ## DW_AT_name
    .byte    2                       ## DW_AT_decl_file
    .byte    19                      ## DW_AT_decl_line
    .long    471                     ## DW_AT_type
    .byte    0                       ## End Of Children Mark
    .byte    10                      ## Abbrev [10] 0x119:0x44 DW_TAG_subprogram
    .quad    Lfunc_begin2            ## DW_AT_low_pc
.set Lset6, Lfunc_end2-Lfunc_begin2     ## DW_AT_high_pc
    .long    Lset6
    .byte    1                       ## DW_AT_frame_base
    .byte    86
    .long    310                     ## DW_AT_object_pointer
    .long    756                     ## DW_AT_name
    .byte    2                       ## DW_AT_decl_file
    .byte    27                      ## DW_AT_decl_line
                                        ## DW_AT_prototyped
    .long    456                     ## DW_AT_type
    .byte    9                       ## Abbrev [9] 0x136:0xc DW_TAG_formal_parameter
    .byte    2                       ## DW_AT_location
    .byte    145
    .byte    112
    .long    918                     ## DW_AT_name
    .long    461                     ## DW_AT_type
                                        ## DW_AT_artificial
    .byte    9                       ## Abbrev [9] 0x142:0xc DW_TAG_formal_parameter
    .byte    2                       ## DW_AT_location
    .byte    145
    .byte    104
    .long    923                     ## DW_AT_name
    .long    471                     ## DW_AT_type
                                        ## DW_AT_artificial
    .byte    11                      ## Abbrev [11] 0x14e:0xe DW_TAG_formal_parameter
    .byte    2                       ## DW_AT_location
    .byte    145
    .byte    96
    .long    946                     ## DW_AT_name
    .byte    2                       ## DW_AT_decl_file
    .byte    27                      ## DW_AT_decl_line
    .long    471                     ## DW_AT_type
    .byte    0                       ## End Of Children Mark
    .byte    8                       ## Abbrev [8] 0x15d:0x40 DW_TAG_subprogram
    .quad    Lfunc_begin3            ## DW_AT_low_pc
.set Lset7, Lfunc_end3-Lfunc_begin3     ## DW_AT_high_pc
    .long    Lset7
    .byte    1                       ## DW_AT_frame_base
    .byte    86
    .long    374                     ## DW_AT_object_pointer
    .long    822                     ## DW_AT_name
    .byte    2                       ## DW_AT_decl_file
    .byte    36                      ## DW_AT_decl_line
                                        ## DW_AT_prototyped
    .byte    9                       ## Abbrev [9] 0x176:0xc DW_TAG_formal_parameter
    .byte    2                       ## DW_AT_location
    .byte    145
    .byte    120
    .long    918                     ## DW_AT_name
    .long    461                     ## DW_AT_type
                                        ## DW_AT_artificial
    .byte    9                       ## Abbrev [9] 0x182:0xc DW_TAG_formal_parameter
    .byte    2                       ## DW_AT_location
    .byte    145
    .byte    112
    .long    923                     ## DW_AT_name
    .long    471                     ## DW_AT_type
                                        ## DW_AT_artificial
    .byte    11                      ## Abbrev [11] 0x18e:0xe DW_TAG_formal_parameter
    .byte    2                       ## DW_AT_location
    .byte    145
    .byte    104
    .long    956                     ## DW_AT_name
    .byte    2                       ## DW_AT_decl_file
    .byte    36                      ## DW_AT_decl_line
    .long    490                     ## DW_AT_type
    .byte    0                       ## End Of Children Mark
    .byte    12                      ## Abbrev [12] 0x19d:0xb DW_TAG_typedef
    .long    424                     ## DW_AT_type
    .long    870                     ## DW_AT_name
    .byte    3                       ## DW_AT_decl_file
    .byte    18                      ## DW_AT_decl_line
    .byte    13                      ## Abbrev [13] 0x1a8:0x5 DW_TAG_pointer_type
    .long    429                     ## DW_AT_type
    .byte    14                      ## Abbrev [14] 0x1ad:0x11 DW_TAG_structure_type
    .long    873                     ## DW_AT_name
    .byte    0                       ## DW_AT_byte_size
    .byte    15                      ## Abbrev [15] 0x1b3:0xa DW_TAG_member
    .long    885                     ## DW_AT_name
    .long    446                     ## DW_AT_type
    .byte    0                       ## DW_AT_data_member_location
    .byte    0                       ## End Of Children Mark
    .byte    13                      ## Abbrev [13] 0x1be:0x5 DW_TAG_pointer_type
    .long    451                     ## DW_AT_type
    .byte    5                       ## Abbrev [5] 0x1c3:0x5 DW_TAG_structure_type
    .long    889                     ## DW_AT_name
                                        ## DW_AT_declaration
    .byte    13                      ## Abbrev [13] 0x1c8:0x5 DW_TAG_pointer_type
    .long    130                     ## DW_AT_type
    .byte    16                      ## Abbrev [16] 0x1cd:0x5 DW_TAG_const_type
    .long    466                     ## DW_AT_type
    .byte    13                      ## Abbrev [13] 0x1d2:0x5 DW_TAG_pointer_type
    .long    43                      ## DW_AT_type
    .byte    17                      ## Abbrev [17] 0x1d7:0x9 DW_TAG_typedef
    .long    480                     ## DW_AT_type
    .long    928                     ## DW_AT_name
    .byte    13                      ## Abbrev [13] 0x1e0:0x5 DW_TAG_pointer_type
    .long    485                     ## DW_AT_type
    .byte    5                       ## Abbrev [5] 0x1e5:0x5 DW_TAG_structure_type
    .long    932                     ## DW_AT_name
                                        ## DW_AT_declaration
    .byte    13                      ## Abbrev [13] 0x1ea:0x5 DW_TAG_pointer_type
    .long    149                     ## DW_AT_type
    .byte    0                       ## End Of Children Mark
Ldebug_info_end0:
Lcu_begin1:
.set Lset8, Ldebug_info_end1-Ldebug_info_start1 ## Length of Unit
    .long    Lset8
Ldebug_info_start1:
    .short    4                       ## DWARF version number
.set Lset9, Lsection_abbrev-Lsection_abbrev ## Offset Into Abbrev. Section
    .long    Lset9
    .byte    8                       ## Address Size (in bytes)
    .byte    18                      ## Abbrev [18] 0xb:0x1f DW_TAG_compile_unit
    .long    0                       ## DW_AT_producer
    .short    16                      ## DW_AT_language
    .long    508                     ## DW_AT_name
.set Lset10, Lline_table_start0-Lsection_line ## DW_AT_stmt_list
    .long    Lset10
    .long    519                     ## DW_AT_comp_dir
                                        ## DW_AT_APPLE_optimized
    .quad    -6704011827832199539    ## DW_AT_GNU_dwo_id
    .long    982                     ## DW_AT_GNU_dwo_name
Ldebug_info_end1:
Lcu_begin2:
.set Lset11, Ldebug_info_end2-Ldebug_info_start2 ## Length of Unit
    .long    Lset11
Ldebug_info_start2:
    .short    4                       ## DWARF version number
.set Lset12, Lsection_abbrev-Lsection_abbrev ## Offset Into Abbrev. Section
    .long    Lset12
    .byte    8                       ## Address Size (in bytes)
    .byte    18                      ## Abbrev [18] 0xb:0x1f DW_TAG_compile_unit
    .long    0                       ## DW_AT_producer
    .short    16                      ## DW_AT_language
    .long    224                     ## DW_AT_name
.set Lset13, Lline_table_start0-Lsection_line ## DW_AT_stmt_list
    .long    Lset13
    .long    282                     ## DW_AT_comp_dir
                                        ## DW_AT_APPLE_optimized
    .quad    -8680152749973685988    ## DW_AT_GNU_dwo_id
    .long    1094                    ## DW_AT_GNU_dwo_name
Ldebug_info_end2:
    .section    __DWARF,__debug_macinfo,regular,debug
Ldebug_macinfo:
    .byte    0                       ## End Of Macro List Mark
    .section    __DWARF,__apple_names,regular,debug
Lnames_begin:
    .long    1212240712              ## Header Magic
    .short    1                       ## Header Version
    .short    0                       ## Header Hash Function
    .long    8                       ## Header Bucket Count
    .long    8                       ## Header Hash Count
    .long    12                      ## Header Data Length
    .long    0                       ## HeaderData Die Offset Base
    .long    1                       ## HeaderData Atom Count
    .short    1                       ## DW_ATOM_die_offset
    .short    6                       ## DW_FORM_data4
    .long    -1                      ## Bucket 0
    .long    0                       ## Bucket 1
    .long    1                       ## Bucket 2
    .long    3                       ## Bucket 3
    .long    -1                      ## Bucket 4
    .long    4                       ## Bucket 5
    .long    5                       ## Bucket 6
    .long    7                       ## Bucket 7
    .long    264569025               ## Hash in Bucket 1
    .long    1105451642              ## Hash in Bucket 2
    .long    1723452458              ## Hash in Bucket 2
    .long    1596407427              ## Hash in Bucket 3
    .long    655971261               ## Hash in Bucket 5
    .long    -1109179826             ## Hash in Bucket 6
    .long    -467234634              ## Hash in Bucket 6
    .long    270074855               ## Hash in Bucket 7
.set Lset14, LNames6-Lnames_begin       ## Offset in Bucket 1
    .long    Lset14
.set Lset15, LNames2-Lnames_begin       ## Offset in Bucket 2
    .long    Lset15
.set Lset16, LNames3-Lnames_begin       ## Offset in Bucket 2
    .long    Lset16
.set Lset17, LNames7-Lnames_begin       ## Offset in Bucket 3
    .long    Lset17
.set Lset18, LNames4-Lnames_begin       ## Offset in Bucket 5
    .long    Lset18
.set Lset19, LNames5-Lnames_begin       ## Offset in Bucket 6
    .long    Lset19
.set Lset20, LNames0-Lnames_begin       ## Offset in Bucket 6
    .long    Lset20
.set Lset21, LNames1-Lnames_begin       ## Offset in Bucket 7
    .long    Lset21
LNames6:
    .long    727                     ## forwardingTargetForSelector:
    .long    1                       ## Num DIEs
    .long    213
    .long    0
LNames2:
    .long    794                     ## methodSignatureForSelector:
    .long    1                       ## Num DIEs
    .long    281
    .long    0
LNames3:
    .long    822                     ## -[Person forwardInvocation:]
    .long    1                       ## Num DIEs
    .long    349
    .long    0
LNames7:
    .long    666                     ## -[Person other]
    .long    1                       ## Num DIEs
    .long    163
    .long    0
LNames4:
    .long    688                     ## -[Person forwardingTargetForSelector:]
    .long    1                       ## Num DIEs
    .long    213
    .long    0
LNames5:
    .long    851                     ## forwardInvocation:
    .long    1                       ## Num DIEs
    .long    349
    .long    0
LNames0:
    .long    756                     ## -[Person methodSignatureForSelector:]
    .long    1                       ## Num DIEs
    .long    281
    .long    0
LNames1:
    .long    682                     ## other
    .long    1                       ## Num DIEs
    .long    163
    .long    0
    .section    __DWARF,__apple_objc,regular,debug
Lobjc_begin:
    .long    1212240712              ## Header Magic
    .short    1                       ## Header Version
    .short    0                       ## Header Hash Function
    .long    1                       ## Header Bucket Count
    .long    1                       ## Header Hash Count
    .long    12                      ## Header Data Length
    .long    0                       ## HeaderData Die Offset Base
    .long    1                       ## HeaderData Atom Count
    .short    1                       ## DW_ATOM_die_offset
    .short    6                       ## DW_FORM_data4
    .long    0                       ## Bucket 0
    .long    -908075748              ## Hash in Bucket 0
.set Lset22, LObjC0-Lobjc_begin         ## Offset in Bucket 0
    .long    Lset22
LObjC0:
    .long    217                     ## Person
    .long    4                       ## Num DIEs
    .long    163
    .long    213
    .long    281
    .long    349
    .long    0
    .section    __DWARF,__apple_namespac,regular,debug
Lnamespac_begin:
    .long    1212240712              ## Header Magic
    .short    1                       ## Header Version
    .short    0                       ## Header Hash Function
    .long    1                       ## Header Bucket Count
    .long    0                       ## Header Hash Count
    .long    12                      ## Header Data Length
    .long    0                       ## HeaderData Die Offset Base
    .long    1                       ## HeaderData Atom Count
    .short    1                       ## DW_ATOM_die_offset
    .short    6                       ## DW_FORM_data4
    .long    -1                      ## Bucket 0
    .section    __DWARF,__apple_types,regular,debug
Ltypes_begin:
    .long    1212240712              ## Header Magic
    .short    1                       ## Header Version
    .short    0                       ## Header Hash Function
    .long    4                       ## Header Bucket Count
    .long    4                       ## Header Hash Count
    .long    20                      ## Header Data Length
    .long    0                       ## HeaderData Die Offset Base
    .long    3                       ## HeaderData Atom Count
    .short    1                       ## DW_ATOM_die_offset
    .short    6                       ## DW_FORM_data4
    .short    3                       ## DW_ATOM_die_tag
    .short    5                       ## DW_FORM_data2
    .short    4                       ## DW_ATOM_type_flags
    .short    11                      ## DW_FORM_data1
    .long    0                       ## Bucket 0
    .long    1                       ## Bucket 1
    .long    3                       ## Bucket 2
    .long    -1                      ## Bucket 3
    .long    -908075748              ## Hash in Bucket 0
    .long    193469737               ## Hash in Bucket 1
    .long    2123788537              ## Hash in Bucket 1
    .long    5863474                 ## Hash in Bucket 2
.set Lset23, Ltypes2-Ltypes_begin       ## Offset in Bucket 0
    .long    Lset23
.set Lset24, Ltypes1-Ltypes_begin       ## Offset in Bucket 1
    .long    Lset24
.set Lset25, Ltypes0-Ltypes_begin       ## Offset in Bucket 1
    .long    Lset25
.set Lset26, Ltypes3-Ltypes_begin       ## Offset in Bucket 2
    .long    Lset26
Ltypes2:
    .long    217                     ## Person
    .long    1                       ## Num DIEs
    .long    43
    .short    19
    .byte    0
    .long    0
Ltypes1:
    .long    928                     ## SEL
    .long    1                       ## Num DIEs
    .long    471
    .short    22
    .byte    0
    .long    0
Ltypes0:
    .long    873                     ## objc_object
    .long    1                       ## Num DIEs
    .long    429
    .short    19
    .byte    0
    .long    0
Ltypes3:
    .long    870                     ## id
    .long    1                       ## Num DIEs
    .long    413
    .short    22
    .byte    0
    .long    0
    .section    __DWARF,__debug_gnu_pubn,regular,debug
.set Lset27, LpubNames_end0-LpubNames_begin0 ## Length of Public Names Info
    .long    Lset27
LpubNames_begin0:
    .short    2                       ## DWARF Version
.set Lset28, Lcu_begin0-Lsection_info   ## Offset of Compilation Unit Info
    .long    Lset28
    .long    496                     ## Compilation Unit Length
    .long    281                     ## DIE offset
    .byte    176                     ## Attributes: FUNCTION, STATIC
    .asciz    "-[Person methodSignatureForSelector:]" ## External Name
    .long    117                     ## DIE offset
    .byte    0                       ## Attributes: NONE, EXTERNAL
    .asciz    "NSMethodSignature"     ## External Name
    .long    349                     ## DIE offset
    .byte    176                     ## Attributes: FUNCTION, STATIC
    .asciz    "-[Person forwardInvocation:]" ## External Name
    .long    100                     ## DIE offset
    .byte    0                       ## Attributes: NONE, EXTERNAL
    .asciz    "Foundation"            ## External Name
    .long    76                      ## DIE offset
    .byte    0                       ## Attributes: NONE, EXTERNAL
    .asciz    "NSObject"              ## External Name
    .long    213                     ## DIE offset
    .byte    176                     ## Attributes: FUNCTION, STATIC
    .asciz    "-[Person forwardingTargetForSelector:]" ## External Name
    .long    136                     ## DIE offset
    .byte    0                       ## Attributes: NONE, EXTERNAL
    .asciz    "NSInvocation"          ## External Name
    .long    59                      ## DIE offset
    .byte    0                       ## Attributes: NONE, EXTERNAL
    .asciz    "ObjectiveC"            ## External Name
    .long    163                     ## DIE offset
    .byte    176                     ## Attributes: FUNCTION, STATIC
    .asciz    "-[Person other]"       ## External Name
    .long    0                       ## End Mark
LpubNames_end0:
    .section    __DWARF,__debug_gnu_pubt,regular,debug
.set Lset29, LpubTypes_end0-LpubTypes_begin0 ## Length of Public Types Info
    .long    Lset29
LpubTypes_begin0:
    .short    2                       ## DWARF Version
.set Lset30, Lcu_begin0-Lsection_info   ## Offset of Compilation Unit Info
    .long    Lset30
    .long    496                     ## Compilation Unit Length
    .long    429                     ## DIE offset
    .byte    144                     ## Attributes: TYPE, STATIC
    .asciz    "objc_object"           ## External Name
    .long    471                     ## DIE offset
    .byte    144                     ## Attributes: TYPE, STATIC
    .asciz    "SEL"                   ## External Name
    .long    43                      ## DIE offset
    .byte    144                     ## Attributes: TYPE, STATIC
    .asciz    "Person"                ## External Name
    .long    413                     ## DIE offset
    .byte    144                     ## Attributes: TYPE, STATIC
    .asciz    "id"                    ## External Name
    .long    0                       ## End Mark
LpubTypes_end0:

.subsections_via_symbols
    .section    __DWARF,__debug_line,regular,debug
Lsection_line:
Lline_table_start0:

