----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/21/2020 10:20:07 PM
-- Design Name: 
-- Module Name: synchronizer - Behavioral
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

entity synchronizer is
    Port ( 
           Prog_Sync : out STD_LOGIC;
           Sensor_Sync : out STD_LOGIC;
           WR_Sync : out STD_LOGIC;
           Reset_Sync : out STD_LOGIC;
           Reset : in STD_LOGIC;
           Sensor : in STD_LOGIC;
           Walk_Request : in STD_LOGIC;
           Reprogram : in STD_LOGIC;
           clk : in STD_LOGIC);
end synchronizer;

architecture Behavioral of synchronizer is

begin
    process (clk) 
        begin
            if rising_edge(clk) then
                WR_Sync <= Walk_Request;
                Prog_Sync <= Reprogram;                
                Sensor_Sync <= Sensor;
                Reset_Sync <= Reset;
            end if;
        end process;

end Behavioral;
