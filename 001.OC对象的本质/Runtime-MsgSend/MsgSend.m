ENTRY _objc_msgSend
	MESSENGER_START

// x0寄存器：消息接收者，receiver
	cmp	x0, #0			// nil check and tagged pointer check
	//跳转：小于等于
	b.le	LNilOrTagged		//  (MSB tagged pointer looks negative)
	ldr	x13, [x0]		// x13 = isa
	and	x9, x13, #ISA_MASK	// x9 = class	
LGetIsaDone:
	CacheLookup NORMAL		// calls imp or objc_msgSend_uncached

LNilOrTagged:
	b.eq	LReturnZero		// nil check

	// tagged
	adrp	x10, _objc_debug_taggedpointer_classes@PAGE
	add	x10, x10, _objc_debug_taggedpointer_classes@PAGEOFF
	ubfx	x11, x0, #60, #4
	ldr	x9, [x10, x11, LSL #3]
	b	LGetIsaDone

LReturnZero:
	// x0 is already zero
	mov	x1, #0
	movi	d0, #0
	movi	d1, #0
	movi	d2, #0
	movi	d3, #0
	MESSENGER_END_NIL
	ret

	END_ENTRY _objc_msgSend


	ENTRY _objc_msgSendSuper
	MESSENGER_START

	ldr	x9, [x0, #CLASS]	// load class to search
	ldr	x0, [x0, #RECEIVER]	// load real receiver
	CacheLookup NORMAL		// calls imp or objc_msgSend_uncached

	END_ENTRY _objc_msgSendSuper

	
	ENTRY _objc_msgSendSuper2
	MESSENGER_START

	ldr	x9, [x0, #CLASS]
	ldr	x9, [x9, #SUPERCLASS]	// load class to search
	ldr	x0, [x0, #RECEIVER]	// load real receiver
	CacheLookup NORMAL

	END_ENTRY _objc_msgSendSuper2


	ENTRY _objc_msgSend_noarg
	b	_objc_msgSend
	END_ENTRY _objc_msgSend_noarg


	STATIC_ENTRY __objc_msgSend_uncached_impcache

	// THIS IS NOT A CALLABLE C FUNCTION
	// Out-of-band x9 is the class to search

	MESSENGER_START
	
	// push frame
	stp	fp, lr, [sp, #-16]!
	mov	fp, sp

	MESSENGER_END_SLOW

	// save parameter registers: x0..x8, q0..q7
	sub	sp, sp, #(10*8 + 8*16)
	stp	q0, q1, [sp, #(0*16)]
	stp	q2, q3, [sp, #(2*16)]
	stp	q4, q5, [sp, #(4*16)]
	stp	q6, q7, [sp, #(6*16)]
	stp	x0, x1, [sp, #(8*16+0*8)]
	stp	x2, x3, [sp, #(8*16+2*8)]
	stp	x4, x5, [sp, #(8*16+4*8)]
	stp	x6, x7, [sp, #(8*16+6*8)]
	str	x8,     [sp, #(8*16+8*8)]

	// receiver and selector already in x0 and x1
	mov	x2, x9
	bl	__class_lookupMethodAndLoadCache3

	// imp in x0
	mov	x17, x0
	
	// restore registers and return
	ldp	q0, q1, [sp, #(0*16)]
	ldp	q2, q3, [sp, #(2*16)]
	ldp	q4, q5, [sp, #(4*16)]
	ldp	q6, q7, [sp, #(6*16)]
	ldp	x0, x1, [sp, #(8*16+0*8)]
	ldp	x2, x3, [sp, #(8*16+2*8)]
	ldp	x4, x5, [sp, #(8*16+4*8)]
	ldp	x6, x7, [sp, #(8*16+6*8)]
	ldr	x8,     [sp, #(8*16+8*8)]

	mov	sp, fp
	ldp	fp, lr, [sp], #16
	
	br	x17

	END_ENTRY __objc_msgSend_uncached_impcache

