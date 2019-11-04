#=
main:
- Julia version: 
- Author: Анастасия
- Date: 2019-10-12
=#
include("Lib.jl") #логирование; результаты команд debug и info записываются в файл working_process
using .Lib
using Logging
logger = ConsoleLogger(open("working_process.txt", "w+"), Logging.Debug)
with_logger(logger) do
println(id("OK"))
end
