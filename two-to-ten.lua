-- Функция для вывода табуляции
function tab(spaces)
    return string.rep(" ", spaces)
end

-- Начало основной программы
print(tab(28) .. "TWO TO TEN")
print(tab(15) .. "CREATIVE COMPUTING  MORRISTOWN NEW JERSEY")
print()
print()
print()
print("WELCOME TO THE GAME OF TWO TO TEN.  THAT NAME COMES FROM THE")
print("SPECIAL 'DECK OF CARDS' USED. THERE ARE NO FACE CARDS - ONLY")
print("THE CARDS 2-10.  THIS GAME IS EASY AND FUN TO PLAY IF YOU")
print("UNDERSTAND WHAT YOU ARE DOING SO READ THE INSTRUCTIONS")
print("CAREFULLY.")
print("AT THE START OF THE GAME, YOU BET ON WINNING. TYPE IN ANY")
print("NUMBER BETWEEN 0 AND 200.  I THEN PICK A RANDOM NUMBER")
print("YOU ARE TO REACH BY THE SUM TOTAL OF MORE CARDS CHOSEN.")
print("BECAUSE OF THE RARE CHANCE OF YOU GETTING TO THAT NUMBER")
print("EXACTLY, YOU ARE GIVEN AN ALLOWANCE CARD.  THE OBJECT OF")
print("THE GAME OF TO GET THE TOTAL OF CARDS WITHIN THE MYSTERY")
print("NUMBER WITHOUT GOING OVER.")
print("YOU ARE GIVEN A HINT AS TO WHAT THE NUMBER IS.  THIS IS NOT")
print("THE EXACT NUMBER ONLY ONE CLOSE. ALL YOU DO IN THIS GAME IS")
print("DECIDE WHEN TO STOP.  AT THIS POINT YOUR TOTAL IS COMPARED")
print("WITH THE NUMBER AND YOUR WINNINGS ARE DETERMINED.")

local M = 200
local D = 0
local T = 0
local Q -- Объявляем Q вне цикла

::main_game_loop::
    local O = math.floor(10 * math.random() + 25)
    local N = math.floor(O * math.random())
    local R = (math.floor(15 * math.random() + 1)) / 100
    local S = math.floor(2 * math.random() + 1)
    local E

    if S ~= 1 then
        E = math.floor(N - (N * R))
    else
        E = math.floor(N + (N * R))
    end

    local A = math.floor(9 * math.random() + 2)

    print()
    io.write("PLACE YOUR BET ... YOU HAVE $" .. M .. " TO SPEND.")
    io.write("  ") -- Отступ перед вводом
    local B = tonumber(io.read())
    print()

    if B < 0 then
        print("YOU MAY NOT BET AGAINST YOURSELF.")
        goto continue_betting
    end

    if M < B then
        print("YOU CAN'T BET MORE THAT YOU'VE GOT!")
        goto continue_betting
    end

    print("YOUR 'LUCKY LIMIT' CARD IS A " .. A)
    print("YOU MUST COME WITHIN " .. A .. " WITHOUT GOING OVER TO WIN.")
    print()
    print("HERE WE GO")
    print()
    print()

    D = 0

    ::card_loop::
        D = D + 1
        local C = math.floor(9 * math.random() + 2)
        print("CARD #" .. D .. " IS A " .. C .. ".YOU ARE TRYING TO COME NEAR " .. E)
        T = T + C

        if T > N then
            print("YOUR TOTAL IS OVER THE NUMBER" .. N .. " AN AUTOMATIC LOSS!")
            goto game_over
        end
        io.write("YOUR TOTAL IS " .. T .. "  DO YOU WANT TO CONTINUE")
        io.write("  ") -- Отступ перед вводом
        Q = io.read()
        print()
        if string.sub(Q, 1, 1) == "Y" then
          goto card_loop
        end

    if T < N - A or T > N then
        print("YOU BLEW IT!  THE NUMBER WAS " .. N .. ", OUTSIDE YOUR LIMIT BY ")
        print(N - A - T)
        M = M - B
    else
        print("YOU WIN!  THE NUMBER WAS " .. N .. " YOUR GUESS TOTAL WAS" .. T)
        print("WITHIN YOUR LIMIT CARD.")
        M = M + B
    end

::game_over::
    print("YOU NOW HAVE $" .. M .. " IN CASH TO BET IN THE NEXT GAME!")
    if M <= 0 then
        print(string.char(7))
        print("YOU ARE BROKE!! YOU MAY NOT PLAY ANYMORE!!")
         goto end_game
    end

    io.write("WOULD YOU LIKE TO PLAY THE NEXT GAME")
    io.write("  ") -- Отступ перед вводом
    Q = io.read()

    if string.sub(Q, 1, 1) == "Y" then
        goto main_game_loop
    end
    
    print("HOPE YOU HAD FUN.")

::end_game::
::continue_betting::
-- Конец основной программы