-- File: tb_top.vhd
-- Generated by MyHDL 0.7
-- Date: Thu Mar 21 16:44:41 2013


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

use work.pck_myhdl_07.all;

entity tb_top is
end entity tb_top;


architecture MyHDL of tb_top is

signal load: std_logic;
signal la2oe: std_logic;
signal lfsr: unsigned(9 downto 0);
signal txe: std_logic;
signal clkDacOut: std_logic;
signal adc2relatt: std_logic;
signal adc1relco: std_logic;
signal led1: std_logic;
signal led0: std_logic;
signal adc2pd: std_logic;
signal adc1relatt: std_logic;
signal la2dir: std_logic;
signal clock: std_logic;
signal scl_d: std_logic;
signal adc1data: unsigned(7 downto 0);
signal rd: std_logic;
signal sda_d: std_logic;
signal adc1pd: std_logic;
signal adbus_drv: unsigned(7 downto 0);
signal siwu: std_logic;
signal adbus: unsigned(7 downto 0);
signal adc2relco: std_logic;
signal la1dir: std_logic;
signal serialOut: std_logic;
signal wr: std_logic;
signal logicAnalyzer: unsigned(15 downto 0);
signal scl_dpull: std_logic;
signal ldac: std_logic;
signal reset: std_logic;
signal clockFtdi: std_logic;
signal oe: std_logic;
signal rxf: std_logic;
signal adc2data: unsigned(7 downto 0);
signal sda_dpull: std_logic;
signal la1oe: std_logic;
signal sda: std_logic;
signal scl: std_logic;
type t_array_data is array(0 to 9-1) of unsigned(7 downto 0);
signal data: t_array_data;

begin


adbus <= adbus_drv;
sda <= sda_d;
scl <= scl_d;
sda <= sda_dpull;
scl <= scl_dpull;

TB_TOP_STIMULUS: process is
    variable L: line;
	 variable i: integer;
