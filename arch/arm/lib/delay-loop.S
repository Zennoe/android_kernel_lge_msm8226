/*
 *  linux/arch/arm/lib/delay.S
 *
 *  Copyright (C) 1995, 1996 Russell King
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 */
#include <linux/linkage.h>
#include <asm/assembler.h>
#include <asm/delay.h>
<<<<<<< HEAD
=======

>>>>>>> v4.13
		.text

.LC0:		.word	loops_per_jiffy
.LC1:		.word	UDELAY_MULT

/*
<<<<<<< HEAD
 * r0  <= 2000
 * lpj <= 0x01ffffff (max. 3355 bogomips)
=======
 * loops = r0 * HZ * loops_per_jiffy / 1000000
 *
 * r0  <= 2000
>>>>>>> v4.13
 * HZ  <= 1000
 */

ENTRY(__loop_udelay)
		ldr	r2, .LC1
<<<<<<< HEAD
		mul	r0, r2, r0
ENTRY(__loop_const_udelay)			@ 0 <= r0 <= 0x7fffff06
		mov	r1, #-1
		ldr	r2, .LC0
		ldr	r2, [r2]		@ max = 0x01ffffff
		add	r0, r0, r1, lsr #32-14
		mov	r0, r0, lsr #14		@ max = 0x0001ffff
		add	r2, r2, r1, lsr #32-10
		mov	r2, r2, lsr #10		@ max = 0x00007fff
		mul	r0, r2, r0		@ max = 2^32-1
		add	r0, r0, r1, lsr #32-6
		movs	r0, r0, lsr #6
		moveq	pc, lr

/*
 * loops = r0 * HZ * loops_per_jiffy / 1000000
 */
=======
		mul	r0, r2, r0		@ r0 = delay_us * UDELAY_MULT
ENTRY(__loop_const_udelay)			@ 0 <= r0 <= 0xfffffaf0
		ldr	r2, .LC0
		ldr	r2, [r2]
		umull	r1, r0, r2, r0		@ r0-r1 = r0 * loops_per_jiffy
		adds	r1, r1, #0xffffffff	@ rounding up ...
		adcs	r0, r0, r0		@ and right shift by 31
		reteq	lr

		.align 3
>>>>>>> v4.13

@ Delay routine
ENTRY(__loop_delay)
		subs	r0, r0, #1
#if 0
<<<<<<< HEAD
		movls	pc, lr
		subs	r0, r0, #1
		movls	pc, lr
		subs	r0, r0, #1
		movls	pc, lr
		subs	r0, r0, #1
		movls	pc, lr
		subs	r0, r0, #1
		movls	pc, lr
		subs	r0, r0, #1
		movls	pc, lr
		subs	r0, r0, #1
		movls	pc, lr
		subs	r0, r0, #1
#endif
		bhi	__loop_delay
		mov	pc, lr
=======
		retls	lr
		subs	r0, r0, #1
		retls	lr
		subs	r0, r0, #1
		retls	lr
		subs	r0, r0, #1
		retls	lr
		subs	r0, r0, #1
		retls	lr
		subs	r0, r0, #1
		retls	lr
		subs	r0, r0, #1
		retls	lr
		subs	r0, r0, #1
#endif
		bhi	__loop_delay
		ret	lr
>>>>>>> v4.13
ENDPROC(__loop_udelay)
ENDPROC(__loop_const_udelay)
ENDPROC(__loop_delay)
