library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lab is
    Port ( clk,rst, rx : in  STD_LOGIC;
           seg: out  STD_LOGIC_VECTOR(7 downto 0);
           an : out  STD_LOGIC_VECTOR (3 downto 0));
 end lab;

architecture Behavioral of lab is
    component leddriver
    Port ( clk,rst : in  STD_LOGIC;
           seg : out  STD_LOGIC_VECTOR(7 downto 0);
           an : out  STD_LOGIC_VECTOR (3 downto 0);
            value : in  STD_LOGIC_VECTOR (15 downto 0));
    end component;
    signal sreg : STD_LOGIC_VECTOR(9 downto 0) := B"0_00000000_0";  -- 10 bit skiftregister
    signal tal : STD_LOGIC_VECTOR(15 downto 0) := X"0000";  
    signal rx1,rx2 : std_logic;         -- vippor p√• insignalen
    signal sp : std_logic;              -- skiftpuls
    signal lp : std_logic;         -- laddpuls
    signal pos : STD_LOGIC_VECTOR(1 downto 0) := "00";
 begin

 --vippan--
process(clk) begin
if rising_edge(clk) then
rx1 <= rx;
rx2 <= rx1;
end if;
end process;


---16-bit-registret-----
process(clk) begin
--if rising_edge(clk) then--
if rst=í1í then
tal <= '0000000000000000' --eller tal???--
elsif (rising_edge(clk) and lp = '1') then
if pos = "00" then
tal(0) = sreg(4);
tal(1) = sreg(3);
tal(2) = sreg(2);
tal(3) = sreg(1);

elsif pos = "01" then
an
tal(4) = sreg(4);
tal(5) = sreg(3);
tal(6) = sreg(2);
tal(7) = sreg(1);

elsif pos = "10" then
tal(8) = sreg(4);
tal(9) = sreg(3);
tal(10) = sreg(2);
tal(11) = sreg(1);

elsif pos = "11" then
tal(12) = sreg(4);
tal(13) = sreg(3);
tal(14) = sreg(2);
tal(15) = sreg(1);
else
end if;
end process;


---Styrenhet---
process(clk) begin
if rising_edge(clk) then
if rst=í1í then
<init>
elsif <villkor> then
<gˆr nÂgot>
else
<gˆr nÂgot annat>
end if;
end if;
end process;


---2-Bit-r‰knare---
process(clk) begin
if rising_edge(clk) then
if rst=í1í then
pos = "00"
if lp = '1' then

elsif pos = '00' then
pos <= "01";

elsif pos = '01' then
pos <= "10";

elsif pos = '10' then
pos <= "11";

else
pos <= "00";
end if;

else
lp <=lp;
end if;
end if;
end process;


----MALLEN----
process(clk) begin
if rising_edge(clk) then
if rst=í1í then
<init>
elsif <villkor> then
<gˆr nÂgot>
else
<gˆr nÂgot annat>
end if;
end if;
end process;
----MALLEN----



  
  -- rst √§r tryckknappen i mitten under displayen
  -- *****************************
  -- *  synkroniseringsvippor    *
  -- *****************************

  
  -- *****************************
   -- *       styrenhet           *
  -- *****************************

  
  -- *****************************
  -- * 10 bit skiftregister      *
  -- *****************************
  

  -- *****************************
   -- * 2  bit register           *
  -- *****************************

  -- *****************************
  -- * 16 bit register           *
  -- *****************************

  -- *****************************
   -- * Multiplexad display       *
  -- *****************************
  led: leddriver port map (clk, rst, seg, an, tal);
end Behavioral;














-- TestBench Template 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY lab_tb IS
END lab_tb;

ARCHITECTURE behavior OF lab_tb IS 

  -- Component Declaration
  COMPONENT lab
    PORT(
      clk,rst,rx : IN std_logic;
      seg: OUT std_logic_vector(7 downto 0);       
      an : OUT std_logic_vector(3 downto 0)
      );
  END COMPONENT;

  SIGNAL clk : std_logic := '0';
  SIGNAL rst : std_logic := '0';
  signal rx : std_logic := '1';
  SIGNAL seg : std_logic_vector(7 downto 0);
   SIGNAL an :  std_logic_vector(3 downto 0);
  SIGNAL tb_running : boolean := true;
  -- alla bitar f√∂r 1234
  SIGNAL rxs :  std_logic_vector(0 to 39) := "0100011001001001100101100110010001011001";
 BEGIN

  -- Component Instantiation
  uut: lab PORT MAP(
    clk => clk,
    rst => rst,
    rx => rx,
    seg => seg,
    an => an);


  clk_gen : process
  begin
    while tb_running loop
       clk <= '0';
      wait for 5 ns;
      clk <= '1';
      wait for 5 ns;
    end loop;
    wait;
  end process;

  

  stimuli_generator : process
    variable i : integer;
   begin
    -- Aktivera reset ett litet tag.
    rst <= '1';
    wait for 500 ns;

    wait until rising_edge(clk);        -- se till att reset sl√§pps synkront
                                        -- med klockan
     rst <= '0';
    report "Reset released" severity note;
    wait for 1 us;
    
    for i in 0 to 39 loop
      rx <= rxs(i);
      wait for 8.68 us;
    end loop;  -- i
     
    for i in 0 to 50000000 loop         -- V√§nta ett antal klockcykler
      wait until rising_edge(clk);
    end loop;  -- i
    
    tb_running <= false;                -- Stanna klockan (vilket medf√∂r att inga
                                         -- nya event genereras vilket stannar
                                        -- simuleringen).
    wait;
  end process;
      
END;


























library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
 -- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
 --use UNISIM.VComponents.all;

entity leddriver is
    Port ( clk,rst : in  STD_LOGIC;
           seg : out  STD_LOGIC_VECTOR(7 downto 0);
           an : out  STD_LOGIC_VECTOR (3 downto 0);
           value : in  STD_LOGIC_VECTOR (15 downto 0));
 end leddriver;

architecture Behavioral of leddriver is
    signal segments : STD_LOGIC_VECTOR (6 downto 0);
    signal counter_r :  unsigned(17 downto 0) := "000000000000000000";
    signal v : STD_LOGIC_VECTOR (3 downto 0);
         signal dp : std_logic;
begin
  -- decimal point not used
  dp <= '1';
  seg <= (dp & segments);
     
   with counter_r(17 downto 16) select
     v <= value(15 downto 12) when "00",
           value(11 downto 8) when "01",    
          value(7 downto 4) when "10",
          value(3 downto 0) when others;

   process(clk) begin
     if rising_edge(clk) then 
       counter_r <= counter_r + 1;
        case v is
         when "0000" => segments <= "0000001";
         when "0001" => segments <= "1001111";
         when "0010" => segments <= "0010010";
          when "0011" => segments <= "0000110";
         when "0100" => segments <= "1001100";
         when "0101" => segments <= "0100100";
          when "0110" => segments <= "0100000";
         when "0111" => segments <= "0001111";
         when "1000" => segments <= "0000000";
          when "1001" => segments <= "0000100";
         when "1010" => segments <= "0001000";
         when "1011" => segments <= "1100000";
          when "1100" => segments <= "0110001";
         when "1101" => segments <= "1000010";
         when "1110" => segments <= "0110000";
          when others => segments <= "0111000";
       end case;
      
       case counter_r(17 downto 16) is
         when "00" => an <= "0111";
         when "01" => an <= "1011";
          when "10" => an <= "1101";
         when others => an <= "1110";
       end case;
     end if;
   end process;
    
end Behavioral;
