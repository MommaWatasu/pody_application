using Flux
using Flux: train!, mse, params
using HTTP
using JSON

include("./utils.jl")
include("./CTOH.jl")
include("./Data.jl")
include("./SS.jl")

const black = "\e[30;47;1m"
const api_url = "https://coincheck.com/api/ticker"

function get_data()
    r = HTTP.get(api_url)
    data = JSON.parse(String(r.body))
    return collect((data["last"], data["bid"], data["ask"], data["high"], data["low"], data["volume"]))
end

function predict(N, data)
    t = time_ns()
    p = N(data)
    t = Int64(time_ns() - t)
    p2 = (p[1]>=0.5) ? "\e[32;47;1mup" : "\e[31;47;1mdown"
    return p2, t
end

function main()
    println("This software predict the price of BTC.")
    println(black, "time, price, prediction, result(previous)\e[0m")
    d1, d2, d3, d4 = Dense(6, 10, relu), Dense(10, 20), Dense(20, 10, tanh), Dense(10, 1, sigmoid)
    N = Chain(d1, d2, d3, d4)
    PN = Chain(d1, PD(d2.weight, d2.bias), PD(d3.weight, d3.bias), d4)
    DATA = DataKeeper()
    loss(x, y) = mse(N(x), y)
    opt = ADAM()
    LAST = get_data()[1]
    while true
        temp = get_data()
        t = (temp[1] >= LAST) ? 1 : 0
        push!(DATA, (temp, t))
        train!(loss, params(N), DATA.data, opt)
        t = (t==1) ? "\e[32;47;1mup" : "\e[31;47;1mdown"
        p, ti = predict(PN, temp)
        println(black, ti, ", ", temp[1], ", ", p, ", ", t, "\e[0m")
        sleep(300)
    end
end

main()