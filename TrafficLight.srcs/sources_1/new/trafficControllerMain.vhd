
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity trafficControllerMain is
    Port ( 
           Time_Parameter_Selector : in STD_LOGIC_VECTOR (1 downto 0);
           Time_Value : in STD_LOGIC_VECTOR (3 downto 0);
           clk : in STD_LOGIC;
           LEDs : out STD_LOGIC_VECTOR (6 downto 0);
           Reset : in STD_LOGIC;
           Sensor : in STD_LOGIC;
           Walk_Request : in STD_LOGIC;
           Reprogram : in STD_LOGIC);
end trafficControllerMain;

architecture Behavioral of trafficControllerMain is

component finiteStateMachine is
    Port ( 
           Expired : in STD_LOGIC;
           WR_Reset : out STD_LOGIC;
           Interval : out STD_LOGIC_VECTOR (1 downto 0);
           Start_Timer : out STD_LOGIC;
           LEDs : out STD_LOGIC_VECTOR (6 downto 0);
           Sensor_Sync : in STD_LOGIC;
           WR : in STD_LOGIC;
           Prog_Sync : in STD_LOGIC;
           Reset_sync : in STD_LOGIC;
           clk : in STD_LOGIC);
end component;

component synchronizer is
    Port ( Reset : in STD_LOGIC;
           Sensor : in STD_LOGIC;
           Walk_Request : in STD_LOGIC;
           Reprogram : in STD_LOGIC;
           clk : in STD_LOGIC;
           Prog_Sync : out STD_LOGIC;
           Sensor_Sync : out STD_LOGIC;
           WR_Sync : out STD_LOGIC;
           Reset_Sync : out STD_LOGIC);
end component;

component divider is
    Port ( Reset_Sync : in STD_LOGIC;
           clk : in STD_LOGIC;
           oneHz_enable : out STD_LOGIC);
end component;

component timeParameters is
    Port (
           Prog_Sync : in STD_LOGIC;
           Selector : in STD_LOGIC_VECTOR (1 downto 0);
           Time_Value : in STD_LOGIC_VECTOR (3 downto 0);
           Interval : in STD_LOGIC_VECTOR (1 downto 0) := "00";
           Value : out STD_LOGIC_VECTOR (3 downto 0);
           clk : in STD_LOGIC);
end component;

component timer is
    Port ( value : in STD_LOGIC_VECTOR (3 downto 0);
           Start_Timer : in STD_LOGIC;
           oneHz_enable : in STD_LOGIC;
           clk : in STD_LOGIC;
           Reset_sync : in STD_LOGIC;
           Expired : out STD_LOGIC);
end component;

component walkRegister is
    Port ( WR_Sync : in STD_LOGIC;
           WR_Reset : in STD_LOGIC;
           WR : out STD_LOGIC);
end component;

signal Expired : STD_LOGIC;
signal Interval : STD_LOGIC_VECTOR ( 1 downto 0 );
signal value : STD_LOGIC_VECTOR ( 3 downto 0 );
signal WR_Reset : STD_LOGIC;
signal WR : STD_LOGIC;
signal oneHz_enable : STD_LOGIC;
signal Reset_sync : STD_LOGIC;
signal Sensor_Sync : STD_LOGIC;
signal WR_sync : STD_LOGIC;
signal Prog_Sync : STD_LOGIC;
signal Start_Timer : STD_LOGIC;

begin

finiteStateMachine_1 : finiteStateMachine 
    port map ( Sensor_Sync => Sensor_Sync,
               WR => WR,
               Prog_Sync => Prog_Sync,
               Reset_sync => Reset_sync,
               clk => clk,
               Expired => Expired,
               WR_Reset => WR_Reset,
               Interval => Interval,
               Start_Timer => Start_Timer,
               LEDs => LEDs );

synchronizer_1 : synchronizer
    port map (Reset => Reset,
              Sensor => Sensor,
              Walk_Request => Walk_Request,
              Reprogram => Reprogram,
              clk =>clk,
              Reset_sync => Reset_sync,
              Sensor_Sync => Sensor_Sync,
              WR_sync => WR_sync,
              Prog_Sync => Prog_Sync);
              
divider_1 : divider
    port map ( Reset_sync => Reset_sync,
               clk => clk,
               oneHZ_enable => oneHz_enable);

timeParameter_1 : timeParameters
    port map ( 
               Prog_Sync => Prog_Sync,
               Selector => Time_Parameter_Selector,
               Time_Value => Time_Value,
               Interval => Interval,
               value => value,
               clk => clk);

timer_1 : timer
    port map ( value => value,
               Start_Timer => Start_Timer,
               oneHz_enable => oneHz_enable,
               clk => clk,
               Reset_sync => Reset_sync,
               Expired => Expired );

walkRegister_1 : walkRegister
    port map (WR_Sync => WR_Sync,
              WR_Reset => WR_Reset,
              WR => WR);

end Behavioral;
