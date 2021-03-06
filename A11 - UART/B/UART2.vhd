----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:08:52 12/19/2019 
-- Design Name: 
-- Module Name:    UART2 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UART2 is
 Port ( 		
			reset : in STD_LOGIC;
			clock_50MHz : in STD_LOGIC;
			datain : in STD_LOGIC_VECTOR (7 downto 0);
			dataout : out STD_LOGIC_VECTOR (7 downto 0)
			);

end UART2;

architecture Behavioral of UART2 is


Component UARTcomponent is 

	Port (	
		TXD 	: out 	std_logic  	:= '1';					-- Transmitted serial data output
		RXD 	: in  	std_logic;							-- Received serial data input
		CLK 	: in  	std_logic;							-- Clock signal
		DBIN 	: in  	std_logic_vector (7 downto 0);		-- Input parallel data to be transmitted
		DBOUT 	: out 	std_logic_vector (7 downto 0);		-- Recevived parallel data output
		RDA		: inout  std_logic;							-- Read Data Available
		TBE		: out 	std_logic 	:= '1';					-- Transfer Buffer Emty
		RD		: in  	std_logic;							-- Read Strobe
		WR		: in  	std_logic;							-- Write Strobe
		PE		: out 	std_logic;							-- Parity error		
		FE		: out 	std_logic;							-- Frame error
		OE		: out 	std_logic;							-- Overwrite error
		RST		: in  	std_logic	:= '0'
		);	
end Component;

signal t_DBout, t_DBin : std_logic_vector(7 downto 0);
signal t,t_rda1,t_tbe1,t_rda2,t_tbe2,t_pe1,t_fe1,t_oe1,t_pe2,t_fe2,t_oe2,t_WR2,t_RD2,t_txd2: std_logic:= '0';


begin


Tx: UARTcomponent PORT MAP(
	TXD => t,
	RXD => '1',
	CLK => clock_50MHz,
	DBIN => datain,
	DBOUT => t_DBout,
	RDA => t_rda1,
	TBE => t_tbe1,
	RD => '1',
	WR => '1',
	PE => t_pe1,
	FE => t_fe1,
	OE => t_oe1,
	RST => reset
);

Rx: UARTcomponent PORT MAP(
	TXD => t_txd2,
	RXD => t,
	CLK => clock_50MHz,
	DBIN => t_DBin,
	DBOUT => dataout,
	RDA => t_rda2,
	TBE => t_tbe2,
	RD => '0',
	WR => '0',
	PE => t_pe2,
	FE => t_fe2,
	OE => t_oe2,
	RST => reset
);


end Behavioral;

