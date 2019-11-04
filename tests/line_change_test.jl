#=
line_change_test:
- Julia version: 
- Author: Анастасия
- Date: 2019-11-03
=#
include("../src/Lib.jl")
using .Lib
using Test

@testset "line_change" begin
    line1::String = "Meet my family."
    @test Lib.line_change(line1) == ["meet", "my", "family"]

    line2::String = "There are four of us – my parents, my elder brother and me."
    @test Lib.line_change(line2)==["there", "are", "four", "of", "us", "my", "parents", "my", "elder", "brother", "and", "me"]

    line3::String = "Hey!?#%;:*-+"
    @test Lib.line_change(line3)==["hey"]

    line4::String = "Время течёт удивительно быстро."
    @test Lib.line_change(line4)==["время", "течёт", "удивительно", "быстро"]

    line5::String = "Пролетят ли они так же быстро?!*~"
    @test Lib.line_change(line5)==["пролетят", "ли", "они", "так", "же", "быстро"]

end

