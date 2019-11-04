#=
ignore_checking_test:
- Julia version: 
- Author: Анастасия
- Date: 2019-11-03
=#
include("../src/Lib.jl")
using .Lib
using Test

@testset "ignore_checking" begin
   words_top1 = Dict()
   words1 = ["meet", "my", "family"]
   counter1 = 1
   @test Lib.ignore_checking(words_top1, words1, counter1) == Dict("family" => Any[1, [1]],"my" => Any[1, [1]],"meet" => Any[1, [1]])

   words_top2 = Dict("early" => Any[1, [1]],"too" => Any[1, [1]])
   words2 =  ["too", "hot"]
   counter2 = 2
   @test Lib.ignore_checking(words_top2, words2, counter2) == Dict("hot" => Any[1, [1]],"early" => Any[1, [1]],"too" => Any[2, [1]])


   words_top3 = Dict()
   words3 =  ["только", "кто-либо", "кое-что", "должен", "сделать"]
   counter2 = 2
   @test Lib.ignore_checking(words_top3, words3, counter3) == Dict("должен" => Any[1, [1]],"сделать" => Any[1, [1]])




end