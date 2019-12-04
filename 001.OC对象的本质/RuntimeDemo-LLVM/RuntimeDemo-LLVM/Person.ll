; ModuleID = 'Person.m'
source_filename = "Person.m"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.14.0"

%0 = type opaque
%1 = type opaque
%2 = type opaque
%3 = type opaque
%struct.__NSConstantString_tag = type { i32*, i32, i8*, i64 }
%struct._class_t = type { %struct._class_t*, %struct._class_t*, %struct._objc_cache*, i8* (i8*, i8*)**, %struct._class_ro_t* }
%struct._objc_cache = type opaque
%struct._class_ro_t = type { i32, i32, i32, i8*, i8*, %struct.__method_list_t*, %struct._objc_protocol_list*, %struct._ivar_list_t*, i8*, %struct._prop_list_t* }
%struct.__method_list_t = type { i32, i32, [0 x %struct._objc_method] }
%struct._objc_method = type { i8*, i8*, i8* }
%struct._objc_protocol_list = type { i64, [0 x %struct._protocol_t*] }
%struct._protocol_t = type { i8*, i8*, %struct._objc_protocol_list*, %struct.__method_list_t*, %struct.__method_list_t*, %struct.__method_list_t*, %struct.__method_list_t*, %struct._prop_list_t*, i32, i32, i8**, i8*, %struct._prop_list_t* }
%struct._ivar_list_t = type { i32, i32, [0 x %struct._ivar_t] }
%struct._ivar_t = type { i64*, i8*, i8*, i32, i32 }
%struct._prop_list_t = type { i32, i32, [0 x %struct._prop_t] }
%struct._prop_t = type { i8*, i8* }
%struct._objc_super = type { i8*, i8* }

