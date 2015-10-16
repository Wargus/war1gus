/*
* This file is part of the Scale2x project.
*
* Copyright (C) 2003, 2013 Andrea Mazzoleni
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*/

/*
* This is part of the source of a simple command line tool which uses the reference
* implementation of the Scale effects.
*
* You can find an high level description of the effects at :
*
* http://www.scale2x.it/
*/

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

typedef char pixel_t;

pixel_t pixel_get(int x, int y, const unsigned char* pix, unsigned slice, unsigned pixel, int dx, int dy, int opt_tes)
{
	const unsigned char* p;
	unsigned i;
	pixel_t v;

	if (opt_tes) {
		if (x < 0)
			x += dx;
		if (x >= dx)
			x -= dx;
		if (y < 0)
			y += dy;
		if (y >= dy)
			y -= dy;
	}
	else {
		if (x < 0)
			x = 0;
		if (x >= dx)
			x = dx - 1;
		if (y < 0)
			y = 0;
		if (y >= dy)
			y = dy - 1;
	}

	p = pix + (y * slice) + (x * pixel);

	v = 0;
	for (i = 0; i<pixel; ++i)
		v |= ((pixel_t)p[i]) << (i * 8);

	return v;
}

void pixel_put(int x, int y, unsigned char* pix, unsigned slice, unsigned pixel, int dx, int dy, pixel_t v)
{
	unsigned char* p;
	unsigned i;

	if (x < 0 || x >= dx)
		return;
	if (y < 0 || y >= dy)
		return;

	p = pix + (y * slice) + (x * pixel);

	for (i = 0; i<pixel; ++i) {
		p[i] = v >> (i * 8);
	}
}

pixel_t lerp(pixel_t v0, pixel_t v1, double f)
{
	unsigned r0, g0, b0;
	unsigned r1, g1, b1;

	r0 = v0 & 0xFF;
	g0 = (v0 >> 8) & 0xFF;
	b0 = (v0 >> 16) & 0xFF;

	r1 = v1 & 0xFF;
	g1 = (v1 >> 8) & 0xFF;
	b1 = (v1 >> 16) & 0xFF;

	r0 = (unsigned)(r0 * f + r1 * (1.0 - f));
	g0 = (unsigned)(g0 * f + g1 * (1.0 - f));
	b0 = (unsigned)(b0 * f + b1 * (1.0 - f));

	if (r0 > 255) r0 = 255;
	if (g0 > 255) g0 = 255;
	if (b0 > 255) b0 = 255;

	v0 = r0 + (g0 << 8) + (b0 << 16);

	return v0 | 0xFF000000;
}

