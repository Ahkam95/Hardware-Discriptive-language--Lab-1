----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/21/2020 10:24:09 PM
-- Design Name: 
-- Module Name: walkRegister - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity walkRegister is
    Port ( WR_Sync : in STD_LOGIC;
           WR_Reset : in STD_LOGIC;
           WR : out STD_LOGIC);
end walkRegister;

architecture Behavioral of walkRegister is

begin
    process (WR_Sync, WR_Reset)
        begin
            if( WR_Reset = '1' ) then
                WR <= '0';
            elsif (WR_Sync 'event and WR_Sync = '1') then
                WR <= '1';
            end if;
   end process;

end Behavioral;
