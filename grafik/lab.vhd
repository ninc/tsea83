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
    	Port ( clk,rst : in  STD_LOGIC;
           	vgaRed, vgaGreen : out  STD_LOGIC_VECTOR (2 downto 0);
           	vgaBlue : out  STD_LOGIC_VECTOR (2 downto 1);
           	ca,cb,cc,cd,ce,cf,cg,dp, Hsync,Vsync : out  STD_LOGIC;
           	an : out  STD_LOGIC_VECTOR (3 downto 0));
end lab;

architecture Behavioral of lab is

component leddriver
    	Port ( clk,rst : in  STD_LOGIC;
           	ca,cb,cc,cd,ce,cf,cg,dp : out  STD_LOGIC;
           	an : out  STD_LOGIC_VECTOR (3 downto 0);
           	ledvalue : in  STD_LOGIC_VECTOR (15 downto 0));
end component;

  --Jacob
signal color : std_logic_vector(7 downto 0) := "00000000";
signal color_next : std_logic_vector(7 downto 0) := "00000000";

subtype color_t is std_logic_vector(7 downto 0);
type tile_array is array (integer range 0 to 255) of color_t;
signal y_tile, x_tile : std_logic_vector(15 downto 0) := "0000000000000000";
signal aktuell_tile_pos : integer range 0 to 255;
signal tile_minne : tile_array :=
("11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000",
"11100000");

--Given kod
signal xctr,yctr : std_logic_vector(9 downto 0) := "0000000000";
alias rad : std_logic_vector(6 downto 0) is yctr(9 downto 3); -- i bildminnet
alias kol : std_logic_vector(6 downto 0) is xctr(9 downto 3);  -- i bildminnet
alias ypix : std_logic_vector(2 downto 0) is yctr(2 downto 0); -- i pixeln
alias xpix : std_logic_vector(2 downto 0) is xctr(2 downto 0);  -- i pixeln
signal pixel : std_logic_vector(1 downto 0) := "00";
signal a,b,c,d : std_logic_vector(0 to 79) := X"00000000000000000000";
signal a0,a1,a2,b0,b1,b2,c0,c1,c2 : std_logic := '0';
signal nr : std_logic_vector(3 downto 0) := "0000";
signal ctr : std_logic_vector(15 downto 0) := X"0000"; -- ?
signal hs : std_logic := '1';
signal vs : std_logic := '1';

begin 

--Pixel räknare == 25MHz klocka till VGA
process(clk) begin
	if rising_edge(clk) then
		if rst='1' then
			pixel <= "00";
		else
			pixel <= pixel + 1;
			--color_next<= color_next + 1;
       		end if;
     	end if;
end process;


--Tileminnet - Test
process(clk) begin 
	if rising_edge(clk) then
		if yctr<480 and xctr<640 and pixel=0 then
			--Lägg in nästa pixel från aktuell rad
			color_next <= tile_minne(aktuell_tile_pos);
		elsif yctr<480 and xctr<640 and pixel=3 then
			if aktuell_tile_pos=255 then
				aktuell_tile_pos <= 0;
			else				
				aktuell_tile_pos <= aktuell_tile_pos + 1;
			end if;
		elsif yctr=480 and pixel=3 then
			aktuell_tile_pos <= 0;
		end if;
	end if;
end process;

  
--Hsync
process(clk) begin
	if rising_edge(clk) then
      		if rst='1' then
         		xctr <= "0000000000";
      		elsif pixel=3 then
       			if xctr=799 then
         			xctr <= "0000000000";
       			else
         			xctr <= xctr + 1;
       			end if;
      		end if;
      		-- 
      		if xctr=670 then
        		hs <= '0';
      		elsif xctr=766 then
        		hs <= '1';
      		end if;
    	end if;
end process;

-- Vsync
process(clk) begin
	if rising_edge(clk) then
      		if rst='1' then
        		yctr <= "0000000000";
      		elsif xctr=799 and pixel=0 then
       			if yctr=520 then
         			yctr <= "0000000000";
       			else
         			yctr <= yctr + 1;
       			end if;
       			--
       			if yctr=490 then
         			vs <= '0';
       			elsif  yctr=491 then
         			vs <= '1';
       			end if;
      		end if;
    	end if;
end process;

-- Sätt Hsync, Vsync
Hsync <= hs;
Vsync <= vs;
  
-- VGA
process(clk) begin
    	if rising_edge(clk) then
      		if yctr<480 then
        		if xctr<640 then
          			if pixel=3 then
            				color <= color_next;
          			end if;
        		end if;
      		end if;
    	end if;
end process;

-- Sätt den nya färgen  
vgaRed(2 downto 0) <= color(7 downto 5);
vgaGreen(2 downto 0) <= color(4 downto 2);
vgaBlue(2 downto 1) <= color(1 downto 0);
  
  -- ************************************
  
process(clk) begin
     	if rising_edge(clk) then
       		if rst='1' then
         		ctr <= X"0000";
       		elsif yctr=0 and xctr=0 and pixel=0 then
         		ctr <= ctr+1;
       		end if;
     	end if;
end process;
       
  led: leddriver port map (clk,rst,ca,cb,cc,cd,ce,cf,cg,dp,an, ctr);
end Behavioral;

