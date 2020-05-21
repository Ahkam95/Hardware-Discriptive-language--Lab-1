

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity divider is
    Port ( Reset_Sync : in STD_LOGIC;
           clk : in STD_LOGIC;
           oneHz_enable : out STD_LOGIC);
end divider;

architecture Behavioral of divider is

begin
    process ( clk, Reset_Sync )
            constant Main_Clock : integer := 10;--this value shoud be 10**8 for testing perpose i change it to low value
            variable Remain_Clock : integer := Main_Clock;
            begin
                if rising_edge(clk) then
                    Remain_Clock := Remain_Clock - 1;
                    if Reset_Sync = '1' then
                        Remain_Clock := Main_Clock;
                    end if;
                    if Remain_Clock = 0 then
                        oneHz_enable <= '1';
                        Remain_Clock := Main_Clock;
                    else
                        oneHz_enable <= '0';
                    end if;
                end if;
            end process;

end Behavioral;
