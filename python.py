import math

refund = 0.0
p = 0.0

def solve(win, loss):
    factor = (1 - p) / p
    x = math.pow(factor, loss)
    y = math.pow(factor, win + loss)

    p_win = (1 - x) / (1 - y)
    p_loss = 1 - p_win

    return -p_loss * loss * (1 - refund) + p_win * win


def max_profit(ref, prob):
    global refund, p

    refund = ref / 100
    p = prob / 100

    best = 0.0
    best_win = 1
    loss = 1

    while True:
        if p == 0:
            break

        prev = 0.0
        cont = False
        win = best_win

        while True:
            cur = solve(win, loss)

            if cur > best:
                best = cur
                best_win = win
                cont = True

            if cur < prev:
                break
            prev = cur
            win += 1

        if not cont:
            break
        loss += 1

    return best

def main():
    r = float(input("r: "))
    p = float(input("p: "))
    result = max_profit(r, p)
    print("Max expected profit: %.8f" % result)

main()

#r: 0
#p: 49.9
#Max expected profit: 0.00000000

#r: 50
#p: 49.85
#Max expected profit: 7.10178453

#r: 100
#p: 10.3
#Max expected profit: 0.11482720

#r: 94
#p: 12.45
#Max expected profit: 0.07197000

#r: 80
#p: 39.74
#Max expected profit: 0.33154559