begin
	 i := 0;
    reset <= '1';
    adbus_drv <= (others => 'Z');
    rxf <= '1';
    txe <= '1';
    sda_d <= 'Z';
    scl_d <= 'Z';
    sda_dpull <= 'H';
    scl_dpull <= 'H';
    wait for 32 ns;
    reset <= '0';
    wait for 196 ns;
    write(L, string'("FT245 ready"));
    writeline(output, L);
    wait until rising_edge(clockFtdi);
    rxf <= '0';
    write(L, string'("FT245 RXF low"));
    writeline(output, L);
    wait until falling_edge(oe);
    wait until falling_edge(clockFtdi);
    write(L, string'("OE came low, pushing data from FTDI"));
    writeline(output, L);
    adbus_drv <= "00010000";
    i := 0;
    data(0) <= "01100100";
    data(1) <= "01010000";
    data(2) <= "10010110";
    data(3) <= "00101000";
    data(4) <= "00000000";
    data(5) <= "00000000";
    data(6) <= "00000000";
    data(7) <= "00000000";
    data(8) <= "00000000";
    wait until falling_edge(rd);
	 wait until falling_edge(clockFtdi);
    while (rxf = '0') loop
        wait until falling_edge(clockFtdi);
        adbus_drv <= data(i);
        if (i = 8) then
            exit;
        end if;
        i := i + 1;
        wait until rising_edge(clockFtdi);
    end loop;
    wait until falling_edge(clockFtdi);
    adbus_drv <= (others => 'Z');
	 wait for 100ns;
    rxf <= '1';
	 wait for 100ns;
	 txe <= '0';
    wait for 600 ns;
    txe <= '1';
    wait for 200 ns;
    write(L, string'("FT245 ready"));
    writeline(output, L);
    rxf <= '0';
    write(L, string'("FT245 RXF low"));
    writeline(output, L);
    wait until falling_edge(oe);
    wait until falling_edge(clockFtdi);
    write(L, string'("OE came low, pushing data from FTDI"));
    writeline(output, L);
	 adbus_drv <= "00110000";
    i := 0;
    data(0) <= "00000011";
    data(1) <= "00000011";
    data(2) <= "00000000";
    data(3) <= "00000000";
    data(4) <= "00000000";
    data(5) <= "00000000";
    data(6) <= "00000000";
    data(7) <= "00000000";
    data(8) <= "00000000";
    wait until falling_edge(rd);
	 wait until falling_edge(clockFtdi);
    while (rxf = '0') loop
        wait until falling_edge(clockFtdi);
        adbus_drv <= data(i);
        if (i = 8) then
            exit;
        end if;
        i := i + 1;
        wait until rising_edge(clockFtdi);
    end loop;
    wait until falling_edge(clockFtdi);
    adbus_drv <= (others => 'Z');
    rxf <= '1';
    wait for 200 ns;
	 txe <= '0';
    wait for 200 ns;
    txe <= '1';
    write(L, string'("FT245 ready"));
    writeline(output, L);
    rxf <= '0';
    write(L, string'("FT245 RXF low"));
    writeline(output, L);
    wait until falling_edge(oe);
    wait until falling_edge(clockFtdi);
    write(L, string'("OE came low, pushing data from FTDI"));
    writeline(output, L);
    adbus_drv <= "00100000";
    i := 0;
    data(0) <= "11111111";
    data(1) <= "00000000";
    data(2) <= "00000000";
    data(3) <= "00000000";
    data(4) <= "00000000";
    data(5) <= "00000000";
    data(6) <= "00000000";
    data(7) <= "00000000";
    data(8) <= "00000000";
        wait until falling_edge(rd);
	 wait until falling_edge(clockFtdi);
    while (rxf = '0') loop
        wait until falling_edge(clockFtdi);
        adbus_drv <= data(i);
        if (i = 8) then
            exit;
        end if;
        i := i + 1;
        wait until rising_edge(clockFtdi);
    end loop;
    wait until falling_edge(clockFtdi);
    adbus_drv <= (others => 'Z');
    rxf <= '1';
    wait for 200 ns;
	 txe <= '0';
    wait for 200 ns;
    txe <= '1';
    write(L, string'("FT245 ready"));
    writeline(output, L);
    rxf <= '0';
    write(L, string'("FT245 RXF low"));
    writeline(output, L);
    wait until falling_edge(oe);
    wait until falling_edge(clockFtdi);
    write(L, string'("OE came low, pushing data from FTDI"));
    writeline(output, L);
    adbus_drv <= "00110001";
    i := 0;
    data(0) <= "01111000";
    data(1) <= "00000000";
    data(2) <= "10010001";
    data(3) <= "00000000";
    data(4) <= "00000000";
    data(5) <= "00000000";
    data(6) <= "00000000";
    data(7) <= "00000000";
    data(8) <= "00000000";
    wait until falling_edge(rd);
	 wait until falling_edge(clockFtdi);
    while (rxf = '0') loop
        wait until falling_edge(clockFtdi);
        adbus_drv <= data(i);
        if (i = 8) then
            exit;
        end if;
        i := i + 1;
        wait until rising_edge(clockFtdi);
    end loop;
    wait until falling_edge(clockFtdi);
    rxf <= '1';
    adbus_drv <= (others => 'Z');
    wait for 200 ns;
	 txe <= '0';
    wait for 200 ns;
    txe <= '1';
    write(L, string'("FT245 ready"));
    writeline(output, L);
    rxf <= '0';
    write(L, string'("FT245 RXF low"));
    writeline(output, L);
    wait until falling_edge(oe);
    wait until falling_edge(clockFtdi);
    write(L, string'("OE came low, pushing data from FTDI"));
    writeline(output, L);
    adbus_drv <= "00100001";
    i := 0;
    data(0) <= "00000000";
    data(1) <= "11111111";
    data(2) <= "00000000";
    data(3) <= "00000000";
    data(4) <= "00000000";
    data(5) <= "00000000";
    data(6) <= "00000000";
    data(7) <= "00000000";
    data(8) <= "00000000";
    wait until falling_edge(rd);
	 wait until falling_edge(clockFtdi);
    while (rxf = '0') loop
        wait until falling_edge(clockFtdi);
        adbus_drv <= data(i);
        if (i = 8) then
            exit;
        end if;
        i := i + 1;
        wait until rising_edge(clockFtdi);
    end loop;
    wait until falling_edge(clockFtdi);
    adbus_drv <= (others => 'Z');
    rxf <= '1';
    wait for 200 ns;
	 txe <= '0';
    wait for 200 ns;
    txe <= '1';
    write(L, string'("FT245 ready"));
    writeline(output, L);
    rxf <= '0';
    write(L, string'("FT245 RXF low"));
    writeline(output, L);
    wait until falling_edge(oe);
    wait until falling_edge(clockFtdi);
    write(L, string'("OE came low, pushing data from FTDI"));
    writeline(output, L);
    adbus_drv <= "01000000";
    i := 0;
    data(0) <= "00000101";
    data(1) <= "00000000";
    data(2) <= "00000000";
    data(3) <= "00000000";
    data(4) <= "00000000";
    data(5) <= "00000000";
    data(6) <= "00000000";
    data(7) <= "00000000";
    data(8) <= "00000000";
    wait until falling_edge(rd);
	 wait until falling_edge(clockFtdi);
    while (rxf = '0') loop
        wait until falling_edge(clockFtdi);
        adbus_drv <= data(i);
        if (i = 8) then
            exit;
        end if;
        i := i + 1;
        wait until rising_edge(clockFtdi);
    end loop;
    wait until falling_edge(clockFtdi);
    rxf <= '1';
    adbus_drv <= (others => 'Z');
    wait for 400 ns;
    txe <= '0';
    wait until falling_edge(clockFtdi);
    wait until rising_edge(wr);
    write(L, string'("First data captured"));
    writeline(output, L);
    write(L, string'("FT245 ready"));
    writeline(output, L);
    rxf <= '0';
    write(L, string'("FT245 RXF low"));
    writeline(output, L);
    wait until falling_edge(oe);
    wait until falling_edge(clockFtdi);
    write(L, string'("OE came low, pushing data from FTDI"));
    writeline(output, L);
    adbus_drv <= "00110010";
    i := 0;
    data(0) <= "00010001";
    data(1) <= "00100010";
    data(2) <= "00110011";
    data(3) <= "01000100";
    data(4) <= "01010101";
    data(5) <= "01100110";
    data(6) <= "01110111";
    data(7) <= "10001000";
    data(8) <= "00000000";
    wait until falling_edge(rd);
	 wait until falling_edge(clockFtdi);
    while (rxf = '0') loop
        wait until falling_edge(clockFtdi);
        adbus_drv <= data(i);
        if (i = 8) then
            exit;
        end if;
        i := i + 1;
        wait until rising_edge(clockFtdi);
    end loop;
    wait until falling_edge(clockFtdi);
	 rxf <= '1';
	 adbus_drv <= (others => 'Z');
    rxf <= '1';
    wait for 200 ns;
	 txe <= '0';
    wait for 200 ns;
    txe <= '1';
    write(L, string'("FT245 ready"));
    writeline(output, L);
    rxf <= '0';
    write(L, string'("FT245 RXF low"));
    writeline(output, L);
    wait until falling_edge(oe);
    wait until falling_edge(clockFtdi);
    write(L, string'("OE came low, pushing data from FTDI"));
    writeline(output, L);
    adbus_drv <= "00010001";
    i := 0;
    data(0) <= "01100100";
    data(1) <= "00000000";
    data(2) <= "00000000";
    data(3) <= "00000000";
    data(4) <= "00000000";
    data(5) <= "00000000";
    data(6) <= "00000000";
    data(7) <= "00000000";
    data(8) <= "00000000";
    wait until falling_edge(rd);
	 wait until falling_edge(clockFtdi);
    while (rxf = '0') loop
        wait until falling_edge(clockFtdi);
        adbus_drv <= data(i);
        if (i = 8) then
            exit;
        end if;
        i := i + 1;
        wait until rising_edge(clockFtdi);
    end loop;
    wait until falling_edge(clockFtdi);
	 adbus_drv <= (others => 'Z');
    rxf <= '1';
    wait for 200 ns;
	 txe <= '0';
    wait for 200 ns;
    txe <= '1';
    wait until falling_edge(scl);
    for i in 0 to 9-1 loop
        wait until rising_edge(scl);
    end loop;
    sda_d <= '0';
    wait until rising_edge(scl);
    sda_d <= 'Z';
    for i in 0 to 8-1 loop
        wait until rising_edge(scl);
    end loop;
    sda_d <= '0';
    wait until rising_edge(scl);
    sda_d <= 'Z';
    wait for 200 ns;
    write(L, string'("FT245 ready"));
    writeline(output, L);
    rxf <= '0';
    write(L, string'("FT245 RXF low"));
    writeline(output, L);
    wait until falling_edge(oe);
    wait until falling_edge(clockFtdi);
    write(L, string'("OE came low, pushing data from FTDI"));
    writeline(output, L);
    adbus_drv <= "01000000";
    i := 0;
    data(0) <= "00000101";
    data(1) <= "00000000";
    data(2) <= "00000000";
    data(3) <= "00000000";
    data(4) <= "00000000";
    data(5) <= "00000000";
    data(6) <= "00000000";
    data(7) <= "00000000";
    data(8) <= "00000000";
        wait until falling_edge(rd);
	 wait until falling_edge(clockFtdi);
    while (rxf = '0') loop
        wait until falling_edge(clockFtdi);
        adbus_drv <= data(i);
        if (i = 8) then
            exit;
        end if;
        i := i + 1;
        wait until rising_edge(clockFtdi);
    end loop;
    wait until falling_edge(clockFtdi);
    rxf <= '1';
    adbus_drv <= (others => 'Z');
    wait for 400 ns;
    txe <= '0';
    wait until falling_edge(clockFtdi);
    wait until falling_edge(wr);
    wait for 300 ns;
    txe <= '1';
    wait for 100 ns;
    txe <= '0';
	 wait for 330 ns;
    txe <= '1';
    wait for 120 ns;
    txe <= '0';
	 wait for 221 ns;
    txe <= '1';
    wait for 77 ns;
    txe <= '0';
	 wait for 128 ns;
    txe <= '1';
    wait for 200 ns;
    txe <= '0';
	 wait for 91 ns;
    txe <= '1';
    wait for 128 ns;
    txe <= '0';
	 wait for 223 ns;
    txe <= '1';
    wait for 100 ns;
    txe <= '0';
	 wait for 330 ns;
    txe <= '1';
    wait for 120 ns;
    txe <= '0';
	 wait for 221 ns;
    txe <= '1';
    wait for 77 ns;
    txe <= '0';
	 wait for 128 ns;
    txe <= '1';
    wait for 200 ns;
    txe <= '0';
	 wait for 91 ns;
    txe <= '1';
    wait for 128 ns;
    txe <= '0';
    wait until rising_edge(wr);
    write(L, string'("second data captured"));
    writeline(output, L);
    wait for 100 ns;
    assert False report "End of Simulation" severity Failure;
    wait;
end process TB_TOP_STIMULUS;


TB_TOP_CLKGEN: process is
begin
    clock <= to_std_logic((not to_boolean(clock)));
    wait for 3.333 ns;
end process TB_TOP_CLKGEN;


TB_TOP_CLKGEN_F: process is
begin
    clockFtdi <= to_std_logic((not to_boolean(clockFtdi)));
    wait for 8.33 ns;
end process TB_TOP_CLKGEN_F;

top: entity work.top(MyHDL)
    port map (
        reset=>reset,
        clock=>clock,
        clockFtdi=>clockFtdi,
        adc1data=>adc1data,
        adc2data=>adc2data,
        adc1pd=>adc1pd,
        adc2pd=>adc2pd,
        adc1relatt=>adc1relatt,
        adc2relatt=>adc2relatt,
        adc1relco=>adc1relco,
        adc2relco=>adc2relco,
        led0=>led0,
        led1=>led1,
        logicAnalyzer=>logicAnalyzer,
        la1dir=>la1dir,
        la2dir=>la2dir,
        la1oe=>la1oe,
        la2oe=>la2oe,
        serialOut=>serialOut,
        load=>load,
        ldac=>ldac,
        clkDacOut=>clkDacOut,
        sda=>sda,
        scl=>scl,
        rxf=>rxf,
        oe=>oe,
        txe=>txe,
        rd=>rd,
        wr=>wr,
        siwu=>siwu,
        adbus=>adbus
    );


TB_TOP_ADCGEN: process (reset, adc1pd, adc2pd, lfsr) is
begin
    if (reset = '1') then
        adc1data <= "00000000";
        adc2data <= "00000000";
    else
        if to_boolean(adc1pd) then
            adc1data <= "00000000";
        else
            adc1data <= (adc1data + 1);
        end if;
        if to_boolean(adc2pd) then
            adc2data <= "00000000";
        else
            adc2data <= (adc2data + 1);
        end if;
    end if;
end process TB_TOP_ADCGEN;

TB_TOP_LOGICANALYZERGEN: process (clock) is
begin
    if rising_edge(clock) then
        if (reset = '1') then
            logicAnalyzer <= "0000000000000000";
        else
            logicAnalyzer <= (logicAnalyzer + 1);
        end if;
    end if;
end process TB_TOP_LOGICANALYZERGEN;

TB_TOP_LFSR_PROC: process (clock, reset) is
begin
    if (reset = '1') then
        lfsr <= "0111010100";
    elsif rising_edge(clock) then
        lfsr <= unsigned'(lfsr((10 - 1)-1 downto 0) & (lfsr(9) xor lfsr(6)));
    end if;
end process TB_TOP_LFSR_PROC;

end architecture MyHDL;