void scale2x(unsigned char* dst_ptr, const unsigned char* src_ptr, int width, int height)
{
	unsigned pixel = 1; // size of 1 pixel in src
	unsigned src_slice = pixel * width; // size of 1 line in src
	unsigned dst_slice = src_slice * 2; // size of 1 line in dst
	int x;
	int y;
	int opt_tes = 1; // flag 1 or 0
	int opt_ver = 1; // version 0 to 4

	for (y = 0; y<height; ++y) {
		for (x = 0; x<width; ++x) {
			pixel_t E0, E1, E2, E3;
			pixel_t A, B, C, D, E, F, G, H, I;

			A = pixel_get(x - 1, y - 1, src_ptr, src_slice, pixel, width, height, opt_tes);
			B = pixel_get(x, y - 1, src_ptr, src_slice, pixel, width, height, opt_tes);
			C = pixel_get(x + 1, y - 1, src_ptr, src_slice, pixel, width, height, opt_tes);
			D = pixel_get(x - 1, y, src_ptr, src_slice, pixel, width, height, opt_tes);
			E = pixel_get(x, y, src_ptr, src_slice, pixel, width, height, opt_tes);
			F = pixel_get(x + 1, y, src_ptr, src_slice, pixel, width, height, opt_tes);
			G = pixel_get(x - 1, y + 1, src_ptr, src_slice, pixel, width, height, opt_tes);
			H = pixel_get(x, y + 1, src_ptr, src_slice, pixel, width, height, opt_tes);
			I = pixel_get(x + 1, y + 1, src_ptr, src_slice, pixel, width, height, opt_tes);

			/*
			ABC
			DEF
			GHI

			E0E1
			E2E3
			*/
			switch (opt_ver) {
			default:
			case 0:
				/* version 0, normal scaling */
				E0 = E;
				E1 = E;
				E2 = E;
				E3 = E;
				break;
			case 1:
				/* default */
				E0 = D == B && B != F && D != H ? D : E;
				E1 = B == F && B != D && F != H ? F : E;
				E2 = D == H && D != B && H != F ? D : E;
				E3 = H == F && D != H && B != F ? F : E;
				break;

			case 2:
				/* scalek */

#define SCALE2K_BASE(A,B,C,D,E,F,G,H,I,E0,E1,E2,E3) \
	if (D == B && B != E && D != E) { \
		/* diagonal */ \
		if (B == C && D == G) { \
			/* square block */ \
		} else if (B == C) { \
			/* horizontal slope */ \
			E0 = lerp(D, E0, 0.75); \
			E1 = lerp(D, E1, 0.25); \
		} else if (D == G) { \
			/* vertical slope */ \
			E0 = lerp(D, E0, 0.75); \
			E2 = lerp(D, E2, 0.25); \
		} else { \
			/* pure diagonal */ \
			E0 = lerp(E0,D,0.5); \
		} \
	}

				/* Used by AdvanceMAME */
#define SCALE2K(A,B,C,D,E,F,G,H,I,E0,E1,E2,E3) \
	if (D == B && B != E && D != E) { \
		/* diagonal */ \
		if (B == C && D == G) { \
			/* square block */ \
			if (A != E) { \
				/* no star */ \
				E0 = lerp(D, E0, 0.75); \
				E1 = lerp(D, E1, 0.25); \
				E2 = lerp(D, E2, 0.25); \
			} \
		} else if (B == C && C != F) { \
			/* horizontal slope */ \
			E0 = lerp(D, E0, 0.75); \
			E1 = lerp(D, E1, 0.25); \
		} else if (D == G && G != H) { \
			/* vertical slope */ \
			E0 = lerp(D, E0, 0.75); \
			E2 = lerp(D, E2, 0.25); \
		} else { \
			/* pure diagonal */ \
			E0 = lerp(E0,D,0.5); \
		} \
	}

#define SCALE2K_SPIKE(A,B,C,D,E,F,G,H,I,E0,E1,E2,E3) \
	if (B != E && D != E) { \
		if (D == B) { \
			/* diagonal */ \
			if (B == C && D == G) { \
				/* square block */ \
			} else if (B == C) { \
				/* horizontal slope */ \
				E0 = lerp(D, E0, 0.75); \
				E1 = lerp(D, E1, 0.25); \
			} else if (D == G) { \
				/* vertical slope */ \
				E0 = lerp(D, E0, 0.75); \
				E2 = lerp(D, E2, 0.25); \
			} else { \
				/* pure diagonal */ \
				E0 = lerp(E0,D,0.5); \
			} \
		} else if (A == B && G == E) { \
			/* horizontal spike */ \
			E0 = lerp(D, E0, 0.5); \
		} else if (A == D && C == E) { \
			/* vertical spike */ \
			E0 = lerp(B, E0, 0.5); \
		} \
	}

#define SCALE2K_ALTERNATE(A,B,C,D,E,F,G,H,I,E0,E1,E2,E3) \
	if (D == B && B != F && D != H) { \
		/* diagonal */ \
		if (B == C && D == G) { \
			/* square block */ \
			if (A != E) { \
				E0 = lerp(D, E0, 0.75); \
				E1 = lerp(D, E1, 0.25); \
				E2 = lerp(D, E2, 0.25); \
			} \
		} else if (B == C && C != F) { \
			/* horizontal slope */ \
			E0 = lerp(D, E0, 0.75); \
			E1 = lerp(D, E1, 0.25); \
		} else if (D == G && G != H) { \
			/* vertical slope */ \
			E0 = lerp(D, E0, 0.75); \
			E2 = lerp(D, E2, 0.25); \
		} else { \
			/* pure diagonal */ \
			E0 = lerp(E0,D,0.5); \
		} \
	}

				E0 = E1 = E2 = E3 = E;

				SCALE2K(A, B, C, D, E, F, G, H, I, E0, E1, E2, E3);
				SCALE2K(G, D, A, H, E, B, I, F, C, E2, E0, E3, E1);
				SCALE2K(I, H, G, F, E, D, C, B, A, E3, E2, E1, E0);
				SCALE2K(C, F, I, B, E, H, A, D, G, E1, E3, E0, E2);

				break;

			case 3:
				/* rejected */
				E0 = D == B && ((B != F && D != H) || D == A) ? D : E;
				E1 = B == F && ((B != D && F != H) || B == C) ? F : E;
				E2 = D == H && ((D != B && H != F) || D == G) ? D : E;
				E3 = H == F && ((D != H && B != F) || H == I) ? F : E;
				break;
			case 4:
				/* rejected, loses isolated pixels */
				E0 = D == B && A != E ? D : E;
				E1 = B == F && C != E ? F : E;
				E2 = D == H && G != E ? D : E;
				E3 = H == F && I != E ? F : E;
				break;
			}

			pixel_put(x * 2, y * 2, dst_ptr, dst_slice, pixel, width * 2, height * 2, E0);
			pixel_put(x * 2 + 1, y * 2, dst_ptr, dst_slice, pixel, width * 2, height * 2, E1);
			pixel_put(x * 2, y * 2 + 1, dst_ptr, dst_slice, pixel, width * 2, height * 2, E2);
			pixel_put(x * 2 + 1, y * 2 + 1, dst_ptr, dst_slice, pixel, width * 2, height * 2, E3);
		}
	}
}
