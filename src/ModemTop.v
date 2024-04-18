// Generator : SpinalHDL dev    git head : efcba5fcd17d0cfe48fa0981e8dec6e70234b294
// Component : ModemTop

`ifdef TIMESCALE
`timescale 1ns/1ps
`endif

module ModemTop (
  input               ena /* verilator public */ ,
  output reg [7:0]    uo_out /* verilator public */ ,
  input      [7:0]    ui_in /* verilator public */ ,
  output reg [7:0]    uio_out /* verilator public */ ,
  input      [7:0]    uio_in /* verilator public */ ,
  output     [7:0]    uio_oe /* verilator public */ ,
  input               simulation_z /* verilator public */ ,
  input      [15:0]   latched /* verilator public */ ,
  input               rst_n,
  input               clk
);

  wire                layer_io_resetCondx;
  wire                control_io_txClockStb;
  wire       [5:0]    control_io_addr6;
  wire                control_io_upDownOut;
  wire                control_io_rxClock;
  wire       [7:0]    control_io_txDac8;
  wire       [7:0]    control_io_rxDac8;
  wire                control_io_uartTxClock;
  wire                control_io_uartRxClock;
  wire                uart_io_uartTxOut;
  wire                uart_io_uartCtsOut;
  wire                layer_io_txerror;
  wire                layer_io_rxerror;
  wire                layer_io_sending;
  wire       [7:0]    _zz_cfgTxBertMode;
  wire       [3:0]    _zz_dcdPopcount_9;
  reg        [3:0]    _zz_dcdPopcount_10;
  wire       [2:0]    _zz_dcdPopcount_11;
  reg        [3:0]    _zz_dcdPopcount_12;
  wire       [2:0]    _zz_dcdPopcount_13;
  reg        [3:0]    _zz_dcdPopcount_14;
  wire       [2:0]    _zz_dcdPopcount_15;
  wire       [1:0]    _zz_dcdPopcount_16;
  wire                cfgUartRxPrescale;
  wire                cfgUartTxPrescale;
  wire                cfgRxData;
  wire                cfgTxData;
  wire                cfgRxClockDirection;
  wire                cfgUpDownSource;
  wire                cfgAddrDirection;
  wire                cfgTableLatency;
  wire                cfgRxClockSource;
  wire       [1:0]    cfgTxBertMode;
  reg        [7:0]    oe;
  wire                rxDataIn;
  wire                rxClockIn;
  wire                uartRtsIn;
  wire       [3:0]    rom4;
  wire                uartRxIn;
  wire                upDownIn;
  wire       [5:0]    addr6In;
  wire                sim;
  wire                dcdHistory_0;
  reg                 dcdHistory_1;
  reg                 dcdHistory_2;
  reg                 dcdHistory_3;
  reg                 dcdHistory_4;
  reg                 dcdHistory_5;
  reg                 dcdHistory_6;
  reg                 dcdHistory_7;
  wire       [7:0]    _zz_dcdPopcount;
  wire       [3:0]    _zz_dcdPopcount_1;
  wire       [3:0]    _zz_dcdPopcount_2;
  wire       [3:0]    _zz_dcdPopcount_3;
  wire       [3:0]    _zz_dcdPopcount_4;
  wire       [3:0]    _zz_dcdPopcount_5;
  wire       [3:0]    _zz_dcdPopcount_6;
  wire       [3:0]    _zz_dcdPopcount_7;
  wire       [3:0]    _zz_dcdPopcount_8;
  wire       [3:0]    dcdPopcount;
  wire                fakeDcd;
  reg                 uartRtsIn_regNext;

  assign _zz_cfgTxBertMode = latched[15 : 8];
  assign _zz_dcdPopcount_9 = (_zz_dcdPopcount_10 + _zz_dcdPopcount_12);
  assign _zz_dcdPopcount_16 = {_zz_dcdPopcount[7],_zz_dcdPopcount[6]};
  assign _zz_dcdPopcount_15 = {1'd0, _zz_dcdPopcount_16};
  assign _zz_dcdPopcount_11 = {_zz_dcdPopcount[2],{_zz_dcdPopcount[1],_zz_dcdPopcount[0]}};
  assign _zz_dcdPopcount_13 = {_zz_dcdPopcount[5],{_zz_dcdPopcount[4],_zz_dcdPopcount[3]}};
  ModemControl control (
    .io_sim               (sim                   ), //i
    .io_cfgUartTxPrescale (cfgUartTxPrescale     ), //i
    .io_cfgUartRxPrescale (cfgUartRxPrescale     ), //i
    .io_cfgTableLatency   (cfgTableLatency       ), //i
    .io_cfgUpDownSource   (cfgUpDownSource       ), //i
    .io_rom4              (rom4[3:0]             ), //i
    .io_upDownIn          (upDownIn              ), //i
    .io_rxClockIn         (rxClockIn             ), //i
    .io_txDataIn          (uart_io_uartTxOut     ), //i
    .io_rxDataRawIn       (rxDataIn              ), //i
    .io_txClockStb        (control_io_txClockStb ), //o
    .io_addr6             (control_io_addr6[5:0] ), //o
    .io_upDownOut         (control_io_upDownOut  ), //o
    .io_rxClock           (control_io_rxClock    ), //o
    .io_txDac8            (control_io_txDac8[7:0]), //o
    .io_rxDac8            (control_io_rxDac8[7:0]), //o
    .io_uartTxClock       (control_io_uartTxClock), //o
    .io_uartRxClock       (control_io_uartRxClock), //o
    .rst_n                (rst_n                 ), //i
    .clk                  (clk                   )  //i
  );
  UartControl uart (
    .io_uartRxIn   (uartRxIn              ), //i
    .io_uartRtsIn  (uartRtsIn             ), //i
    .io_txClockStb (control_io_uartTxClock), //i
    .io_rxClockStb (control_io_uartRxClock), //i
    .io_uartTxOut  (uart_io_uartTxOut     ), //o
    .io_uartCtsOut (uart_io_uartCtsOut    ), //o
    .clk           (clk                   ), //i
    .rst_n         (rst_n                 )  //i
  );
  LayerControl layer (
    .io_resetCondx     (layer_io_resetCondx), //i
    .io_hdlcTxActive   (1'b0               ), //i
    .io_hdlcFrameError (1'b0               ), //i
    .io_hdlcCrcError   (1'b0               ), //i
    .io_hdlcUnderrun   (1'b0               ), //i
    .io_txerror        (layer_io_txerror   ), //o
    .io_rxerror        (layer_io_rxerror   ), //o
    .io_sending        (layer_io_sending   ), //o
    .clk               (clk                ), //i
    .rst_n             (rst_n              )  //i
  );
  always @(*) begin
    case(_zz_dcdPopcount_11)
      3'b000 : _zz_dcdPopcount_10 = _zz_dcdPopcount_1;
      3'b001 : _zz_dcdPopcount_10 = _zz_dcdPopcount_2;
      3'b010 : _zz_dcdPopcount_10 = _zz_dcdPopcount_3;
      3'b011 : _zz_dcdPopcount_10 = _zz_dcdPopcount_4;
      3'b100 : _zz_dcdPopcount_10 = _zz_dcdPopcount_5;
      3'b101 : _zz_dcdPopcount_10 = _zz_dcdPopcount_6;
      3'b110 : _zz_dcdPopcount_10 = _zz_dcdPopcount_7;
      default : _zz_dcdPopcount_10 = _zz_dcdPopcount_8;
    endcase
  end

  always @(*) begin
    case(_zz_dcdPopcount_13)
      3'b000 : _zz_dcdPopcount_12 = _zz_dcdPopcount_1;
      3'b001 : _zz_dcdPopcount_12 = _zz_dcdPopcount_2;
      3'b010 : _zz_dcdPopcount_12 = _zz_dcdPopcount_3;
      3'b011 : _zz_dcdPopcount_12 = _zz_dcdPopcount_4;
      3'b100 : _zz_dcdPopcount_12 = _zz_dcdPopcount_5;
      3'b101 : _zz_dcdPopcount_12 = _zz_dcdPopcount_6;
      3'b110 : _zz_dcdPopcount_12 = _zz_dcdPopcount_7;
      default : _zz_dcdPopcount_12 = _zz_dcdPopcount_8;
    endcase
  end

  always @(*) begin
    case(_zz_dcdPopcount_15)
      3'b000 : _zz_dcdPopcount_14 = _zz_dcdPopcount_1;
      3'b001 : _zz_dcdPopcount_14 = _zz_dcdPopcount_2;
      3'b010 : _zz_dcdPopcount_14 = _zz_dcdPopcount_3;
      3'b011 : _zz_dcdPopcount_14 = _zz_dcdPopcount_4;
      3'b100 : _zz_dcdPopcount_14 = _zz_dcdPopcount_5;
      3'b101 : _zz_dcdPopcount_14 = _zz_dcdPopcount_6;
      3'b110 : _zz_dcdPopcount_14 = _zz_dcdPopcount_7;
      default : _zz_dcdPopcount_14 = _zz_dcdPopcount_8;
    endcase
  end

  always @(*) begin
    uo_out = 8'bxxxxxxxx;
    uo_out[0] = uart_io_uartTxOut;
    uo_out[1] = uart_io_uartCtsOut;
    uo_out[2] = fakeDcd;
    uo_out[3] = layer_io_rxerror;
    uo_out[4] = layer_io_txerror;
    uo_out[5] = layer_io_sending;
    uo_out[6] = 1'b0;
    uo_out[7] = control_io_txClockStb;
  end

  always @(*) begin
    uio_out = 8'bxxxxxxxx;
    uio_out[0] = control_io_rxClock;
    uio_out[1] = control_io_upDownOut;
    uio_out[7 : 2] = control_io_addr6;
  end

  assign cfgUartRxPrescale = latched[0];
  assign cfgUartTxPrescale = latched[1];
  assign cfgRxData = latched[2];
  assign cfgTxData = latched[3];
  assign cfgRxClockDirection = (latched[5] ? 1'b0 : 1'b1);
  assign cfgUpDownSource = (latched[6] ? 1'b0 : 1'b1);
  assign cfgAddrDirection = (latched[7] ? 1'b0 : 1'b1);
  assign cfgTableLatency = latched[12];
  assign cfgRxClockSource = latched[13];
  assign cfgTxBertMode = _zz_cfgTxBertMode[7 : 6];
  always @(*) begin
    oe[0] = cfgRxClockDirection;
    oe[1] = cfgUpDownSource;
    oe[2] = cfgAddrDirection;
    oe[3] = cfgAddrDirection;
    oe[4] = cfgAddrDirection;
    oe[5] = cfgAddrDirection;
    oe[6] = cfgAddrDirection;
    oe[7] = cfgAddrDirection;
  end

  assign uio_oe = oe;
  assign rxDataIn = ui_in[0];
  assign rxClockIn = ui_in[1];
  assign uartRtsIn = ui_in[2];
  assign rom4 = ui_in[6 : 3];
  assign uartRxIn = ui_in[7];
  assign upDownIn = uio_in[1];
  assign addr6In = uio_in[7 : 2];
  assign sim = 1'b1;
  assign dcdHistory_0 = control_io_upDownOut;
  assign _zz_dcdPopcount = {dcdHistory_7,{dcdHistory_6,{dcdHistory_5,{dcdHistory_4,{dcdHistory_3,{dcdHistory_2,{dcdHistory_1,dcdHistory_0}}}}}}};
  assign _zz_dcdPopcount_1 = 4'b0000;
  assign _zz_dcdPopcount_2 = 4'b0001;
  assign _zz_dcdPopcount_3 = 4'b0001;
  assign _zz_dcdPopcount_4 = 4'b0010;
  assign _zz_dcdPopcount_5 = 4'b0001;
  assign _zz_dcdPopcount_6 = 4'b0010;
  assign _zz_dcdPopcount_7 = 4'b0010;
  assign _zz_dcdPopcount_8 = 4'b0011;
  assign dcdPopcount = (_zz_dcdPopcount_9 + _zz_dcdPopcount_14);
  assign fakeDcd = ((4'b0011 <= dcdPopcount) && (dcdPopcount <= 4'b0101));
  assign layer_io_resetCondx = (uartRtsIn && (! uartRtsIn_regNext));
  always @(posedge clk) begin
    if(!rst_n) begin
      dcdHistory_1 <= 1'b0;
      dcdHistory_2 <= 1'b0;
      dcdHistory_3 <= 1'b0;
      dcdHistory_4 <= 1'b0;
      dcdHistory_5 <= 1'b0;
      dcdHistory_6 <= 1'b0;
      dcdHistory_7 <= 1'b0;
    end else begin
      if(control_io_rxClock) begin
        dcdHistory_1 <= dcdHistory_0;
      end
      if(control_io_rxClock) begin
        dcdHistory_2 <= dcdHistory_1;
      end
      if(control_io_rxClock) begin
        dcdHistory_3 <= dcdHistory_2;
      end
      if(control_io_rxClock) begin
        dcdHistory_4 <= dcdHistory_3;
      end
      if(control_io_rxClock) begin
        dcdHistory_5 <= dcdHistory_4;
      end
      if(control_io_rxClock) begin
        dcdHistory_6 <= dcdHistory_5;
      end
      if(control_io_rxClock) begin
        dcdHistory_7 <= dcdHistory_6;
      end
    end
  end

  always @(posedge clk) begin
    uartRtsIn_regNext <= uartRtsIn;
  end


endmodule

module LayerControl (
  input               io_resetCondx,
  input               io_hdlcTxActive,
  input               io_hdlcFrameError,
  input               io_hdlcCrcError,
  input               io_hdlcUnderrun,
  output reg          io_txerror,
  output reg          io_rxerror,
  output              io_sending,
  input               clk,
  input               rst_n
);

  reg                 txErrorReg;
  reg                 rxErrorReg;
  wire                when_ModemTop_l596;

  always @(*) begin
    io_txerror = txErrorReg;
    if(!io_resetCondx) begin
      if(io_hdlcUnderrun) begin
        io_txerror = 1'b1;
      end
    end
  end

  always @(*) begin
    io_rxerror = rxErrorReg;
    if(!io_resetCondx) begin
      if(when_ModemTop_l596) begin
        io_rxerror = 1'b1;
      end
    end
  end

  assign io_sending = io_hdlcTxActive;
  assign when_ModemTop_l596 = (io_hdlcFrameError || io_hdlcCrcError);
  always @(posedge clk) begin
    if(!rst_n) begin
      txErrorReg <= 1'b0;
      rxErrorReg <= 1'b0;
    end else begin
      if(io_resetCondx) begin
        txErrorReg <= 1'b0;
        rxErrorReg <= 1'b0;
      end else begin
        if(io_hdlcUnderrun) begin
          txErrorReg <= 1'b1;
        end
        if(when_ModemTop_l596) begin
          rxErrorReg <= 1'b1;
        end
      end
    end
  end


endmodule

module UartControl (
  input               io_uartRxIn,
  input               io_uartRtsIn,
  input               io_txClockStb,
  input               io_rxClockStb,
  output              io_uartTxOut,
  output              io_uartCtsOut,
  input               clk,
  input               rst_n
);

  wire                tx_io_valid;
  reg                 rx_io_ready;
  wire       [7:0]    txFifo_io_dataOut;
  wire                txFifo_io_full;
  wire                txFifo_io_almostFull;
  wire                txFifo_io_almostEmpty;
  wire                txFifo_io_empty;
  wire                txFifo_io_eoverrun;
  wire                tx_io_ready;
  wire                tx_io_uartTxOut;
  wire       [7:0]    rx_io_payload;
  wire                rx_io_valid;
  wire                rx_io_eoverrun;
  wire       [7:0]    rxFifo_io_dataOut;
  wire                rxFifo_io_full;
  wire                rxFifo_io_almostFull;
  wire                rxFifo_io_almostEmpty;
  wire                rxFifo_io_empty;
  wire                rxFifo_io_eoverrun;

  UartFifo txFifo (
    .io_dataIn      (8'h00                 ), //i
    .io_dataInEn    (1'b0                  ), //i
    .io_dataOutEn   (tx_io_ready           ), //i
    .io_dataOut     (txFifo_io_dataOut[7:0]), //o
    .io_full        (txFifo_io_full        ), //o
    .io_almostFull  (txFifo_io_almostFull  ), //o
    .io_almostEmpty (txFifo_io_almostEmpty ), //o
    .io_empty       (txFifo_io_empty       ), //o
    .io_eoverrun    (txFifo_io_eoverrun    ), //o
    .clk            (clk                   ), //i
    .rst_n          (rst_n                 )  //i
  );
  UartTx tx (
    .io_txClockStb (io_txClockStb         ), //i
    .io_data       (txFifo_io_dataOut[7:0]), //i
    .io_valid      (tx_io_valid           ), //i
    .io_ready      (tx_io_ready           ), //o
    .io_uartTxOut  (tx_io_uartTxOut       ), //o
    .clk           (clk                   ), //i
    .rst_n         (rst_n                 )  //i
  );
  UartRx rx (
    .io_rxClockStb (io_rxClockStb     ), //i
    .io_uartRxIn   (io_uartRxIn       ), //i
    .io_ready      (rx_io_ready       ), //i
    .io_payload    (rx_io_payload[7:0]), //o
    .io_valid      (rx_io_valid       ), //o
    .io_eoverrun   (rx_io_eoverrun    ), //o
    .clk           (clk               ), //i
    .rst_n         (rst_n             )  //i
  );
  UartFifo_1 rxFifo (
    .io_dataIn      (rx_io_payload[7:0]    ), //i
    .io_dataInEn    (rx_io_valid           ), //i
    .io_dataOutEn   (1'b0                  ), //i
    .io_dataOut     (rxFifo_io_dataOut[7:0]), //o
    .io_full        (rxFifo_io_full        ), //o
    .io_almostFull  (rxFifo_io_almostFull  ), //o
    .io_almostEmpty (rxFifo_io_almostEmpty ), //o
    .io_empty       (rxFifo_io_empty       ), //o
    .io_eoverrun    (rxFifo_io_eoverrun    ), //o
    .clk            (clk                   ), //i
    .rst_n          (rst_n                 )  //i
  );
  assign tx_io_valid = (! txFifo_io_empty);
  always @(*) begin
    rx_io_ready = 1'b0;
    if(rx_io_valid) begin
      rx_io_ready = 1'b1;
    end
  end

  assign io_uartCtsOut = txFifo_io_almostFull;
  assign io_uartTxOut = tx_io_uartTxOut;

endmodule

module ModemControl (
  input               io_sim,
  input               io_cfgUartTxPrescale,
  input               io_cfgUartRxPrescale,
  input               io_cfgTableLatency,
  input               io_cfgUpDownSource,
  input      [3:0]    io_rom4,
  input               io_upDownIn,
  input               io_rxClockIn,
  input               io_txDataIn,
  input               io_rxDataRawIn,
  output              io_txClockStb,
  output     [5:0]    io_addr6,
  output              io_upDownOut,
  output              io_rxClock,
  output     [7:0]    io_txDac8,
  output     [7:0]    io_rxDac8,
  output              io_uartTxClock,
  output              io_uartRxClock,
  input               rst_n,
  input               clk
);

  wire                scrambler_1_io_vecOut_0;
  wire                scrambler_1_io_vecOut_1;
  wire                scrambler_1_io_vecOut_2;
  wire                scrambler_1_io_vecOut_3;
  wire                scrambler_1_io_vecOut_4;
  wire                scrambler_1_io_vecOut_5;
  wire                scrambler_1_io_vecOut_6;
  wire                scrambler_1_io_vecOut_7;
  wire                scrambler_1_io_vecOut_8;
  wire                scrambler_1_io_vecOut_9;
  wire                scrambler_1_io_vecOut_10;
  wire                scrambler_1_io_vecOut_11;
  wire                scrambler_1_io_vecOut_12;
  wire                scrambler_1_io_vecOut_13;
  wire                scrambler_1_io_vecOut_14;
  wire                scrambler_1_io_vecOut_15;
  wire                scrambler_1_io_dataOut;
  wire       [15:0]   _zz_txAddr12;
  wire       [0:0]    _zz_txAddr12_1;
  wire       [4:0]    _zz_txAddr12_2;
  wire       [15:0]   _zz_txAddr12_3;
  wire       [0:0]    _zz_txAddr12_4;
  wire       [3:0]    _zz_txAddr12_5;
  wire       [7:0]    _zz_rxClockInternal;
  reg        [5:0]    tablePhase;
  wire                when_ModemTop_l665;
  wire                rxClockFixed;
  wire                _zz_rxClockFixedStb;
  reg                 _zz_rxClockFixedStb_regNext;
  wire                rxClockFixedStb;
  wire                txClock;
  wire                _zz_txClockStb;
  reg                 _zz_txClockStb_regNext;
  wire                txClockStb;
  reg                 _zz_io_uartTxClock;
  reg                 _zz_io_uartRxClock;
  reg        [3:0]    rxCtr;
  wire                txClock2;
  wire                txClock3;
  reg        [7:0]    rxAddr8;
  wire       [11:0]   rxAddr;
  wire                rxClock;
  wire                when_ModemTop_l719;
  wire                txClockInternal;
  wire                _zz_txClockInternalRiseStb;
  reg                 _zz_txClockInternalRiseStb_regNext;
  wire                txClockInternalRiseStb;
  wire                _zz_txClockInternalFallStb;
  reg                 _zz_txClockInternalFallStb_regNext;
  wire                txClockInternalFallStb;
  reg                 txDataAfterReg;
  reg        [11:0]   txAddr12;
  wire       [1:0]    switch_Misc_l226;
  reg        [5:0]    table6;
  reg        [7:0]    txDac;
  reg        [3:0]    txDacTmp;
  reg        [7:0]    rxRcrDac;
  reg        [3:0]    rxRcrDacTmp;
  wire       [1:0]    phase;
  reg                 updownSource;
  reg                 zeroCrossDet_0;
  reg                 zeroCrossDet_1;
  reg                 zeroCrossDet_2;
  reg                 zeroCrossDet_3;
  reg                 zeroCrossDet_4;
  reg                 zeroCrossDet_5;
  reg                 zeroCrossDet_6;
  reg                 zeroCrossDet_7;
  wire                rxClockInternal;
  wire                when_ModemTop_l836;

  assign _zz_txAddr12 = {scrambler_1_io_vecOut_15,{scrambler_1_io_vecOut_14,{scrambler_1_io_vecOut_13,{scrambler_1_io_vecOut_12,{scrambler_1_io_vecOut_11,{scrambler_1_io_vecOut_10,{scrambler_1_io_vecOut_9,{scrambler_1_io_vecOut_8,{scrambler_1_io_vecOut_7,{scrambler_1_io_vecOut_6,{_zz_txAddr12_1,_zz_txAddr12_2}}}}}}}}}}};
  assign _zz_txAddr12_3 = {scrambler_1_io_vecOut_15,{scrambler_1_io_vecOut_14,{scrambler_1_io_vecOut_13,{scrambler_1_io_vecOut_12,{scrambler_1_io_vecOut_11,{scrambler_1_io_vecOut_10,{scrambler_1_io_vecOut_9,{scrambler_1_io_vecOut_8,{scrambler_1_io_vecOut_7,{scrambler_1_io_vecOut_6,{scrambler_1_io_vecOut_5,{_zz_txAddr12_4,_zz_txAddr12_5}}}}}}}}}}}};
  assign _zz_rxClockInternal = {zeroCrossDet_7,{zeroCrossDet_6,{zeroCrossDet_5,{zeroCrossDet_4,{zeroCrossDet_3,{zeroCrossDet_2,{zeroCrossDet_1,zeroCrossDet_0}}}}}}};
  assign _zz_txAddr12_1 = scrambler_1_io_vecOut_5;
  assign _zz_txAddr12_2 = {scrambler_1_io_vecOut_4,{scrambler_1_io_vecOut_3,{scrambler_1_io_vecOut_2,{scrambler_1_io_vecOut_1,scrambler_1_io_vecOut_0}}}};
  assign _zz_txAddr12_4 = scrambler_1_io_vecOut_4;
  assign _zz_txAddr12_5 = {scrambler_1_io_vecOut_3,{scrambler_1_io_vecOut_2,{scrambler_1_io_vecOut_1,scrambler_1_io_vecOut_0}}};
  Scrambler scrambler_1 (
    .io_dataIn    (txDataAfterReg          ), //i
    .io_en        (txClockInternalFallStb  ), //i
    .io_sim       (io_sim                  ), //i
    .io_vecOut_0  (scrambler_1_io_vecOut_0 ), //o
    .io_vecOut_1  (scrambler_1_io_vecOut_1 ), //o
    .io_vecOut_2  (scrambler_1_io_vecOut_2 ), //o
    .io_vecOut_3  (scrambler_1_io_vecOut_3 ), //o
    .io_vecOut_4  (scrambler_1_io_vecOut_4 ), //o
    .io_vecOut_5  (scrambler_1_io_vecOut_5 ), //o
    .io_vecOut_6  (scrambler_1_io_vecOut_6 ), //o
    .io_vecOut_7  (scrambler_1_io_vecOut_7 ), //o
    .io_vecOut_8  (scrambler_1_io_vecOut_8 ), //o
    .io_vecOut_9  (scrambler_1_io_vecOut_9 ), //o
    .io_vecOut_10 (scrambler_1_io_vecOut_10), //o
    .io_vecOut_11 (scrambler_1_io_vecOut_11), //o
    .io_vecOut_12 (scrambler_1_io_vecOut_12), //o
    .io_vecOut_13 (scrambler_1_io_vecOut_13), //o
    .io_vecOut_14 (scrambler_1_io_vecOut_14), //o
    .io_vecOut_15 (scrambler_1_io_vecOut_15), //o
    .io_dataOut   (scrambler_1_io_dataOut  ), //o
    .rst_n        (rst_n                   ), //i
    .clk          (clk                     )  //i
  );
  assign when_ModemTop_l665 = (! rst_n);
  assign rxClockFixed = tablePhase[1];
  assign _zz_rxClockFixedStb = tablePhase[1];
  assign rxClockFixedStb = (_zz_rxClockFixedStb && (! _zz_rxClockFixedStb_regNext));
  assign txClock = tablePhase[2];
  assign _zz_txClockStb = tablePhase[2];
  assign txClockStb = (_zz_txClockStb && (! _zz_txClockStb_regNext));
  always @(*) begin
    case(io_cfgUartTxPrescale)
      1'b0 : begin
        _zz_io_uartTxClock = tablePhase[4];
      end
      default : begin
        _zz_io_uartTxClock = tablePhase[5];
      end
    endcase
  end

  assign io_uartTxClock = _zz_io_uartTxClock;
  always @(*) begin
    case(io_cfgUartRxPrescale)
      1'b0 : begin
        _zz_io_uartRxClock = tablePhase[1];
      end
      default : begin
        _zz_io_uartRxClock = tablePhase[2];
      end
    endcase
  end

  assign io_uartRxClock = _zz_io_uartRxClock;
  assign txClock2 = rxCtr[2];
  assign txClock3 = rxCtr[3];
  assign rxAddr = {rxAddr8,rxCtr};
  assign rxClock = rxCtr[2];
  assign when_ModemTop_l719 = (! rst_n);
  assign txClockInternal = rxCtr[3];
  assign _zz_txClockInternalRiseStb = rxCtr[3];
  assign txClockInternalRiseStb = (_zz_txClockInternalRiseStb && (! _zz_txClockInternalRiseStb_regNext));
  assign _zz_txClockInternalFallStb = rxCtr[3];
  assign txClockInternalFallStb = ((! _zz_txClockInternalFallStb) && _zz_txClockInternalFallStb_regNext);
  always @(*) begin
    txAddr12[1 : 0] = rxCtr[3 : 2];
    txAddr12[9 : 2] = _zz_txAddr12[7 : 0];
    txAddr12[11 : 10] = _zz_txAddr12_3[1 : 0];
  end

  assign switch_Misc_l226 = tablePhase[1 : 0];
  always @(*) begin
    case(switch_Misc_l226)
      2'b00 : begin
        table6 = txAddr12[11 : 6];
      end
      2'b01 : begin
        table6 = txAddr12[5 : 0];
      end
      2'b10 : begin
        table6 = rxAddr[11 : 6];
      end
      default : begin
        table6 = rxAddr[5 : 0];
      end
    endcase
  end

  assign io_addr6 = table6;
  assign io_txDac8 = txDac;
  assign io_rxDac8 = rxRcrDac;
  assign phase = tablePhase[1 : 0];
  always @(*) begin
    case(io_cfgUpDownSource)
      1'b0 : begin
        updownSource = rxRcrDac[7];
      end
      default : begin
        updownSource = io_upDownIn;
      end
    endcase
  end

  assign rxClockInternal = (_zz_rxClockInternal[7] ^ io_rxDataRawIn);
  assign when_ModemTop_l836 = (! rst_n);
  assign io_txClockStb = txClockStb;
  assign io_rxClock = rxClock;
  assign io_upDownOut = updownSource;
  always @(posedge clk) begin
    if(when_ModemTop_l665) begin
      tablePhase <= 6'h00;
    end else begin
      tablePhase <= (tablePhase - 6'h01);
    end
    _zz_rxClockFixedStb_regNext <= _zz_rxClockFixedStb;
    _zz_txClockStb_regNext <= _zz_txClockStb;
    rxCtr <= (rxCtr + 4'b0001);
    if(when_ModemTop_l719) begin
      rxCtr <= 4'b0000;
    end
    _zz_txClockInternalRiseStb_regNext <= _zz_txClockInternalRiseStb;
    _zz_txClockInternalFallStb_regNext <= _zz_txClockInternalFallStb;
    if(txClockInternalRiseStb) begin
      txDataAfterReg <= io_txDataIn;
    end
    if(io_cfgTableLatency) begin
      case(phase)
        2'b00 : begin
          rxRcrDac <= {rxRcrDacTmp,io_rom4};
        end
        2'b01 : begin
          rxRcrDacTmp <= io_rom4;
        end
        2'b10 : begin
          txDac <= {txDacTmp,io_rom4};
        end
        default : begin
          txDacTmp <= io_rom4;
        end
      endcase
    end else begin
      case(phase)
        2'b00 : begin
          txDacTmp <= io_rom4;
        end
        2'b01 : begin
          rxRcrDac <= {rxRcrDacTmp,io_rom4};
        end
        2'b10 : begin
          rxRcrDacTmp <= io_rom4;
        end
        default : begin
          txDac <= {txDacTmp,io_rom4};
        end
      endcase
    end
    if(txClockStb) begin
      zeroCrossDet_0 <= io_rxDataRawIn;
      zeroCrossDet_1 <= zeroCrossDet_0;
      zeroCrossDet_2 <= zeroCrossDet_1;
      zeroCrossDet_3 <= zeroCrossDet_2;
      zeroCrossDet_4 <= zeroCrossDet_3;
      zeroCrossDet_5 <= zeroCrossDet_4;
      zeroCrossDet_6 <= zeroCrossDet_5;
      zeroCrossDet_7 <= zeroCrossDet_6;
    end
    if(when_ModemTop_l836) begin
      rxAddr8 <= 8'h00;
    end else begin
      if(rxClockInternal) begin
        if(updownSource) begin
          rxAddr8 <= (rxAddr8 + 8'h01);
        end else begin
          rxAddr8 <= (rxAddr8 - 8'h01);
        end
      end
    end
  end


endmodule

module UartFifo_1 (
  input      [7:0]    io_dataIn,
  input               io_dataInEn,
  input               io_dataOutEn,
  output     [7:0]    io_dataOut,
  output              io_full,
  output              io_almostFull,
  output              io_almostEmpty,
  output              io_empty,
  output              io_eoverrun,
  input               clk,
  input               rst_n
);

  reg        [7:0]    _zz_io_dataOut;
  reg        [7:0]    fifo_0;
  reg        [7:0]    fifo_1;
  reg        [7:0]    fifo_2;
  reg        [7:0]    fifo_3;
  reg        [7:0]    fifo_4;
  reg        [7:0]    fifo_5;
  reg        [7:0]    fifo_6;
  reg        [7:0]    fifo_7;
  reg        [2:0]    nextOut;
  reg        [2:0]    nextIn;
  reg        [3:0]    count;
  wire                when_ModemTop_l318;
  wire       [7:0]    _zz_1;

  always @(*) begin
    case(nextOut)
      3'b000 : _zz_io_dataOut = fifo_0;
      3'b001 : _zz_io_dataOut = fifo_1;
      3'b010 : _zz_io_dataOut = fifo_2;
      3'b011 : _zz_io_dataOut = fifo_3;
      3'b100 : _zz_io_dataOut = fifo_4;
      3'b101 : _zz_io_dataOut = fifo_5;
      3'b110 : _zz_io_dataOut = fifo_6;
      default : _zz_io_dataOut = fifo_7;
    endcase
  end

  assign when_ModemTop_l318 = (io_dataInEn && io_dataOutEn);
  assign _zz_1 = ({7'd0,1'b1} <<< nextIn);
  assign io_dataOut = _zz_io_dataOut;
  assign io_full = (count == 4'b1000);
  assign io_almostFull = (count == 4'b0111);
  assign io_almostEmpty = (count == 4'b0001);
  assign io_empty = (count == 4'b0000);
  assign io_eoverrun = ((count == 4'b1000) && io_dataInEn);
  always @(posedge clk) begin
    if(!rst_n) begin
      nextOut <= 3'b000;
      nextIn <= 3'b000;
      count <= 4'b0000;
    end else begin
      if(!when_ModemTop_l318) begin
        if(io_dataInEn) begin
          count <= (count + 4'b0001);
        end else begin
          if(io_dataOutEn) begin
            count <= (count - 4'b0001);
          end
        end
      end
      if(io_dataInEn) begin
        nextIn <= (nextIn + 3'b001);
      end
      if(io_dataOutEn) begin
        nextOut <= (nextOut + 3'b001);
      end
    end
  end

  always @(posedge clk) begin
    if(io_dataInEn) begin
      if(_zz_1[0]) begin
        fifo_0 <= io_dataIn;
      end
      if(_zz_1[1]) begin
        fifo_1 <= io_dataIn;
      end
      if(_zz_1[2]) begin
        fifo_2 <= io_dataIn;
      end
      if(_zz_1[3]) begin
        fifo_3 <= io_dataIn;
      end
      if(_zz_1[4]) begin
        fifo_4 <= io_dataIn;
      end
      if(_zz_1[5]) begin
        fifo_5 <= io_dataIn;
      end
      if(_zz_1[6]) begin
        fifo_6 <= io_dataIn;
      end
      if(_zz_1[7]) begin
        fifo_7 <= io_dataIn;
      end
    end
  end


endmodule

module UartRx (
  input               io_rxClockStb,
  input               io_uartRxIn,
  input               io_ready,
  output     [7:0]    io_payload,
  output              io_valid,
  output reg          io_eoverrun,
  input               clk,
  input               rst_n
);
  localparam fsmUartRx_enumDef_BOOT = 3'd0;
  localparam fsmUartRx_enumDef_IDLE = 3'd1;
  localparam fsmUartRx_enumDef_START = 3'd2;
  localparam fsmUartRx_enumDef_DATA = 3'd3;
  localparam fsmUartRx_enumDef_STOP = 3'd4;

  wire                io_uartRxIn_buffercc_io_dataOut;
  wire                _zz_sampleValue;
  wire                _zz_sampleValue_1;
  wire                _zz_sampleValue_2;
  wire                _zz_sampleValue_3;
  wire                _zz_sampleValue_4;
  wire                _zz_sampleValue_5;
  wire                _zz_sampleValue_6;
  wire                _zz_sampleValue_7;
  wire                _zz_sampleValue_8;
  wire                _zz_sampleValue_9;
  wire                _zz_sampleValue_10;
  wire                _zz_sampleValue_11;
  wire                _zz_sampleValue_12;
  wire                _zz_sampleValue_13;
  wire                _zz_sampleValue_14;
  wire                _zz_sampleValue_15;
  wire                _zz_sampleValue_16;
  wire                _zz_sampleValue_17;
  wire                _zz_sampleValue_18;
  wire                _zz_sampleValue_19;
  wire                _zz_sampleValue_20;
  wire                _zz_sampleValue_21;
  wire                _zz_sampleValue_22;
  wire                _zz_sampleValue_23;
  wire                _zz_sampleValue_24;
  wire                _zz_sampleValue_25;
  wire                _zz_sampleValue_26;
  wire                _zz_sampleValue_27;
  wire                _zz_sampleValue_28;
  wire                _zz_sampleValue_29;
  wire                _zz_sampleValue_30;
  wire                _zz_sampleValue_31;
  wire                _zz_sampleValue_32;
  wire                _zz_sampleValue_33;
  wire                _zz_sampleValue_34;
  wire                _zz_sampleValue_35;
  reg        [7:0]    payloadReg;
  reg                 validReg;
  wire                MARK;
  wire                SPACE;
  wire                cc;
  wire                samples_0;
  reg                 samples_1;
  reg                 samples_2;
  reg                 samples_3;
  reg                 samples_4;
  reg                 samples_5;
  reg                 samples_6;
  wire                sampleValue;
  reg        [2:0]    sampleTimer_counter;
  reg                 sampleTimer_tick;
  reg        [2:0]    bitId;
  wire                fsmUartRx_wantExit;
  reg                 fsmUartRx_wantStart;
  wire                fsmUartRx_wantKill;
  wire                when_ModemTop_l501;
  reg        [2:0]    fsmUartRx_stateReg;
  reg        [2:0]    fsmUartRx_stateNext;
  wire                when_ModemTop_l462;
  wire                when_ModemTop_l482;
  wire                when_ModemTop_l491;
  `ifndef SYNTHESIS
  reg [39:0] fsmUartRx_stateReg_string;
  reg [39:0] fsmUartRx_stateNext_string;
  `endif


  assign _zz_sampleValue = (((((_zz_sampleValue_1 || _zz_sampleValue_26) || (_zz_sampleValue_27 && samples_6)) || ((_zz_sampleValue_28 && samples_5) && samples_6)) || (((_zz_sampleValue_29 && samples_2) && samples_5) && samples_6)) || ((((_zz_sampleValue_30 && samples_0) && samples_3) && samples_5) && samples_6));
  assign _zz_sampleValue_31 = ((((1'b1 && samples_1) && samples_3) && samples_5) && samples_6);
  assign _zz_sampleValue_32 = (((1'b1 && samples_2) && samples_3) && samples_5);
  assign _zz_sampleValue_33 = ((1'b1 && samples_0) && samples_4);
  assign _zz_sampleValue_34 = (1'b1 && samples_1);
  assign _zz_sampleValue_35 = 1'b1;
  assign _zz_sampleValue_1 = (((((_zz_sampleValue_2 || _zz_sampleValue_21) || (_zz_sampleValue_22 && samples_6)) || ((_zz_sampleValue_23 && samples_4) && samples_6)) || (((_zz_sampleValue_24 && samples_3) && samples_4) && samples_6)) || ((((_zz_sampleValue_25 && samples_1) && samples_3) && samples_4) && samples_6));
  assign _zz_sampleValue_26 = ((((1'b1 && samples_2) && samples_3) && samples_4) && samples_6);
  assign _zz_sampleValue_27 = (((1'b1 && samples_0) && samples_1) && samples_5);
  assign _zz_sampleValue_28 = ((1'b1 && samples_0) && samples_2);
  assign _zz_sampleValue_29 = (1'b1 && samples_1);
  assign _zz_sampleValue_30 = 1'b1;
  assign _zz_sampleValue_2 = ((((((_zz_sampleValue_3 || _zz_sampleValue_16) || (_zz_sampleValue_17 && samples_5)) || ((_zz_sampleValue_18 && samples_2) && samples_6)) || (((_zz_sampleValue_19 && samples_1) && samples_3) && samples_6)) || ((((_zz_sampleValue_20 && samples_0) && samples_2) && samples_3) && samples_6)) || ((((1'b1 && samples_1) && samples_2) && samples_3) && samples_6));
  assign _zz_sampleValue_21 = ((((1'b1 && samples_0) && samples_1) && samples_4) && samples_6);
  assign _zz_sampleValue_22 = (((1'b1 && samples_0) && samples_2) && samples_4);
  assign _zz_sampleValue_23 = ((1'b1 && samples_1) && samples_2);
  assign _zz_sampleValue_24 = (1'b1 && samples_0);
  assign _zz_sampleValue_25 = 1'b1;
  assign _zz_sampleValue_3 = ((((((_zz_sampleValue_4 || _zz_sampleValue_11) || (_zz_sampleValue_12 && samples_5)) || ((_zz_sampleValue_13 && samples_4) && samples_5)) || (((_zz_sampleValue_14 && samples_2) && samples_4) && samples_5)) || ((((_zz_sampleValue_15 && samples_1) && samples_2) && samples_4) && samples_5)) || ((((1'b1 && samples_0) && samples_3) && samples_4) && samples_5));
  assign _zz_sampleValue_16 = ((((1'b1 && samples_1) && samples_3) && samples_4) && samples_5);
  assign _zz_sampleValue_17 = (((1'b1 && samples_2) && samples_3) && samples_4);
  assign _zz_sampleValue_18 = ((1'b1 && samples_0) && samples_1);
  assign _zz_sampleValue_19 = (1'b1 && samples_0);
  assign _zz_sampleValue_20 = 1'b1;
  assign _zz_sampleValue_4 = ((((((_zz_sampleValue_5 || _zz_sampleValue_6) || (_zz_sampleValue_7 && samples_4)) || ((_zz_sampleValue_8 && samples_3) && samples_4)) || (((_zz_sampleValue_9 && samples_2) && samples_3) && samples_4)) || ((((_zz_sampleValue_10 && samples_0) && samples_1) && samples_2) && samples_5)) || ((((1'b1 && samples_0) && samples_1) && samples_3) && samples_5));
  assign _zz_sampleValue_11 = ((((1'b1 && samples_0) && samples_2) && samples_3) && samples_5);
  assign _zz_sampleValue_12 = (((1'b1 && samples_1) && samples_2) && samples_3);
  assign _zz_sampleValue_13 = ((1'b1 && samples_0) && samples_1);
  assign _zz_sampleValue_14 = (1'b1 && samples_0);
  assign _zz_sampleValue_15 = 1'b1;
  assign _zz_sampleValue_5 = (1'b0 || ((((1'b1 && samples_0) && samples_1) && samples_2) && samples_3));
  assign _zz_sampleValue_6 = ((((1'b1 && samples_0) && samples_1) && samples_2) && samples_4);
  assign _zz_sampleValue_7 = (((1'b1 && samples_0) && samples_1) && samples_3);
  assign _zz_sampleValue_8 = ((1'b1 && samples_0) && samples_2);
  assign _zz_sampleValue_9 = (1'b1 && samples_1);
  assign _zz_sampleValue_10 = 1'b1;
  BufferCC io_uartRxIn_buffercc (
    .io_dataIn  (io_uartRxIn                    ), //i
    .io_dataOut (io_uartRxIn_buffercc_io_dataOut), //o
    .clk        (clk                            ), //i
    .rst_n      (rst_n                          )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(fsmUartRx_stateReg)
      fsmUartRx_enumDef_BOOT : fsmUartRx_stateReg_string = "BOOT ";
      fsmUartRx_enumDef_IDLE : fsmUartRx_stateReg_string = "IDLE ";
      fsmUartRx_enumDef_START : fsmUartRx_stateReg_string = "START";
      fsmUartRx_enumDef_DATA : fsmUartRx_stateReg_string = "DATA ";
      fsmUartRx_enumDef_STOP : fsmUartRx_stateReg_string = "STOP ";
      default : fsmUartRx_stateReg_string = "?????";
    endcase
  end
  always @(*) begin
    case(fsmUartRx_stateNext)
      fsmUartRx_enumDef_BOOT : fsmUartRx_stateNext_string = "BOOT ";
      fsmUartRx_enumDef_IDLE : fsmUartRx_stateNext_string = "IDLE ";
      fsmUartRx_enumDef_START : fsmUartRx_stateNext_string = "START";
      fsmUartRx_enumDef_DATA : fsmUartRx_stateNext_string = "DATA ";
      fsmUartRx_enumDef_STOP : fsmUartRx_stateNext_string = "STOP ";
      default : fsmUartRx_stateNext_string = "?????";
    endcase
  end
  `endif

  always @(*) begin
    io_eoverrun = 1'b0;
    case(fsmUartRx_stateReg)
      fsmUartRx_enumDef_IDLE : begin
      end
      fsmUartRx_enumDef_START : begin
        if(sampleTimer_tick) begin
          if(io_valid) begin
            io_eoverrun = 1'b1;
          end
        end
      end
      fsmUartRx_enumDef_DATA : begin
      end
      fsmUartRx_enumDef_STOP : begin
      end
      default : begin
      end
    endcase
  end

  assign io_payload = payloadReg;
  assign io_valid = validReg;
  assign MARK = 1'b1;
  assign SPACE = 1'b0;
  assign cc = io_uartRxIn_buffercc_io_dataOut;
  assign samples_0 = cc;
  assign sampleValue = ((((((_zz_sampleValue || _zz_sampleValue_31) || (_zz_sampleValue_32 && samples_6)) || ((_zz_sampleValue_33 && samples_5) && samples_6)) || (((_zz_sampleValue_34 && samples_4) && samples_5) && samples_6)) || ((((_zz_sampleValue_35 && samples_2) && samples_4) && samples_5) && samples_6)) || ((((1'b1 && samples_3) && samples_4) && samples_5) && samples_6));
  always @(*) begin
    sampleTimer_tick = 1'b0;
    if(io_rxClockStb) begin
      sampleTimer_tick = (sampleTimer_counter == 3'b000);
    end
  end

  assign fsmUartRx_wantExit = 1'b0;
  always @(*) begin
    fsmUartRx_wantStart = 1'b0;
    case(fsmUartRx_stateReg)
      fsmUartRx_enumDef_IDLE : begin
      end
      fsmUartRx_enumDef_START : begin
      end
      fsmUartRx_enumDef_DATA : begin
      end
      fsmUartRx_enumDef_STOP : begin
      end
      default : begin
        fsmUartRx_wantStart = 1'b1;
      end
    endcase
  end

  assign fsmUartRx_wantKill = 1'b0;
  assign when_ModemTop_l501 = (io_valid && io_ready);
  always @(*) begin
    fsmUartRx_stateNext = fsmUartRx_stateReg;
    case(fsmUartRx_stateReg)
      fsmUartRx_enumDef_IDLE : begin
        if(when_ModemTop_l462) begin
          fsmUartRx_stateNext = fsmUartRx_enumDef_START;
        end
      end
      fsmUartRx_enumDef_START : begin
        if(sampleTimer_tick) begin
          if(io_valid) begin
            fsmUartRx_stateNext = fsmUartRx_enumDef_IDLE;
          end else begin
            fsmUartRx_stateNext = fsmUartRx_enumDef_DATA;
          end
        end
      end
      fsmUartRx_enumDef_DATA : begin
        if(sampleTimer_tick) begin
          if(when_ModemTop_l482) begin
            fsmUartRx_stateNext = fsmUartRx_enumDef_STOP;
          end
        end
      end
      fsmUartRx_enumDef_STOP : begin
        if(sampleTimer_tick) begin
          fsmUartRx_stateNext = fsmUartRx_enumDef_IDLE;
        end
      end
      default : begin
      end
    endcase
    if(fsmUartRx_wantStart) begin
      fsmUartRx_stateNext = fsmUartRx_enumDef_IDLE;
    end
    if(fsmUartRx_wantKill) begin
      fsmUartRx_stateNext = fsmUartRx_enumDef_BOOT;
    end
  end

  assign when_ModemTop_l462 = (io_rxClockStb && (sampleValue == SPACE));
  assign when_ModemTop_l482 = (bitId == 3'b111);
  assign when_ModemTop_l491 = (sampleValue == MARK);
  always @(posedge clk) begin
    payloadReg <= 8'bxxxxxxxx;
    if(io_rxClockStb) begin
      samples_1 <= samples_0;
    end
    if(io_rxClockStb) begin
      samples_2 <= samples_1;
    end
    if(io_rxClockStb) begin
      samples_3 <= samples_2;
    end
    if(io_rxClockStb) begin
      samples_4 <= samples_3;
    end
    if(io_rxClockStb) begin
      samples_5 <= samples_4;
    end
    if(io_rxClockStb) begin
      samples_6 <= samples_5;
    end
    if(io_rxClockStb) begin
      sampleTimer_counter <= (sampleTimer_counter - 3'b001);
    end
    case(fsmUartRx_stateReg)
      fsmUartRx_enumDef_IDLE : begin
        if(when_ModemTop_l462) begin
          sampleTimer_counter <= 3'b101;
        end
      end
      fsmUartRx_enumDef_START : begin
        if(sampleTimer_tick) begin
          if(!io_valid) begin
            bitId <= 3'b000;
          end
        end
      end
      fsmUartRx_enumDef_DATA : begin
        if(sampleTimer_tick) begin
          payloadReg[bitId] <= sampleValue;
          if(!when_ModemTop_l482) begin
            bitId <= (bitId + 3'b001);
          end
        end
      end
      fsmUartRx_enumDef_STOP : begin
      end
      default : begin
      end
    endcase
  end

  always @(posedge clk) begin
    if(!rst_n) begin
      validReg <= 1'b0;
      fsmUartRx_stateReg <= fsmUartRx_enumDef_BOOT;
    end else begin
      if(when_ModemTop_l501) begin
        validReg <= 1'b0;
      end
      fsmUartRx_stateReg <= fsmUartRx_stateNext;
      case(fsmUartRx_stateReg)
        fsmUartRx_enumDef_IDLE : begin
        end
        fsmUartRx_enumDef_START : begin
        end
        fsmUartRx_enumDef_DATA : begin
        end
        fsmUartRx_enumDef_STOP : begin
          if(sampleTimer_tick) begin
            if(when_ModemTop_l491) begin
              validReg <= 1'b1;
            end
          end
        end
        default : begin
        end
      endcase
    end
  end


endmodule

module UartTx (
  input               io_txClockStb,
  input      [7:0]    io_data,
  input               io_valid,
  output reg          io_ready,
  output reg          io_uartTxOut,
  input               clk,
  input               rst_n
);
  localparam fsmUartTx_enumDef_BOOT = 3'd0;
  localparam fsmUartTx_enumDef_IDLE = 3'd1;
  localparam fsmUartTx_enumDef_START = 3'd2;
  localparam fsmUartTx_enumDef_DATA = 3'd3;
  localparam fsmUartTx_enumDef_STOP = 3'd4;

  wire                MARK;
  wire                SPACE;
  reg        [2:0]    bitId;
  wire                fsmUartTx_wantExit;
  reg                 fsmUartTx_wantStart;
  wire                fsmUartTx_wantKill;
  reg        [2:0]    fsmUartTx_stateReg;
  reg        [2:0]    fsmUartTx_stateNext;
  wire                when_ModemTop_l389;
  `ifndef SYNTHESIS
  reg [39:0] fsmUartTx_stateReg_string;
  reg [39:0] fsmUartTx_stateNext_string;
  `endif


  `ifndef SYNTHESIS
  always @(*) begin
    case(fsmUartTx_stateReg)
      fsmUartTx_enumDef_BOOT : fsmUartTx_stateReg_string = "BOOT ";
      fsmUartTx_enumDef_IDLE : fsmUartTx_stateReg_string = "IDLE ";
      fsmUartTx_enumDef_START : fsmUartTx_stateReg_string = "START";
      fsmUartTx_enumDef_DATA : fsmUartTx_stateReg_string = "DATA ";
      fsmUartTx_enumDef_STOP : fsmUartTx_stateReg_string = "STOP ";
      default : fsmUartTx_stateReg_string = "?????";
    endcase
  end
  always @(*) begin
    case(fsmUartTx_stateNext)
      fsmUartTx_enumDef_BOOT : fsmUartTx_stateNext_string = "BOOT ";
      fsmUartTx_enumDef_IDLE : fsmUartTx_stateNext_string = "IDLE ";
      fsmUartTx_enumDef_START : fsmUartTx_stateNext_string = "START";
      fsmUartTx_enumDef_DATA : fsmUartTx_stateNext_string = "DATA ";
      fsmUartTx_enumDef_STOP : fsmUartTx_stateNext_string = "STOP ";
      default : fsmUartTx_stateNext_string = "?????";
    endcase
  end
  `endif

  assign MARK = 1'b1;
  assign SPACE = 1'b0;
  always @(*) begin
    io_ready = 1'b0;
    case(fsmUartTx_stateReg)
      fsmUartTx_enumDef_IDLE : begin
      end
      fsmUartTx_enumDef_START : begin
      end
      fsmUartTx_enumDef_DATA : begin
        if(io_txClockStb) begin
          if(when_ModemTop_l389) begin
            io_ready = 1'b1;
          end
        end
      end
      fsmUartTx_enumDef_STOP : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_uartTxOut = MARK;
    case(fsmUartTx_stateReg)
      fsmUartTx_enumDef_IDLE : begin
        io_uartTxOut = MARK;
      end
      fsmUartTx_enumDef_START : begin
        io_uartTxOut = SPACE;
      end
      fsmUartTx_enumDef_DATA : begin
        io_uartTxOut = io_data[bitId];
      end
      fsmUartTx_enumDef_STOP : begin
        io_uartTxOut = MARK;
      end
      default : begin
      end
    endcase
  end

  assign fsmUartTx_wantExit = 1'b0;
  always @(*) begin
    fsmUartTx_wantStart = 1'b0;
    case(fsmUartTx_stateReg)
      fsmUartTx_enumDef_IDLE : begin
      end
      fsmUartTx_enumDef_START : begin
      end
      fsmUartTx_enumDef_DATA : begin
      end
      fsmUartTx_enumDef_STOP : begin
      end
      default : begin
        fsmUartTx_wantStart = 1'b1;
      end
    endcase
  end

  assign fsmUartTx_wantKill = 1'b0;
  always @(*) begin
    fsmUartTx_stateNext = fsmUartTx_stateReg;
    case(fsmUartTx_stateReg)
      fsmUartTx_enumDef_IDLE : begin
        if(io_valid) begin
          fsmUartTx_stateNext = fsmUartTx_enumDef_START;
        end
      end
      fsmUartTx_enumDef_START : begin
        if(io_txClockStb) begin
          fsmUartTx_stateNext = fsmUartTx_enumDef_DATA;
        end
      end
      fsmUartTx_enumDef_DATA : begin
        if(io_txClockStb) begin
          if(when_ModemTop_l389) begin
            fsmUartTx_stateNext = fsmUartTx_enumDef_STOP;
          end
        end
      end
      fsmUartTx_enumDef_STOP : begin
        if(io_txClockStb) begin
          if(io_valid) begin
            fsmUartTx_stateNext = fsmUartTx_enumDef_START;
          end else begin
            fsmUartTx_stateNext = fsmUartTx_enumDef_IDLE;
          end
        end
      end
      default : begin
      end
    endcase
    if(fsmUartTx_wantStart) begin
      fsmUartTx_stateNext = fsmUartTx_enumDef_IDLE;
    end
    if(fsmUartTx_wantKill) begin
      fsmUartTx_stateNext = fsmUartTx_enumDef_BOOT;
    end
  end

  assign when_ModemTop_l389 = (bitId == 3'b111);
  always @(posedge clk) begin
    if(!rst_n) begin
      fsmUartTx_stateReg <= fsmUartTx_enumDef_BOOT;
    end else begin
      fsmUartTx_stateReg <= fsmUartTx_stateNext;
    end
  end

  always @(posedge clk) begin
    case(fsmUartTx_stateReg)
      fsmUartTx_enumDef_IDLE : begin
      end
      fsmUartTx_enumDef_START : begin
        if(io_txClockStb) begin
          bitId <= 3'b000;
        end
      end
      fsmUartTx_enumDef_DATA : begin
        if(io_txClockStb) begin
          if(!when_ModemTop_l389) begin
            bitId <= (bitId + 3'b001);
          end
        end
      end
      fsmUartTx_enumDef_STOP : begin
      end
      default : begin
      end
    endcase
  end


endmodule

module UartFifo (
  input      [7:0]    io_dataIn,
  input               io_dataInEn,
  input               io_dataOutEn,
  output     [7:0]    io_dataOut,
  output              io_full,
  output              io_almostFull,
  output              io_almostEmpty,
  output              io_empty,
  output              io_eoverrun,
  input               clk,
  input               rst_n
);

  reg        [7:0]    _zz_io_dataOut;
  reg        [7:0]    fifo_0;
  reg        [7:0]    fifo_1;
  reg        [7:0]    fifo_2;
  reg        [7:0]    fifo_3;
  reg        [1:0]    nextOut;
  reg        [1:0]    nextIn;
  reg        [2:0]    count;
  wire                when_ModemTop_l318;
  wire       [3:0]    _zz_1;

  always @(*) begin
    case(nextOut)
      2'b00 : _zz_io_dataOut = fifo_0;
      2'b01 : _zz_io_dataOut = fifo_1;
      2'b10 : _zz_io_dataOut = fifo_2;
      default : _zz_io_dataOut = fifo_3;
    endcase
  end

  assign when_ModemTop_l318 = (io_dataInEn && io_dataOutEn);
  assign _zz_1 = ({3'd0,1'b1} <<< nextIn);
  assign io_dataOut = _zz_io_dataOut;
  assign io_full = (count == 3'b100);
  assign io_almostFull = (count == 3'b011);
  assign io_almostEmpty = (count == 3'b001);
  assign io_empty = (count == 3'b000);
  assign io_eoverrun = ((count == 3'b100) && io_dataInEn);
  always @(posedge clk) begin
    if(!rst_n) begin
      nextOut <= 2'b00;
      nextIn <= 2'b00;
      count <= 3'b000;
    end else begin
      if(!when_ModemTop_l318) begin
        if(io_dataInEn) begin
          count <= (count + 3'b001);
        end else begin
          if(io_dataOutEn) begin
            count <= (count - 3'b001);
          end
        end
      end
      if(io_dataInEn) begin
        nextIn <= (nextIn + 2'b01);
      end
      if(io_dataOutEn) begin
        nextOut <= (nextOut + 2'b01);
      end
    end
  end

  always @(posedge clk) begin
    if(io_dataInEn) begin
      if(_zz_1[0]) begin
        fifo_0 <= io_dataIn;
      end
      if(_zz_1[1]) begin
        fifo_1 <= io_dataIn;
      end
      if(_zz_1[2]) begin
        fifo_2 <= io_dataIn;
      end
      if(_zz_1[3]) begin
        fifo_3 <= io_dataIn;
      end
    end
  end


endmodule

module Scrambler (
  input               io_dataIn,
  input               io_en,
  input               io_sim,
  output              io_vecOut_0,
  output              io_vecOut_1,
  output              io_vecOut_2,
  output              io_vecOut_3,
  output              io_vecOut_4,
  output              io_vecOut_5,
  output              io_vecOut_6,
  output              io_vecOut_7,
  output              io_vecOut_8,
  output              io_vecOut_9,
  output              io_vecOut_10,
  output              io_vecOut_11,
  output              io_vecOut_12,
  output              io_vecOut_13,
  output              io_vecOut_14,
  output              io_vecOut_15,
  output              io_dataOut,
  input               rst_n,
  input               clk
);

  wire       [16:0]   _zz__zz_io_vecOut_0;
  wire       [0:0]    _zz__zz_io_vecOut_0_1;
  wire       [5:0]    _zz__zz_io_vecOut_0_2;
  reg                 vec_0;
  reg                 vec_1;
  reg                 vec_2;
  reg                 vec_3;
  reg                 vec_4;
  reg                 vec_5;
  reg                 vec_6;
  reg                 vec_7;
  reg                 vec_8;
  reg                 vec_9;
  reg                 vec_10;
  reg                 vec_11;
  reg                 vec_12;
  reg                 vec_13;
  reg                 vec_14;
  reg                 vec_15;
  reg                 vec_16;
  wire                partial;
  wire                result;
  wire                when_ModemTop_l197;
  wire       [15:0]   _zz_io_vecOut_0;

  assign _zz__zz_io_vecOut_0 = {vec_16,{vec_15,{vec_14,{vec_13,{vec_12,{vec_11,{vec_10,{vec_9,{vec_8,{vec_7,{_zz__zz_io_vecOut_0_1,_zz__zz_io_vecOut_0_2}}}}}}}}}}};
  assign _zz__zz_io_vecOut_0_1 = vec_6;
  assign _zz__zz_io_vecOut_0_2 = {vec_5,{vec_4,{vec_3,{vec_2,{vec_1,vec_0}}}}};
  assign partial = (vec_16 ^ vec_11);
  assign result = (partial ^ io_dataIn);
  assign when_ModemTop_l197 = (! rst_n);
  assign io_dataOut = result;
  assign _zz_io_vecOut_0 = _zz__zz_io_vecOut_0[15 : 0];
  assign io_vecOut_0 = _zz_io_vecOut_0[0];
  assign io_vecOut_1 = _zz_io_vecOut_0[1];
  assign io_vecOut_2 = _zz_io_vecOut_0[2];
  assign io_vecOut_3 = _zz_io_vecOut_0[3];
  assign io_vecOut_4 = _zz_io_vecOut_0[4];
  assign io_vecOut_5 = _zz_io_vecOut_0[5];
  assign io_vecOut_6 = _zz_io_vecOut_0[6];
  assign io_vecOut_7 = _zz_io_vecOut_0[7];
  assign io_vecOut_8 = _zz_io_vecOut_0[8];
  assign io_vecOut_9 = _zz_io_vecOut_0[9];
  assign io_vecOut_10 = _zz_io_vecOut_0[10];
  assign io_vecOut_11 = _zz_io_vecOut_0[11];
  assign io_vecOut_12 = _zz_io_vecOut_0[12];
  assign io_vecOut_13 = _zz_io_vecOut_0[13];
  assign io_vecOut_14 = _zz_io_vecOut_0[14];
  assign io_vecOut_15 = _zz_io_vecOut_0[15];
  always @(posedge clk) begin
    vec_0 <= result;
    if(!when_ModemTop_l197) begin
      if(io_en) begin
        vec_1 <= vec_0;
        vec_2 <= vec_1;
        vec_3 <= vec_2;
        vec_4 <= vec_3;
        vec_5 <= vec_4;
        vec_6 <= vec_5;
        vec_7 <= vec_6;
        vec_8 <= vec_7;
        vec_9 <= vec_8;
        vec_10 <= vec_9;
        vec_11 <= vec_10;
        vec_12 <= vec_11;
        vec_13 <= vec_12;
        vec_14 <= vec_13;
        vec_15 <= vec_14;
        vec_16 <= vec_15;
      end
    end
  end


endmodule

module BufferCC (
  input               io_dataIn,
  output              io_dataOut,
  input               clk,
  input               rst_n
);

  (* async_reg = "true" *) reg                 buffers_0;
  (* async_reg = "true" *) reg                 buffers_1;

  assign io_dataOut = buffers_1;
  always @(posedge clk) begin
    buffers_0 <= io_dataIn;
    buffers_1 <= buffers_0;
  end


endmodule
