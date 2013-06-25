-- File: digipot_controller.vhd
-- Generated by MyHDL 0.7
-- Date: Thu May  9 18:39:47 2013



package pck_digipot_controller is

    type t_enum_tPotStates_1 is (
    INIT,
    IDLE,
    WRITE1,
    WRITE2,
    WRITE3,
    WRITE4
);

end package pck_digipot_controller;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

use work.pck_myhdl_07.all;

use work.pck_digipot_controller.all;

entity digipot_controller is
    port (
        clk: in std_logic;
        reset: in std_logic;
        value: in unsigned(6 downto 0);
        strobe: in std_logic;
        busy: out std_logic;
        sda: inout std_logic;
        scl: inout std_logic
    );
end entity digipot_controller;
-- ckl - clock input
-- reset - asynchornous reset
-- value - input of desired pot value
-- strobe - strobe of value
-- busy - busy indicator
-- sda - i2c sda wire
-- scl - i2c scl wire

architecture MyHDL of digipot_controller is

signal counter: unsigned(8 downto 0);
signal sclIdleValue: std_logic;
signal secondByte: std_logic;
signal txCounter: unsigned(3 downto 0);
signal generateStart: std_logic;
signal oneHundredKhzClock: std_logic;
signal scl_d: std_logic;
signal repeatTransfer: std_logic;
signal state: t_enum_tPotStates_1;
signal sda_d: std_logic;
signal sda_i: std_logic;
signal dataWord: unsigned(7 downto 0);
signal generateStop: std_logic;
signal sda_neg: std_logic;
signal delayedClock: std_logic;
signal clkEn: std_logic;
signal valueInt: unsigned(6 downto 0);
signal delayedClock_int: std_logic;

begin

scl <= scl_d;
sda <= sda_d;

-- This process drives scl with delayedClock_int negation or sclIdleValue according to clkEn
-- high signal state is translated to High-Z
DIGIPOT_CONTROLLER_CONNECTCLOCK: process (delayedClock, reset) is
begin
    if (reset = '1') then
        delayedClock_int <= '1';
    elsif rising_edge(delayedClock) then
        delayedClock_int <= to_std_logic((not to_boolean(delayedClock_int)));
        if to_boolean(clkEn) then
            if to_boolean(delayedClock_int) then
                scl_d <= '0';
            else
                scl_d <= 'Z';
            end if;
        else
            if to_boolean(sclIdleValue) then
                scl_d <= 'Z';
            else
                scl_d <= '0';
            end if;
        end if;
    end if;
end process DIGIPOT_CONTROLLER_CONNECTCLOCK;

-- This process divides clock to 100kHz used by I2C, it also generted half cycle delayed clock (delayedClock) on 200kHz
-- which is then divided to correct 100kHz frequency in connectClock process
DIGIPOT_CONTROLLER_CLOCKDIVISOR: process (clk, reset) is
begin
    if (reset = '1') then
        counter <= "000000000";
        oneHundredKhzClock <= '0';
        delayedClock <= '0';
    elsif rising_edge(clk) then
        if ((signed(resize(counter, 10)) = ((640 / 4) - 1)) or (signed(resize(counter, 10)) = ((640 / 2) - 1)) or (signed(resize(counter, 10)) = (((640 / 2) + (640 / 4)) - 1))) then
            delayedClock <= to_std_logic((not to_boolean(delayedClock)));
        end if;
        if (signed(resize(counter, 10)) = ((640 / 2) - 1)) then
            counter <= "000000000";
            oneHundredKhzClock <= to_std_logic((not to_boolean(oneHundredKhzClock)));
        else
            counter <= (counter + 1);
        end if;
    end if;
end process DIGIPOT_CONTROLLER_CLOCKDIVISOR;

