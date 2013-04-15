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
    signal clk_cnt : STD_LOGIC_VECTOR(9 downto 0) := B"0_00000000_0"; -- 10 bit counter
    signal bit_cnt : STD_LOGIC_VECTOR(3 downto 0) := B"0000"; -- 4 bit counter
    signal sreg : STD_LOGIC_VECTOR(9 downto 0) := B"0_00000000_0";  -- 10 bit skiftregister
    signal tal : STD_LOGIC_VECTOR(15 downto 0) := X"0000";  
    signal rx1,rx2 : std_logic := '1';         -- vippor på insignalen
    signal sp : std_logic := '0';             -- skiftpuls
    signal lp : std_logic := '0';        -- laddpuls
    signal pos : STD_LOGIC_VECTOR(1 downto 0) := "00";
    signal in_idle : std_logic := '1';
begin
  -- rst är tryckknappen i mitten under displayen
  -- *****************************
  -- *  synkroniseringsvippor    *
  -- *****************************
process(clk) begin
	if rising_edge(clk) then
		if rst='1' then
			rx1 <= '1';	-- Blir detta bra?
			rx2 <= '1';	
		else
			rx1 <= rx;	-- Tanker jag ratt?
			rx2 <= rx1;
		end if;
	end if;
end process;
  
  -- *****************************
  -- *       styrenhet           *
  -- *****************************
-- 10 bit counter + sp
process(clk)
--	variable new_ascii: std_logic;
	begin
	if rising_edge(clk) then
		if rst='1' or lp='1' then
			clk_cnt <= B"0_00000000_0";
			in_idle <= '1';
			sp <= '0';
		elsif rx2='0' and in_idle='1' then
			in_idle <= '0';
			
		elsif in_idle = '0' then
			if clk_cnt=868 then
				clk_cnt <= "0000000000";
			elsif clk_cnt=434 then
				sp <= '1';
				clk_cnt <= clk_cnt + 1;
			else
				sp <= '0';
				clk_cnt <= clk_cnt + 1;
			end if;	
		else
			sp <= '0';	
	
		end if;	
	end if;
end process;
-- 4 bit counter
process(clk) begin
	if rising_edge(clk) then
		if rst='1' then
			bit_cnt <= "0000";
			lp <= '0';
		elsif sp='1' then
			if bit_cnt="1001" then-- Om 10 bitar passerat
				lp <= '1';
				bit_cnt <= "0000";
			else
				bit_cnt <= bit_cnt + 1;
			end if;	
		else
			lp <= '0';		
		end if;
					
	end if;
end process;
  -- *****************************
  -- * 10 bit skiftregister      *
  -- *****************************
process(clk) begin
	if rising_edge(clk) then
		if rst='1' then
			sreg <= B"0_00000000_0";
		elsif sp='1' then
			sreg <= rx2 & sreg(9 downto 1);
	--		for i in 0 to 8 loop
          --   			sreg(i) <= sreg(i+1);
         --		end loop;
	--		sreg(9) <= rx2;
		end if;
	end if;
end process;

  -- *****************************
  -- * 2  bit register           *
  -- *****************************
process(clk) begin
	if rising_edge(clk) then
		if rst='1' then
			pos <= "00";
		elsif lp='1' then
			pos <= pos + 1;
		else
			pos <= pos;
		end if;
	end if;
end process;


  -- *****************************
  -- * 16 bit register           *
  -- *****************************
process(clk) begin
if rising_edge(clk) then
	if rst='1' then
		tal <= "0000000000000000"; --eller tal???--
	elsif lp = '1' then
		if pos = "00" then
			tal(15 downto 12) <= sreg(4 downto 1);
		elsif pos = "01" then
			tal(11 downto 8) <= sreg(4 downto 1);
		elsif pos = "10" then
			tal(7 downto 4) <= sreg(4 downto 1);
		elsif pos = "11" then
			tal(3 downto 0) <= sreg(4 downto 1);
		else
		end if;
	end if;
end if;
end process;

  -- *****************************
  -- * Multiplexad display       *
  -- *****************************
  led: leddriver port map (clk, rst, seg, an, tal);
end Behavioral;

