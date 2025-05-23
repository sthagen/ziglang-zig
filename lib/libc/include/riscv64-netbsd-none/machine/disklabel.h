/* $NetBSD: disklabel.h,v 1.2 2022/05/24 19:37:39 andvar Exp $ */

/*-
 * Copyright (c) 2014 The NetBSD Foundation, Inc.
 * All rights reserved.
 *
 * This code is derived from software contributed to The NetBSD Foundation
 * by Matt Thomas of 3am Software Foundry.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE NETBSD FOUNDATION, INC. AND CONTRIBUTORS
 * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE FOUNDATION OR CONTRIBUTORS
 * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */

#ifndef _RISCV_DISKLABEL_H_
#define _RISCV_DISKLABEL_H_

#define LABELUSESMBR		1	/* use MBR partitionning */
#define LABELSECTOR		1	/* sector containing label */
#define LABELOFFSET		0	/* offset of label in sector */
#define MAXPARTITIONS		16	/* number of partitions */
#define RAW_PART		2	/* raw partition: XX?c */

#if HAVE_NBTOOL_CONFIG_H
#include <nbinclude/sys/dkbad.h>
#include <nbinclude/sys/bootblock.h>
#else
#include <sys/dkbad.h>
#include <sys/bootblock.h>
#endif /* HAVE_NBTOOL_CONFIG_H */

struct cpu_disklabel {
	struct mbr_partition mbrparts[MBR_PART_COUNT];
#define __HAVE_DISKLABEL_DKBAD
	struct dkbad bad;
};

#ifdef _KERNEL
struct buf;
struct disklabel;

/* for readdisklabel.  rv != 0 -> matches, msg == NULL -> success */
int	mbr_label_read(dev_t, void (*)(struct buf *), struct disklabel *,
	    struct cpu_disklabel *, const char **, int *, int *);

/* for writedisklabel.  rv == 0 -> doesn't match, rv > 0 -> success */
int	mbr_label_locate(dev_t, void (*)(struct buf *),
	    struct disklabel *, struct cpu_disklabel *, int *, int *);
#endif /* _KERNEL */

#endif /* _RISCV_DISKLABEL_H_ */