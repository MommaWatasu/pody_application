function CTOH(ts) #This is Convert to one hot
    try
        ts = broadcast(Int, ts)
    catch 
        throw("Perhaps the array of objective variables you passed has a non-zero decimal point in the name of the class (as in 1.1). Please change it to an integer type.")
    end
    if 0 in ts
        ts .+= 1
    end
    c = maximum(ts)
    oh = zeros(length(ts), c)
    i = 1
    for t in ts
        oh[i, t] = 1.0
        i += 1
    end
    return oh
end