-- This is process of FSM. In INIT state it generates reset sequence for digital pot
-- in IDLE state it waits for data strobe, then it transmits data on I2C bus to digital pot.
-- In WRITE1 it generates start condition, then in WRITE2 it first transmits
-- address of digipot device and then in WRITE3 waits for acknowledge and generate stop condition, 
-- in WRITE4 it transmits actual pot setting data then goes back to WRITE3 waiting for ack and generate stop
-- and then goes back to IDLE state.
DIGIPOT_CONTROLLER_FSM: process (oneHundredKhzClock, reset) is
begin
    if (reset = '1') then
        secondByte <= '0';
        clkEn <= '0';
        busy <= '1';
        state <= INIT;
        sda_i <= '1';
        sclIdleValue <= '1';
        txCounter <= "0000";
        valueInt <= "0000000";
        dataWord <= "00000000";
        generateStart <= '0';
        generateStop <= '0';
        repeatTransfer <= '0';
    elsif rising_edge(oneHundredKhzClock) then
        case state is
            when INIT =>
                if (txCounter = 0) then
                    clkEn <= '1';
                    txCounter <= (txCounter + 1);
                    generateStart <= '1';
                elsif (txCounter < 10) then
                    generateStart <= '0';
                    txCounter <= (txCounter + 1);
                    sda_i <= '1';
                elsif (txCounter = 10) then
                    txCounter <= (txCounter + 1);
                    clkEn <= '0';
                    sclIdleValue <= '1';
                elsif (txCounter = 11) then
                    txCounter <= (txCounter + 1);
                    sda_i <= '0';
                    sclIdleValue <= '0';
                elsif (txCounter = 12) then
                    sclIdleValue <= '1';
                    state <= IDLE;
                    txCounter <= "0000";
                end if;
            when IDLE =>
                generateStart <= '0';
                generateStop <= '0';
                sda_i <= '1';
                sclIdleValue <= '1';
                clkEn <= '0';
                txCounter <= "0000";
                if (strobe = '1') then
                    state <= WRITE1;
                    busy <= '1';
                    valueInt <= value;
                else
                    if to_boolean(repeatTransfer) then
                        repeatTransfer <= '0';
                        state <= WRITE1;
                        busy <= '1';
                    else
                        state <= IDLE;
                        busy <= '0';
                    end if;
                end if;
            when WRITE1 =>
                dataWord(8-1 downto 1) <= "0101111";
                dataWord(0) <= '0';
                clkEn <= '1';
                generateStart <= '1';
                state <= WRITE2;
            when WRITE2 =>
                generateStart <= '0';
                if (txCounter < 8) then
                    sda_i <= dataWord(7);
                    txCounter <= (txCounter + 1);
                    dataWord <= (shift_left(dataWord, 1) mod 256);
                    state <= WRITE2;
                else
                    secondByte <= '0';
                    state <= WRITE3;
                    sda_i <= '1';
                end if;
            when others =>
                if (state = WRITE3) then
                    if to_boolean(secondByte) then
                        state <= IDLE;
                        sclIdleValue <= '1';
                        generateStop <= '1';
                        clkEn <= '0';
                    else
                        state <= WRITE4;
                        sda_i <= '0';
                        dataWord(8-1 downto 1) <= valueInt;
                        dataWord(0) <= '0';
                        txCounter <= "0000";
                    end if;
                else
                    if (state = WRITE4) then
                        if (txCounter < 7) then
                            sda_i <= dataWord(7);
                            txCounter <= (txCounter + 1);
                            dataWord <= (shift_left(dataWord, 1) mod 256);
                            state <= WRITE4;
                        else
                            secondByte <= '1';
                            state <= WRITE3;
                            sda_i <= '1';
                        end if;
                    else
                        clkEn <= '0';
                        busy <= '1';
                        state <= INIT;
                        sda_i <= '1';
                        sclIdleValue <= '1';
                        txCounter <= "0000";
                    end if;
                end if;
        end case;
    end if;
end process DIGIPOT_CONTROLLER_FSM;

-- This process outputs SDA to High-Z or
-- LOW according to sda_neg
DIGIPOT_CONTROLLER_SDA_CON: process (sda_neg) is
begin
    if (not to_boolean(sda_neg)) then
        sda_d <= '0';
    else
        sda_d <= 'Z';
    end if;
end process DIGIPOT_CONTROLLER_SDA_CON;

-- This process selects if output of SDA should be 
-- in Hi-Z (sda_neg HIGH) or LOW(sda_neg LOW)
DIGIPOT_CONTROLLER_SDA_NEGA: process (generateStop, generateStart, sda_i, oneHundredKhzClock) is
begin
    if to_boolean(generateStart) then
        sda_neg <= oneHundredKhzClock;
    elsif to_boolean(generateStop) then
        sda_neg <= to_std_logic((not to_boolean(oneHundredKhzClock)));
    else
        sda_neg <= sda_i;
    end if;
end process DIGIPOT_CONTROLLER_SDA_NEGA;

end architecture MyHDL;