@__CFConstantStringClassReference = external global [0 x i32]
@.str = private unnamed_addr constant [3 x i8] c"%s\00", section "__TEXT,__cstring,cstring_literals", align 1
@_unnamed_cfstring_ = private global %struct.__NSConstantString_tag { i32* getelementptr inbounds ([0 x i32], [0 x i32]* @__CFConstantStringClassReference, i32 0, i32 0), i32 1992, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i32 0, i32 0), i64 2 }, section "__DATA,__cfstring", align 8
@"__func__.-[Person other]" = private unnamed_addr constant [16 x i8] c"-[Person other]\00", align 1
@OBJC_METH_VAR_NAME_ = private unnamed_addr constant [4 x i8] c"run\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_SELECTOR_REFERENCES_ = private externally_initialized global i8* getelementptr inbounds ([4 x i8], [4 x i8]* @OBJC_METH_VAR_NAME_, i32 0, i32 0), section "__DATA,__objc_selrefs,literal_pointers,no_dead_strip", align 8
@"OBJC_CLASS_$_Person" = global %struct._class_t { %struct._class_t* @"OBJC_METACLASS_$_Person", %struct._class_t* @"OBJC_CLASS_$_NSObject", %struct._objc_cache* @_objc_empty_cache, i8* (i8*, i8*)** null, %struct._class_ro_t* @"\01l_OBJC_CLASS_RO_$_Person" }, section "__DATA, __objc_data", align 8
@"OBJC_CLASSLIST_SUP_REFS_$_" = private global %struct._class_t* @"OBJC_CLASS_$_Person", section "__DATA,__objc_superrefs,regular,no_dead_strip", align 8
@OBJC_METH_VAR_NAME_.1 = private unnamed_addr constant [29 x i8] c"forwardingTargetForSelector:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_SELECTOR_REFERENCES_.2 = private externally_initialized global i8* getelementptr inbounds ([29 x i8], [29 x i8]* @OBJC_METH_VAR_NAME_.1, i32 0, i32 0), section "__DATA,__objc_selrefs,literal_pointers,no_dead_strip", align 8
@"OBJC_CLASS_$_NSMethodSignature" = external global %struct._class_t
@"OBJC_CLASSLIST_REFERENCES_$_" = private global %struct._class_t* @"OBJC_CLASS_$_NSMethodSignature", section "__DATA,__objc_classrefs,regular,no_dead_strip", align 8
@.str.3 = private unnamed_addr constant [8 x i8] c"v16@0:8\00", align 1
@OBJC_METH_VAR_NAME_.4 = private unnamed_addr constant [24 x i8] c"signatureWithObjCTypes:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_SELECTOR_REFERENCES_.5 = private externally_initialized global i8* getelementptr inbounds ([24 x i8], [24 x i8]* @OBJC_METH_VAR_NAME_.4, i32 0, i32 0), section "__DATA,__objc_selrefs,literal_pointers,no_dead_strip", align 8
@OBJC_METH_VAR_NAME_.6 = private unnamed_addr constant [28 x i8] c"methodSignatureForSelector:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_SELECTOR_REFERENCES_.7 = private externally_initialized global i8* getelementptr inbounds ([28 x i8], [28 x i8]* @OBJC_METH_VAR_NAME_.6, i32 0, i32 0), section "__DATA,__objc_selrefs,literal_pointers,no_dead_strip", align 8
@"OBJC_CLASS_$_Test" = external global %struct._class_t
@"OBJC_CLASSLIST_REFERENCES_$_.8" = private global %struct._class_t* @"OBJC_CLASS_$_Test", section "__DATA,__objc_classrefs,regular,no_dead_strip", align 8
@OBJC_METH_VAR_NAME_.9 = private unnamed_addr constant [5 x i8] c"init\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_SELECTOR_REFERENCES_.10 = private externally_initialized global i8* getelementptr inbounds ([5 x i8], [5 x i8]* @OBJC_METH_VAR_NAME_.9, i32 0, i32 0), section "__DATA,__objc_selrefs,literal_pointers,no_dead_strip", align 8
@OBJC_METH_VAR_NAME_.11 = private unnamed_addr constant [18 x i8] c"invokeWithTarget:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_SELECTOR_REFERENCES_.12 = private externally_initialized global i8* getelementptr inbounds ([18 x i8], [18 x i8]* @OBJC_METH_VAR_NAME_.11, i32 0, i32 0), section "__DATA,__objc_selrefs,literal_pointers,no_dead_strip", align 8
@_objc_empty_cache = external global %struct._objc_cache
@"OBJC_METACLASS_$_NSObject" = external global %struct._class_t
@OBJC_CLASS_NAME_ = private unnamed_addr constant [7 x i8] c"Person\00", section "__TEXT,__objc_classname,cstring_literals", align 1
@"\01l_OBJC_METACLASS_RO_$_Person" = private global %struct._class_ro_t { i32 1, i32 40, i32 40, i8* null, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @OBJC_CLASS_NAME_, i32 0, i32 0), %struct.__method_list_t* null, %struct._objc_protocol_list* null, %struct._ivar_list_t* null, i8* null, %struct._prop_list_t* null }, section "__DATA, __objc_const", align 8
@"OBJC_METACLASS_$_Person" = global %struct._class_t { %struct._class_t* @"OBJC_METACLASS_$_NSObject", %struct._class_t* @"OBJC_METACLASS_$_NSObject", %struct._objc_cache* @_objc_empty_cache, i8* (i8*, i8*)** null, %struct._class_ro_t* @"\01l_OBJC_METACLASS_RO_$_Person" }, section "__DATA, __objc_data", align 8
@"OBJC_CLASS_$_NSObject" = external global %struct._class_t
@OBJC_METH_VAR_NAME_.13 = private unnamed_addr constant [6 x i8] c"other\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_ = private unnamed_addr constant [8 x i8] c"v16@0:8\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.14 = private unnamed_addr constant [11 x i8] c"@24@0:8:16\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.15 = private unnamed_addr constant [19 x i8] c"forwardInvocation:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.16 = private unnamed_addr constant [11 x i8] c"v24@0:8@16\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@"\01l_OBJC_$_INSTANCE_METHODS_Person" = private global { i32, i32, [4 x %struct._objc_method] } { i32 24, i32 4, [4 x %struct._objc_method] [%struct._objc_method { i8* getelementptr inbounds ([6 x i8], [6 x i8]* @OBJC_METH_VAR_NAME_.13, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_, i32 0, i32 0), i8* bitcast (void (%0*, i8*)* @"\01-[Person other]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([29 x i8], [29 x i8]* @OBJC_METH_VAR_NAME_.1, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.14, i32 0, i32 0), i8* bitcast (i8* (%0*, i8*, i8*)* @"\01-[Person forwardingTargetForSelector:]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([28 x i8], [28 x i8]* @OBJC_METH_VAR_NAME_.6, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.14, i32 0, i32 0), i8* bitcast (%1* (%0*, i8*, i8*)* @"\01-[Person methodSignatureForSelector:]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([19 x i8], [19 x i8]* @OBJC_METH_VAR_NAME_.15, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.16, i32 0, i32 0), i8* bitcast (void (%0*, i8*, %2*)* @"\01-[Person forwardInvocation:]" to i8*) }] }, section "__DATA, __objc_const", align 8
@"\01l_OBJC_CLASS_RO_$_Person" = private global %struct._class_ro_t { i32 0, i32 8, i32 8, i8* null, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @OBJC_CLASS_NAME_, i32 0, i32 0), %struct.__method_list_t* bitcast ({ i32, i32, [4 x %struct._objc_method] }* @"\01l_OBJC_$_INSTANCE_METHODS_Person" to %struct.__method_list_t*), %struct._objc_protocol_list* null, %struct._ivar_list_t* null, i8* null, %struct._prop_list_t* null }, section "__DATA, __objc_const", align 8
@"OBJC_LABEL_CLASS_$" = private global [1 x i8*] [i8* bitcast (%struct._class_t* @"OBJC_CLASS_$_Person" to i8*)], section "__DATA,__objc_classlist,regular,no_dead_strip", align 8
@llvm.compiler.used = appending global [23 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @OBJC_METH_VAR_NAME_, i32 0, i32 0), i8* bitcast (i8** @OBJC_SELECTOR_REFERENCES_ to i8*), i8* bitcast (%struct._class_t** @"OBJC_CLASSLIST_SUP_REFS_$_" to i8*), i8* getelementptr inbounds ([29 x i8], [29 x i8]* @OBJC_METH_VAR_NAME_.1, i32 0, i32 0), i8* bitcast (i8** @OBJC_SELECTOR_REFERENCES_.2 to i8*), i8* bitcast (%struct._class_t** @"OBJC_CLASSLIST_REFERENCES_$_" to i8*), i8* getelementptr inbounds ([24 x i8], [24 x i8]* @OBJC_METH_VAR_NAME_.4, i32 0, i32 0), i8* bitcast (i8** @OBJC_SELECTOR_REFERENCES_.5 to i8*), i8* getelementptr inbounds ([28 x i8], [28 x i8]* @OBJC_METH_VAR_NAME_.6, i32 0, i32 0), i8* bitcast (i8** @OBJC_SELECTOR_REFERENCES_.7 to i8*), i8* bitcast (%struct._class_t** @"OBJC_CLASSLIST_REFERENCES_$_.8" to i8*), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @OBJC_METH_VAR_NAME_.9, i32 0, i32 0), i8* bitcast (i8** @OBJC_SELECTOR_REFERENCES_.10 to i8*), i8* getelementptr inbounds ([18 x i8], [18 x i8]* @OBJC_METH_VAR_NAME_.11, i32 0, i32 0), i8* bitcast (i8** @OBJC_SELECTOR_REFERENCES_.12 to i8*), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @OBJC_CLASS_NAME_, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @OBJC_METH_VAR_NAME_.13, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.14, i32 0, i32 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @OBJC_METH_VAR_NAME_.15, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.16, i32 0, i32 0), i8* bitcast ({ i32, i32, [4 x %struct._objc_method] }* @"\01l_OBJC_$_INSTANCE_METHODS_Person" to i8*), i8* bitcast ([1 x i8*]* @"OBJC_LABEL_CLASS_$" to i8*)], section "llvm.metadata"

; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01-[Person other]"(%0*, i8*) #0 {
  %3 = alloca %0*, align 8
  %4 = alloca i8*, align 8
  store %0* %0, %0** %3, align 8
  store i8* %1, i8** %4, align 8
  notail call void (i8*, ...) @NSLog(i8* bitcast (%struct.__NSConstantString_tag* @_unnamed_cfstring_ to i8*), i8* getelementptr inbounds ([16 x i8], [16 x i8]* @"__func__.-[Person other]", i32 0, i32 0))
  ret void
}

declare void @NSLog(i8*, ...) #1

; Function Attrs: noinline optnone ssp uwtable
define internal i8* @"\01-[Person forwardingTargetForSelector:]"(%0*, i8*, i8*) #0 {
  %4 = alloca i8*, align 8
  %5 = alloca %0*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca %struct._objc_super, align 8
  store %0* %0, %0** %5, align 8
  store i8* %1, i8** %6, align 8
  store i8* %2, i8** %7, align 8
  %9 = load i8*, i8** %7, align 8
  %10 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_, align 8, !invariant.load !8
  %11 = icmp eq i8* %9, %10
  br i1 %11, label %12, label %13

; <label>:12:                                     ; preds = %3
  store i8* null, i8** %4, align 8
  br label %23

; <label>:13:                                     ; preds = %3
  %14 = load %0*, %0** %5, align 8
  %15 = load i8*, i8** %7, align 8
  %16 = bitcast %0* %14 to i8*
  %17 = getelementptr inbounds %struct._objc_super, %struct._objc_super* %8, i32 0, i32 0
  store i8* %16, i8** %17, align 8
  %18 = load %struct._class_t*, %struct._class_t** @"OBJC_CLASSLIST_SUP_REFS_$_", align 8
  %19 = bitcast %struct._class_t* %18 to i8*
  %20 = getelementptr inbounds %struct._objc_super, %struct._objc_super* %8, i32 0, i32 1
  store i8* %19, i8** %20, align 8
  %21 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_.2, align 8, !invariant.load !8
  %22 = call i8* bitcast (i8* (%struct._objc_super*, i8*, ...)* @objc_msgSendSuper2 to i8* (%struct._objc_super*, i8*, i8*)*)(%struct._objc_super* %8, i8* %21, i8* %15)
  store i8* %22, i8** %4, align 8
  br label %23

