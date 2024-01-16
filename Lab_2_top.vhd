library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

	entity Lab_2_top is
				
				
				port ( clock,reset : in std_logic;
						 segdecod1_o,segdecod2_o,segdecod3_o : out std_logic_vector (6 downto 0)
					  );
	end Lab_2_top;

	architecture structurel of Lab_2_top is
	

	component segdecod
	
				PORT (
						entree: in std_logic_vector(3 DOWNTO 0);
						sortie: out std_logic_vector(6 DOWNTO 0)
						);	
	end component;


    component Lab_2
        port 
		  (
            clk_clk                          : in  std_logic                     := 'X'; -- clk
            pio_0_external_connection_export : out std_logic_vector(11 downto 0);        -- export
            reset_reset_n                    : in  std_logic                     := 'X'  -- reset_n
        );
    end component Lab_2;

	 --internal signals declaration
	 signal f_s : std_logic_vector(11 downto 0);
	 	 
	 begin
	 
    U0 : Lab_2
			port map 
						(
						clk_clk                          => clock,  -- clk.clk
						pio_0_external_connection_export => f_s, 	  -- pio_0_external_connection.export
						reset_reset_n                    => reset   -- reset.reset_n
						);
		  
	 U1 : segdecod
			port map (
						entree => f_s(3 downto 0),
						sortie => segdecod1_o
						);
		
	 U2 : segdecod
			port map (
						entree => f_s(7 downto 4),
						sortie => segdecod2_o
						);	
			
		
	 U3 : segdecod
			port map (
						entree => f_s(11 downto 8),
						sortie => segdecod3_o
						);	
					
	 end structurel;