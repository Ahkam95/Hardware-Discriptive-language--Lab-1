
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity timer is
    Port ( 
           Reset_Sync : in STD_LOGIC;
           Expired : out STD_LOGIC := '0';
           Value : in STD_LOGIC_VECTOR (3 downto 0);
           Start_Timer : in STD_LOGIC;
           oneHz_enable : in STD_LOGIC;
           clk : in STD_LOGIC
           );
end timer;

architecture Behavioral of timer is

begin
process ( clk, Start_Timer, oneHz_enable, Reset_Sync, Value )
        variable Time_Left : integer := 0;
        variable Timer_Started : STD_LOGIC := '0';
        variable delayForTwo : integer :=0;
        variable Expire_Active : STD_LOGIC := '0';
        begin
            if ( clk 'event and clk = '1') then
                if (Expire_Active = '1') then
                    Expired <= '0';
                    Expire_Active := '0';
                end if;
                if (( Start_Timer = '1' ) and delayForTwo = 0 ) then
                    delayForTwo := delayForTwo + 1;
                    Expired <= '0';
                elsif ( delayForTwo = 1) then
                    delayForTwo := delayForTwo + 1;                    
                elsif ( delayForTwo = 2 ) then
                    Time_Left := to_integer(unsigned(Value));
                    delayForTwo := 0;
                 end if;
            end if;
            if ( oneHz_enable 'event and oneHz_enable = '1') then
                if Time_Left /= 0 then
                    Time_Left := Time_Left - 1;
                end if;
                if Time_Left = 0 then
                    Expired <= '1';
                    Expire_Active := '1';
                end if;
            end if;
        end process;

end Behavioral;
