solve(P, Refund, Win, Loss, Result) :-
    Factor is (1 - P) / P,
    X is Factor ** Loss,
    Y is Factor ** (Win + Loss),
    PWin is (1 - X) / (1 - Y),
    PLoss is 1 - PWin,
    Result is (PWin * Win) - (PLoss * Loss * (1 - Refund)).

max_expected_profit(X, PPercent, MaxProfit) :-
    Refund is X / 100,
    P is PPercent / 100,
    max_expected_profit_loop(P, Refund, 1, 1, 0, MaxProfit).

max_expected_profit_loop(P, Refund, Loss, BestWin, BestProfit, MaxProfit) :-
    ( P =:= 0 -> MaxProfit = 0
    ;   try_wins(P, Refund, Loss, 1, 0, 0, BestWinOut, BestProfitOut),
        ( BestProfitOut > BestProfit ->
            Loss1 is Loss + 1,
            max_expected_profit_loop(P, Refund, Loss1, BestWinOut, BestProfitOut, MaxProfit)
        ;   MaxProfit = BestProfit
        )
    ).

try_wins(P, Refund, Loss, Win, Prev, BestSoFar, BestWin, BestProfit) :-
    solve(P, Refund, Win, Loss, Cur),
    ( Cur > BestSoFar ->
        NewBest is Cur,
        NewBestWin is Win
    ;   NewBest = BestSoFar,
        NewBestWin = BestWin
    ),
    ( Cur >= Prev ->
        Win1 is Win + 1,
        try_wins(P, Refund, Loss, Win1, Cur, NewBest, NewBestWin, BestProfit)
    ;   BestWin = NewBestWin,
        BestProfit = NewBest
    ).

%max_expected_profit(0, 49.9, Profit).
%0

%max_expected_profit(50, 49.85, Profit).
%7.101784529895312

%max_expected_profit(100, 10.3, Profit).
%0.11482720178372352

%max_expected_profit(94, 12.45, Profit).
%0.07196999999999995

%max_expected_profit(80, 39.74, Profit).
%0.331545593477868
