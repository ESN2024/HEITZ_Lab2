


	architecture Lab_2_top is
	
				port ( clock,reset : in std_logic;
						 segdecod1_o,segdecod2_o,segdecod3_o : out std_logic_vector (6 downto 0)
					  );
	end Lab_2_top;


	component segdecod is
	
				PORT (
						entree: in std_logic_vector(3 DOWNTO 0);
						sortie: out std_logic_vector(6 DOWNTO 0)
						);	
	end component 


    component Lab_2 is
        port 
		  (
            clk_clk                          : in  std_logic                     := 'X'; -- clk
            pio_0_external_connection_export : out std_logic_vector(11 downto 0);        -- export
            reset_reset_n                    : in  std_logic                     := 'X'  -- reset_n
        );
    end component Lab_2;

	 
	 	 
	 begin
	 
    u0 : component Lab_2
        port map 
		  (
            clk_clk                          => CONNECTED_TO_clk_clk,                          --                       clk.clk
            pio_0_external_connection_export => CONNECTED_TO_pio_0_external_connection_export, -- pio_0_external_connection.export
            reset_reset_n                    => CONNECTED_TO_reset_reset_n                     --                     reset.reset_n
        );
		  
	 u1 : component segdecod is
	 PORT (
						entree: in std_logic_vector(3 DOWNTO 0);
						sortie: out std_logic_vector(6 DOWNTO 0)
						);	
			
		  
		  
		
	 end structurel