; <label>:23:                                     ; preds = %13, %12
  %24 = load i8*, i8** %4, align 8
  ret i8* %24
}

declare i8* @objc_msgSendSuper2(%struct._objc_super*, i8*, ...)

; Function Attrs: noinline optnone ssp uwtable
define internal %1* @"\01-[Person methodSignatureForSelector:]"(%0*, i8*, i8*) #0 {
  %4 = alloca %1*, align 8
  %5 = alloca %0*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca %struct._objc_super, align 8
  store %0* %0, %0** %5, align 8
  store i8* %1, i8** %6, align 8
  store i8* %2, i8** %7, align 8
  %9 = load i8*, i8** %7, align 8
  %10 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_, align 8, !invariant.load !8
  %11 = icmp eq i8* %9, %10
  br i1 %11, label %12, label %17

; <label>:12:                                     ; preds = %3
  %13 = load %struct._class_t*, %struct._class_t** @"OBJC_CLASSLIST_REFERENCES_$_", align 8
  %14 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_.5, align 8, !invariant.load !8
  %15 = bitcast %struct._class_t* %13 to i8*
  %16 = call %1* bitcast (i8* (i8*, i8*, ...)* @objc_msgSend to %1* (i8*, i8*, i8*)*)(i8* %15, i8* %14, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.3, i32 0, i32 0))
  store %1* %16, %1** %4, align 8
  br label %27

