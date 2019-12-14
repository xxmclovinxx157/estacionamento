-- Copyright (C) 1991-2012 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- Generated by Quartus II Version 12.1 Build 243 01/31/2013 Service Pack 1 SJ Web Edition
-- Created on Fri Dec 13 15:45:46 2019

LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY fogolivre IS
    PORT (
        clock : IN STD_LOGIC;
        reset : IN STD_LOGIC := '0';
        b1 : IN STD_LOGIC := '0';
        b2 : IN STD_LOGIC := '0';
        LDRE : IN STD_LOGIC := '0';
        LDRS : IN STD_LOGIC := '0';
        cancela : OUT STD_LOGIC;
		  Leds : OUT std_logic_vector (3 downto 0):= "1111";
		  LED1: OUT STD_LOGIC;
		  LED2: OUT STD_LOGIC;
		  LED3: OUT STD_LOGIC;
		  LED4: OUT STD_LOGIC;
		  D: out std_logic_vector (6 downto 0);
		  Vagas: IN std_logic_vector (3 downto 0) 
    );
END fogolivre;

ARCHITECTURE BEHAVIOR OF fogolivre IS
    TYPE type_fstate IS (one,two,three,four,five);
    SIGNAL fstate : type_fstate;
    SIGNAL reg_fstate : type_fstate;
    SIGNAL ledes: std_logic_vector(3 downto 0);
	
BEGIN

  Ledes(0)<= not Vagas(0);
  Ledes(1)<= Vagas(1);
  Ledes(2)<= Vagas(2);
  Ledes(3)<= Vagas(3);
  
  Leds <= not ledes;

		 PROCESS (clock,reg_fstate)
		 BEGIN
			  IF (clock='1' AND clock'event) THEN
					fstate <= reg_fstate;
			  END IF;
			  
			  IF (reset='1') THEN
					reg_fstate <= one;
					cancela <= '0';
			  ELSE
					cancela <= '0';
					CASE fstate IS
						 WHEN one =>
							  IF (((b1 = '1') AND (LDRE = '1') AND (( not Vagas(0)='0') or ( vagas(1)='0') or (vagas(2)='0') or ( vagas(3)='0')))) THEN
									reg_fstate <= two;
							  -- Inserting 'else' block to prevent latch inference
							  ELSE
									reg_fstate <= one;
							  END IF;
						 WHEN two =>
							  IF ((NOT((b1 = '1')) AND NOT((LDRE = '1')))) THEN
									reg_fstate <= three;
							  -- Inserting 'else' block to prevent latch inference
							  ELSE
									reg_fstate <= two;
							  END IF;

							  cancela <= '1';
						 WHEN three =>
							  IF ((b1 = '1') AND (LDRE='1')) THEN
									reg_fstate <= one;
							  ELSIF ((((b2 = '1') AND (LDRS = '1')) AND NOT((b1 = '1')))) THEN
									reg_fstate <= four;
							  -- Inserting 'else' block to prevent latch inference
							  ELSE
									reg_fstate <= three;
							  END IF;
						 WHEN four =>
							  IF ((NOT((b2 = '1')) AND NOT(LDRS = '1'))) THEN
									reg_fstate <= five;
							  -- Inserting 'else' block to prevent latch inference
							  ELSE
									reg_fstate <= four;
							  END IF;

							  cancela <= '1';
						 WHEN five =>
							  IF ((b1 = '1') AND (LDRE='1')) THEN
									reg_fstate <= one;
							  -- Inserting 'else' block to prevent latch inference
							  ELSE
									reg_fstate <= five;
							  END IF;
						 WHEN OTHERS => 
							  cancela <= 'X';
							  report "Reach undefined state";
					END CASE;
			  END IF;
		  
		 		  	  
 END PROCESS;
	 
	 
	 
	 with ledes select  --------------------- QUANTAS VAGAS DISPONIVEIS
D <=  "0011001" when "0000",
      "0110000" when "0001",
		"0110000" when "0010",
		"0100100" when "0011",
		"0110000" when "0100",
		"0100100" when "0101",
		"0100100" when "0110",
		"1111001" when "0111",
		"0110000" when "1000",
      "0100100" when "1001",
		"0100100" when "1010",
		"1111001" when "1011",
		"0100100" when "1100",
		"1111001" when "1101",
		"1111001" when "1110",
		"1000000" when "1111";

	 
	 
END BEHAVIOR;
