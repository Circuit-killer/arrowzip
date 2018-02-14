////////////////////////////////////////////////////////////////////////////////
//
// Filename:	./toplevel.v
//
// Project:	ZBasic, a generic toplevel implementation using the full ZipCPU
//
// DO NOT EDIT THIS FILE!
// Computer Generated: This file is computer generated by AUTOFPGA. DO NOT EDIT.
// DO NOT EDIT THIS FILE!
//
// CmdLine:	../../../autofpga/trunk/sw/autofpga ../../../autofpga/trunk/sw/autofpga -o . global.txt bkram.txt buserr.txt clock.txt dlyarbiter.txt rtclight.txt sdram.txt flexpress.txt pic.txt pwrcount.txt memsdev.txt spio.txt version.txt hbconsole.txt zipbones.txt
//
// Creator:	Dan Gisselquist, Ph.D.
//		Gisselquist Technology, LLC
//
////////////////////////////////////////////////////////////////////////////////
//
// Copyright (C) 2017, Gisselquist Technology, LLC
//
// This program is free software (firmware): you can redistribute it and/or
// modify it under the terms of  the GNU General Public License as published
// by the Free Software Foundation, either version 3 of the License, or (at
// your option) any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTIBILITY or
// FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
// for more details.
//
// You should have received a copy of the GNU General Public License along
// with this program.  (It's in the $(ROOT)/doc directory.  Run make with no
// target there if the PDF file isn't present.)  If not, see
// <http://www.gnu.org/licenses/> for a copy.
//
// License:	GPL, v3, as defined and found on www.gnu.org,
//		http://www.gnu.org/licenses/gpl.html
//
//
////////////////////////////////////////////////////////////////////////////////
//
//
`default_nettype	none


//
// Here we declare our toplevel.v (toplevel) design module.
// All design logic must take place beneath this top level.
//
// The port declarations just copy data from the @TOP.PORTLIST
// key, or equivalently from the @MAIN.PORTLIST key if
// @TOP.PORTLIST is absent.  For those peripherals that don't need
// any top level logic, the @MAIN.PORTLIST should be sufficent,
// so the @TOP.PORTLIST key may be left undefined.
//
module	toplevel(i_clk,
		// UART/host to wishbone interface
		i_uart_rx, o_uart_tx,
		// SPIO interface
		i_btn, o_led,
		// Top level Dual-SPI I/O ports
		o_dspi_cs_n, o_dspi_sck, io_dspi_dat,
		// Top level MEMS (SPI) I/O ports
		o_mems_cs_n, o_mems_sck, o_mems_mosi, i_mems_miso, i_mems_int,
		// Top level SDRAM I/O ports
		o_ram_clk, o_ram_cke, o_ram_cs_n, o_ram_ras_n, o_ram_cas_n,
		o_ram_we_n, o_ram_bs, o_ram_addr, o_ram_udqm, o_ram_ldqm,
		io_ram_data);
	//
	// Declaring our input and output ports.  We listed these above,
	// now we are declaring them here.
	//
	// These declarations just copy data from the @TOP.IODECLS key,
	// or from the @MAIN.IODECL key if @TOP.IODECL is absent.  For
	// those peripherals that don't do anything at the top level,
	// the @MAIN.IODECL key should be sufficient, so the @TOP.IODECL
	// key may be left undefined.
	//
	input	wire		i_clk;
	input	wire		i_uart_rx;
	output	wire		o_uart_tx;
	// SPIO interface
	input	wire		i_btn;
	output	wire	[7:0]	o_led;
	// Dual SPI flash
	output	wire		o_dspi_cs_n;
	output	wire		o_dspi_sck;
	inout	wire	[1:0]	io_dspi_dat;
	// MEMS SPI
	output	wire		o_mems_cs_n, o_mems_sck, o_mems_mosi;
	input	wire		i_mems_miso;
	input	wire	[1:0]	i_mems_int;
	// SDRAM
	output	wire	o_ram_clk, o_ram_cke,
			o_ram_cs_n, o_ram_ras_n, o_ram_cas_n, o_ram_we_n;
	output	wire	[1:0]	o_ram_bs;
	output	wire	[11:0]	o_ram_addr;
	output	wire		o_ram_udqm, o_ram_ldqm;
	output	wire	[15:0]	io_ram_data;


	//
	// Declaring component data, internal wires and registers
	//
	// These declarations just copy data from the @TOP.DEFNS key
	// within the component data files.
	//
	wire	[1:0]	dspi_bmod, w_dspi_sck;
	wire	[1:0]	dspi_dat;
	wire		s_clk, s_reset, mem_clk;
	wire	[15:0]	w_ram_data;
	wire		w_ram_drive_data;
	reg	[15:0]	r_ram_data;


	//
	// Time to call the main module within main.v.  Remember, the purpose
	// of the main.v module is to contain all of our portable logic.
	// Things that are Xilinx (or even Altera) specific, or for that
	// matter anything that requires something other than on-off logic,
	// such as the high impedence states required by many wires, is
	// kept in this (toplevel.v) module.  Everything else goes in
	// main.v.
	//
	// We automatically place s_clk, and s_reset here.  You may need
	// to define those above.  (You did, didn't you?)  Other
	// component descriptions come from the keys @TOP.MAIN (if it
	// exists), or @MAIN.PORTLIST if it does not.
	//

	main	thedesign(s_clk, s_reset,
		// UART/host to wishbone interface
		i_uart_rx, o_uart_tx,
		// SPIO interface
		i_btn, o_led,
		// Dual SPI flash
		o_dspi_cs_n, w_dspi_sck, dspi_dat, io_dspi_dat, dspi_bmod,
		// Top level MEMS (SPI) I/O ports
		o_mems_cs_n, o_mems_sck, o_mems_mosi, i_mems_miso, i_mems_int,
			// SDRAM interface
			// o_ram_clk,	// SDRAM clock = clk_100mhz_s = s_clk
			o_ram_cs_n,	// Chip select
			o_ram_cke,	// Clock enable
			o_ram_ras_n,	// Row address strobe
			o_ram_cas_n,	// Column address strobe
			o_ram_we_n,	// Write enable
			o_ram_bs,	// Bank select
			o_ram_addr,	// Address lines
			w_ram_drive_data,
			r_ram_data,	// Data lines (input)
			w_ram_data,	// Data lines (output)
			{ o_ram_udqm, o_ram_ldqm });


	//
	// Our final section to the toplevel is used to provide all of
	// that special logic that couldnt fit in main.  This logic is
	// given by the @TOP.INSERT tag in our data files.
	//


	//
	//
	// Wires for setting up the QSPI flash wishbone peripheral
	//
	//
	// QSPI)BMOD, Dual SPI bus mode, Bus modes are:
	//	0?	Normal serial mode, one bit in one bit out
	//	10	Dual SPI mode, going out
	//	11	Dual SPI mode coming from the device (read mode)
	assign io_dspi_dat = (~dspi_bmod[1])?({1'bz,dspi_dat[0]})
				:((dspi_bmod[0])?(2'bzz):(dspi_dat[1:0]));
	altoddr dspi_ddr_sck(
		.outclock(s_clk),
		.din({ w_dspi_sck[1], w_dspi_sck[0] }),
		.pad_out(o_dspi_sck));


	//
	// Generate a 100MHz system clock from the incoming 12MHz clock
	//
	genpll	genclk(.inclk0(i_clk),
			.c0(s_clk), 
			.c1(mem_clk));
	//
	// This design uses local internal resets rather than a global reset
	assign	s_reset = 1'b0;

	//
	//
	// SDRAM wires
	//
	assign io_ram_data = (w_ram_drive_data) ? w_ram_data
				: 16'bzzzz_zzzz_zzzz_zzzz;

	reg	[15:0]	r_ram_data_ext_clk;
	// always @(posedge intermediate_clk_n)
	always @(posedge s_clk)
		{ r_ram_data, r_ram_data_ext_clk }
				<= { r_ram_data_ext_clk, io_ram_data };




endmodule // end of toplevel.v module definition