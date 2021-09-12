using Pkg
Pkg.activate(".")
try
    Pkg.instantiate()
catch
    Pkg.add("CSV"); Pkg.add("DataFrames"); Pkg.add("Flux"); Pkg.add("HTTP"); Pkg.add("JSON"); Pkg.add("Statistics")
end
println("\e[32;1mCompleted setup!\e[0m")