; <label>:17:                                     ; preds = %3
  %18 = load %0*, %0** %5, align 8
  %19 = load i8*, i8** %7, align 8
  %20 = bitcast %0* %18 to i8*
  %21 = getelementptr inbounds %struct._objc_super, %struct._objc_super* %8, i32 0, i32 0
  store i8* %20, i8** %21, align 8
  %22 = load %struct._class_t*, %struct._class_t** @"OBJC_CLASSLIST_SUP_REFS_$_", align 8
  %23 = bitcast %struct._class_t* %22 to i8*
  %24 = getelementptr inbounds %struct._objc_super, %struct._objc_super* %8, i32 0, i32 1
  store i8* %23, i8** %24, align 8
  %25 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_.7, align 8, !invariant.load !8
  %26 = call %1* bitcast (i8* (%struct._objc_super*, i8*, ...)* @objc_msgSendSuper2 to %1* (%struct._objc_super*, i8*, i8*)*)(%struct._objc_super* %8, i8* %25, i8* %19)
  store %1* %26, %1** %4, align 8
  br label %27

; <label>:27:                                     ; preds = %17, %12
  %28 = load %1*, %1** %4, align 8
  ret %1* %28
}

; Function Attrs: nonlazybind
declare i8* @objc_msgSend(i8*, i8*, ...) #2

; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01-[Person forwardInvocation:]"(%0*, i8*, %2*) #0 {
  %4 = alloca %0*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca %2*, align 8
  store %0* %0, %0** %4, align 8
  store i8* %1, i8** %5, align 8
  store %2* %2, %2** %6, align 8
  %7 = load %2*, %2** %6, align 8
  %8 = load %struct._class_t*, %struct._class_t** @"OBJC_CLASSLIST_REFERENCES_$_.8", align 8
  %9 = bitcast %struct._class_t* %8 to i8*
  %10 = call i8* @objc_alloc(i8* %9)
  %11 = bitcast i8* %10 to %3*
  %12 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_.10, align 8, !invariant.load !8
  %13 = bitcast %3* %11 to i8*
  %14 = call i8* bitcast (i8* (i8*, i8*, ...)* @objc_msgSend to i8* (i8*, i8*)*)(i8* %13, i8* %12)
  %15 = bitcast i8* %14 to %3*
  %16 = bitcast %3* %15 to i8*
  %17 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_.12, align 8, !invariant.load !8
  %18 = bitcast %2* %7 to i8*
  call void bitcast (i8* (i8*, i8*, ...)* @objc_msgSend to void (i8*, i8*, i8*)*)(i8* %18, i8* %17, i8* %16)
  ret void
}

declare i8* @objc_alloc(i8*)

attributes #0 = { noinline optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nonlazybind }

!llvm.module.flags = !{!0, !1, !2, !3, !4, !5, !6}
!llvm.ident = !{!7}

!0 = !{i32 1, !"Objective-C Version", i32 2}
!1 = !{i32 1, !"Objective-C Image Info Version", i32 0}
!2 = !{i32 1, !"Objective-C Image Info Section", !"__DATA,__objc_imageinfo,regular,no_dead_strip"}
!3 = !{i32 4, !"Objective-C Garbage Collection", i32 0}
!4 = !{i32 1, !"Objective-C Class Properties", i32 64}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{i32 7, !"PIC Level", i32 2}
!7 = !{!"Apple clang version 11.0.0 (clang-1100.0.33.8)"}
!8 = !{}
