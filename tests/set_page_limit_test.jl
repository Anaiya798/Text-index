#=
change_page_limit_test:
- Julia version: 
- Author: Анастасия
- Date: 2019-11-03
=#
include("../src/Lib.jl")
using .Lib
using Test

@testset "set_page_limit" begin
    check1 = 0
    n1 = 0
    @test Lib.change_page_limit(check1, n1) == 45

    check2 = 1
    n2 = 39
    @test Lib.set_page_limit(check2, n2) == 39
end