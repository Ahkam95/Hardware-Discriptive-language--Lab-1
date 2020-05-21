
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity finiteStateMachine is
    Port ( 
           clk : in STD_LOGIC;
           Expired : in STD_LOGIC;
           WR_Reset : out STD_LOGIC;
           Interval : out STD_LOGIC_VECTOR (1 downto 0);
           Start_Timer : out STD_LOGIC;
           LEDs : out STD_LOGIC_VECTOR (6 downto 0);
           Sensor_Sync : in STD_LOGIC;
           WR : in STD_LOGIC;
           Prog_Sync : in STD_LOGIC;
           Reset_Sync : in STD_LOGIC);
           
end finiteStateMachine;

architecture Behavioral of finiteStateMachine is


constant t_base : STD_LOGIC_VECTOR (1 downto 0) := "00";
constant t_ext : STD_LOGIC_VECTOR (1 downto 0) := "01";
constant t_yel : STD_LOGIC_VECTOR (1 downto 0) := "10";

type state is (A,B,C,D,E);
signal led_state : state;

begin
process (clk, WR, Sensor_Sync, Prog_Sync, Reset_Sync, Expired)
        variable Extended_Time : integer := 0;
        begin
            if rising_edge(clk) then
                Start_Timer <= '0';
                if ( Prog_Sync = '1' or Reset_Sync = '1' ) then
                    led_state <= A;
                    Interval <= t_base;
                    WR_Reset <= '0';
                    Start_Timer <= '1';
                    Extended_Time := 0;
                elsif Expired = '1' then
                    case led_state is
                        when A =>
                            if ( Extended_Time = 0 and Sensor_Sync = '0' ) then
                                Interval <= t_base;
                                Extended_Time := 1;
                                Start_Timer <= '1';
                            elsif ( Extended_Time = 0 and Sensor_Sync = '1' ) then
                                Interval <= t_ext;
                                Start_Timer <= '1';
                                Extended_Time := 1;
                            else
                                led_state <= B;
                                Interval <= t_yel;
                                Start_Timer <= '1';
                                Extended_Time :=0;
                            end if;
                        when B =>
                            if wr = '1' then
                                led_state <= E;
                                Interval <= t_ext;
                                Start_Timer <= '1';
                            else
                                led_state <= C;
                                Interval <= t_base;
                                Start_Timer <= '1';
                            end if;
                        when C =>
                            WR_Reset <= '0';
                            if ( Extended_Time = 0 and Sensor_Sync = '1' ) then
                                Interval <= t_ext;
                                Start_Timer <= '1';
                                Extended_Time := 1;
                            else
                                led_state <= D;
                                Interval <= t_yel;
                                Start_Timer <= '1';
                                Extended_Time := 0;
                            end if;
                        when D =>
                            led_state <= A;
                            Interval <= t_base;
                            Start_Timer <= '1';
                            Extended_Time := 0;
                        when E =>
                            led_state <= C;
                            Interval <= t_yel;
                            Start_Timer <= '1';
                            WR_Reset <= '1';
                        when others =>
                            led_state <= A;
                            Interval <= t_base;
                            Start_Timer <= '1';
                            WR_Reset <= '0';
                            Extended_Time := 0;
                    end case;
                end if;
            end if;
        end process;
        
        process ( led_state )
            begin
                case led_state is
                    when A=>
                        LEDs <= "0011000";
                    when B=>
                        LEDs <= "0101000";
                    when C=>
                        LEDs <= "1000010";
                    when D=>
                        LEDs <= "1000100";
                    when E =>
                        LEDs <= "1001001";
                end case;
        end process;

end Behavioral;
