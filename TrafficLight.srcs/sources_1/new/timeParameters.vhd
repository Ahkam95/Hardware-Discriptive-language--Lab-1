
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity timeParameters is
    Port ( 
           Interval : in STD_LOGIC_VECTOR (1 downto 0) := "00";
           Value : out STD_LOGIC_VECTOR (3 downto 0);
           clk : in STD_LOGIC;
           Reset_Sync : in STD_LOGIC;
           Prog_Sync : in STD_LOGIC;
           Selector : in STD_LOGIC_VECTOR (1 downto 0);
           Time_Value : in STD_LOGIC_VECTOR (3 downto 0));
end timeParameters;

architecture Behavioral of timeParameters is

signal t_ext: STD_LOGIC_VECTOR (3 downto 0) := "0011";
signal t_yel: STD_LOGIC_VECTOR (3 downto 0) := "0010";
signal t_base: STD_LOGIC_VECTOR (3 downto 0) := "0110";

begin

process (clk,Prog_Sync)
        begin
            if rising_edge(clk) then
                if Prog_Sync = '1' then
                    if Selector = "00" then
                        t_base <= Time_Value;
                    elsif Selector = "01" then
                        t_ext <= Time_Value;
                    elsif Selector = "10" then
                        t_yel <= Time_Value;    
                    end if;
                 elsif Reset_Sync='1' then
                     t_base <= "0110";
                     t_ext <= "0011";
                     t_yel <= "0010";
                end if;
            end if;
    end process;
        
        process ( clk, Interval )
            begin
                if rising_edge(clk) then
                    if Interval = "00" then
                        Value <= t_base;
                    elsif Interval = "01" then
                        Value <= t_ext;
                    elsif Interval = "10" then
                        Value <= t_yel;
                    end if;
                end if;
        end process;


end Behavioral;
