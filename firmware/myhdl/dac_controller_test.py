#
#   This file is part of QWave firmware. 
#   Copyright (c) 2012-2013, Bruno Kremel
#   All rights reserved.
#
#    Redistribution and use in source and binary forms, with or without
#    modification, are permitted provided that the following conditions are met:
#    1. Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#    2. Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#    3. All advertising materials mentioning features or use of this software
#       must display the following acknowledgement:
#       This product includes software developed by Bruno Kremel.
#    4. Neither the name of Bruno Kremel nor the
#       names of its contributors may be used to endorse or promote products
#       derived from this software without specific prior written permission.
#
#    THIS SOFTWARE IS PROVIDED BY Bruno Kremel ''AS IS'' AND ANY
#    EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
#    WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#    DISCLAIMED. IN NO EVENT SHALL Bruno Kremel BE LIABLE FOR ANY
#    DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
#    (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
#    LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
#    ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
#    (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#    SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

from myhdl import *

from dac_controller import dac_controller

PERIOD = 6

def bench():
    """ Unit test for dac_controller. """
    
    clock = Signal(bool(False))
    reset = Signal(bool(False))
    strobe = Signal(bool(False))
    serialOut = Signal(bool(False))
    load = Signal(bool(False))
    ldac = Signal(bool(False))
    clkDacOut = Signal(bool(False))
    busy = Signal(bool(False))
    vrefTopA = Signal(intbv(0)[8:])
    vrefTopB = Signal(intbv(0)[8:])
    vrefBotA = Signal(intbv(0)[8:])
    vrefBotB = Signal(intbv(0)[8:])
    

    dut_dac_controller = dac_controller(clock, reset, vrefTopA, vrefTopB, vrefBotA, vrefBotB, strobe, 
                       serialOut, load, ldac, clkDacOut, busy)
    
    @always(delay(PERIOD//2))
    def clkgen():
        clock.next = not clock

    @instance
    def stimulus():
        reset.next = True
        strobe.next = False
        vrefTopA.next = 0
        vrefTopB.next = 0
        vrefBotA.next = 0
        vrefBotB.next = 0
        yield delay(100)
        reset.next = False
        yield busy.negedge
        vrefTopA.next = 100
        vrefTopB.next = 120
        vrefBotA.next = 50
        vrefBotB.next = 20
        strobe.next = True
        yield busy.posedge
        strobe.next = False
        yield busy.negedge
        vrefTopA.next = 100
        vrefTopB.next = 120
        vrefBotA.next = 130
        vrefBotB.next = 20
        strobe.next = True
        yield busy.posedge
        strobe.next = False
        yield busy.negedge
        vrefTopA.next = 100
        vrefTopB.next = 120
        vrefBotA.next = 50
        vrefBotB.next = 220
        strobe.next = True
        yield busy.posedge
        strobe.next = False
        yield busy.negedge
        vrefTopA.next = 100
        vrefTopB.next = 120
        vrefBotA.next = 150
        vrefBotB.next = 220
        strobe.next = True
        yield busy.posedge
        strobe.next = False
        yield busy.negedge
        vrefTopA.next = 220
        vrefTopB.next = 148
        vrefBotA.next = 60
        vrefBotB.next = 37
        strobe.next = True
        yield busy.posedge
        strobe.next = False
        yield busy.negedge
        yield delay(1000)    
        raise StopSimulation

    return dut_dac_controller, clkgen, stimulus
    
tb_cntrl = traceSignals(bench)
simulation = Simulation(tb_cntrl)
simulation.run()

toVHDL(bench)