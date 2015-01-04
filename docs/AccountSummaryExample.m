%% Account Summary
% For most recent version, see the official docs at
% <http://softwarespartan.github.io/IB4m/docs/html/AccountSummaryExample.html github.io/IB4m>


%% Initialize session with Trader Workstation

% initialize session with TWS
session = TWS.Session.getInstance();

% create local buffer for account summary events 
[buf,lh] = TWS.initBufferForEvent(TWS.Events.ACCOUNTSUMMARY);

% list of account attributes to querey
attrkeys = [                               ...
            'AccountType'                 ,...
            'NetLiquidation'              ,...
            'TotalCashValue'              ,...
            'SettledCash'                 ,...
            'AccruedCash'                 ,...
            'BuyingPower'                 ,...
            'EquityWithLoanValue,'        ,...
            'PreviousEquityWithLoanValue,',...
            'GrossPositionValue,'         ,...
            'RegTEquity,RegTMargin,'      ,...
            'SMA,InitMarginReq,'          ,...
            'MaintMarginReq,'             ,...
            'AvailableFunds,'             ,...
            'ExcessLiquidity,'            ,...
            'Cushion,'                    ,...
            'FullInitMarginReq,'          ,...
            'FullMaintMarginReq,'         ,...
            'FullAvailableFunds,'         ,...
            'FullExcessLiquidity,'        ,...
            'LookAheadNextChange,'        ,...
            'LookAheadInitMarginReq,'     ,...
            'LookAheadMaintMarginReq,'    ,...
            'LookAheadAvailableFunds,'    ,...
            'LookAheadExcessLiquidity,'   ,...
            'HighestSeverity,'            ,...
            'DayTradesRemaining,'         ,...
            'Leverage'                     ...
           ];
   
% establish connection with TWS
session.eClientSocket.eConnect('127.0.0.1',7496,0);

%% Make request for account summary

% request account attributes
session.eClientSocket.reqAccountSummary(0,'All',attrkeys);  pause(1);

%% Processing Account Summary Events

% get the event from the local buffer and convert to cell array
attrs = collection2cell(buf.get().data);

% blab about account attributes
cellfun(@(a)                         ...
        fprintf('%s: %s = %s (%s)\n',...
                char(a.account )    ,...
                char(a.key     )    ,...
                char(a.value   )    ,...
                char(a.currency)     ...
               ),                    ...
        attrs                        ...
);

%% See Also
% <http://softwarespartan.github.io/IB4m/docs/html/AccountUpdatesExample.html AccountUpdatesExample> | <http://softwarespartan.github.io/IB4m/docs/html/PositionsExample.html PositionsExample>

%% References
% Interactive Brokers API: 
%
% * <https://www.interactivebrokers.com/en/software/api/apiguide/java/econnect.htm eConnect>
% * <https://www.interactivebrokers.com/en/software/api/apiguide/java/accountsummary.htm reqAccountSummary>
% 
% TWS@Github:
%
% * <https://github.com/softwarespartan/TWS/blob/master/src/com/tws/AccountAttribute.java AccountAttributes>
%
% Apache Commons:
%
% * <https://commons.apache.org/proper/commons-collections/javadocs/api-3.2.1/org/apache/commons/collections/buffer/CircularFifoBuffer.html CircularFifoBuffer>
%
% Oracle:
%
% * <http://docs.oracle.com/javase/8/docs/api/java/util/HashMap.html HashMap>
%