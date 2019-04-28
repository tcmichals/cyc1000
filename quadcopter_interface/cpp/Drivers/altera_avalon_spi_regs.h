/******************************************************************************
*                                                                             *
* License Agreement                                                           *
*                                                                             *
* Copyright (c) 2003 Altera Corporation, San Jose, California, USA.           *
* All rights reserved.                                                        *
*                                                                             *
* Permission is hereby granted, free of charge, to any person obtaining a     *
* copy of this software and associated documentation files (the "Software"),  *
* to deal in the Software without restriction, including without limitation   *
* the rights to use, copy, modify, merge, publish, distribute, sublicense,    *
* and/or sell copies of the Software, and to permit persons to whom the       *
* Software is furnished to do so, subject to the following conditions:        *
*                                                                             *
* The above copyright notice and this permission notice shall be included in  *
* all copies or substantial portions of the Software.                         *
*                                                                             *
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  *
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,    *
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE *
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER      *
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING     *
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER         *
* DEALINGS IN THE SOFTWARE.                                                   *
*                                                                             *
* This agreement shall be governed in all respects by the laws of the State   *
* of California and by the laws of the United States of America.              *
*                                                                             *
******************************************************************************/

#ifndef __ALTERA_AVALON_SPI_REGS_H__
#define __ALTERA_AVALON_SPI_REGS_H__

#include <io.h>

#define IOADDR_ALTERA_AVALON_SPI_RXDATA(base)         __IO_CALC_ADDRESS_NATIVE(base, 0)
#define IORD_ALTERA_AVALON_SPI_RXDATA(base)           IORD(base, 0) 
#define IOWR_ALTERA_AVALON_SPI_RXDATA(base, data)     IOWR(base, 0, data)

#define IOADDR_ALTERA_AVALON_SPI_TXDATA(base)         __IO_CALC_ADDRESS_NATIVE(base, 1)
#define IORD_ALTERA_AVALON_SPI_TXDATA(base)           IORD(base, 1) 
#define IOWR_ALTERA_AVALON_SPI_TXDATA(base, data)     IOWR(base, 1, data)

#define IOADDR_ALTERA_AVALON_SPI_STATUS(base)         __IO_CALC_ADDRESS_NATIVE(base, 2)
#define IORD_ALTERA_AVALON_SPI_STATUS(base)           IORD(base, 2) 
#define IOWR_ALTERA_AVALON_SPI_STATUS(base, data)     IOWR(base, 2, data)

#define ALTERA_AVALON_SPI_STATUS_ROE_MSK              (0x8)
#define ALTERA_AVALON_SPI_STATUS_ROE_OFST             (3)
#define ALTERA_AVALON_SPI_STATUS_TOE_MSK              (0x10)
#define ALTERA_AVALON_SPI_STATUS_TOE_OFST             (4)
#define ALTERA_AVALON_SPI_STATUS_TMT_MSK              (0x20)
#define ALTERA_AVALON_SPI_STATUS_TMT_OFST             (5)
#define ALTERA_AVALON_SPI_STATUS_TRDY_MSK             (0x40)
#define ALTERA_AVALON_SPI_STATUS_TRDY_OFST            (6)
#define ALTERA_AVALON_SPI_STATUS_RRDY_MSK             (0x80)
#define ALTERA_AVALON_SPI_STATUS_RRDY_OFST            (7)
#define ALTERA_AVALON_SPI_STATUS_E_MSK                (0x100)
#define ALTERA_AVALON_SPI_STATUS_E_OFST               (8)

#define IOADDR_ALTERA_AVALON_SPI_CONTROL(base)        __IO_CALC_ADDRESS_NATIVE(base, 3)
#define IORD_ALTERA_AVALON_SPI_CONTROL(base)          IORD(base, 3) 
#define IOWR_ALTERA_AVALON_SPI_CONTROL(base, data)    IOWR(base, 3, data)

#define ALTERA_AVALON_SPI_CONTROL_IROE_MSK            (0x8)
#define ALTERA_AVALON_SPI_CONTROL_IROE_OFST           (3)
#define ALTERA_AVALON_SPI_CONTROL_ITOE_MSK            (0x10)
#define ALTERA_AVALON_SPI_CONTROL_ITOE_OFST           (4)
#define ALTERA_AVALON_SPI_CONTROL_ITRDY_MSK           (0x40)
#define ALTERA_AVALON_SPI_CONTROL_ITRDY_OFS           (6)
#define ALTERA_AVALON_SPI_CONTROL_IRRDY_MSK           (0x80)
#define ALTERA_AVALON_SPI_CONTROL_IRRDY_OFS           (7)
#define ALTERA_AVALON_SPI_CONTROL_IE_MSK              (0x100)
#define ALTERA_AVALON_SPI_CONTROL_IE_OFST             (8)
#define ALTERA_AVALON_SPI_CONTROL_SSO_MSK             (0x400)
#define ALTERA_AVALON_SPI_CONTROL_SSO_OFST            (10)

#define IOADDR_ALTERA_AVALON_SPI_SLAVE_SEL(base)      __IO_CALC_ADDRESS_NATIVE(base, 5)
#define IORD_ALTERA_AVALON_SPI_SLAVE_SEL(base)        IORD(base, 5) 
#define IOWR_ALTERA_AVALON_SPI_SLAVE_SEL(base, data)  IOWR(base, 5, data)

#endif /* __ALTERA_AVALON_SPI_REGS_H__ */
