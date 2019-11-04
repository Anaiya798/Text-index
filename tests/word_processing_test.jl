#=
word_processing_test:
- Julia version: 
- Author: Анастасия
- Date: 2019-11-03
=#
include("../src/Lib.jl")
using .Lib
using Test

@testset "word_processing" begin
    word1 = "too"
    words_top1 = Dict()
    counter1 = 1
    @test Lib.word_processing(word1, words_top1, counter1) == Dict("too" => Any[1, [1]])

    word2 = "mio"
    words_top2 = Dict("my" => Any[1, [1]],"oh" => Any[1, [1]],"mio" => Any[1, [1]])
    counter2 = 2
    @test Lib.word_processing(word2, words_top2, counter2) == Dict("my" => Any[1, [1]],"oh" => Any[1, [1]],"mio" => Any[2, [1]])

    word3 = "лето"
    words_top3 = Dict("лето" => Any[1, [1]],"весна" => Any[1, [1]], "зима" => Any[1, [1]])
    counter3 = 1
    @test Lib.word_processing(word3, words_top3, counter3) == Dict("лето" => Any[2, [1]],"весна" => Any[1, [1]],"зима" => Any[1, [1]])


end