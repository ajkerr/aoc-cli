require 'spec_helper'

RSpec.describe Year2023::Day10 do
  let(:sample1) do
    <<~EOF
      .....
      .S-7.
      .|.|.
      .L-J.
      .....
    EOF
  end

  let(:sample2) do
    <<~EOF
      ..F7.
      .FJ|.
      SJ.L7
      |F--J
      LJ...
    EOF
  end

  let(:sample3) do
    <<~EOF
      ...........
      .S-------7.
      .|F-----7|.
      .||.....||.
      .||.....||.
      .|L-7.F-J|.
      .|..|.|..|.
      .L--J.L--J.
      ...........
    EOF
  end

  let(:sample4) do
    <<~EOF
      ..........
      .S------7.
      .|F----7|.
      .||....||.
      .||....||.
      .|L-7F-J|.
      .|..||..|.
      .L--JL--J.
      ..........
    EOF
  end

  let(:sample5) do
    <<~EOF
      FF7FSF7F7F7F7F7F---7
      L|LJ||||||||||||F--J
      FL-7LJLJ||||||LJL-77
      F--JF--7||LJLJ7F7FJ-
      L---JF-JLJ.||-FJLJJ7
      |F|F-JF---7F7-L7L|7|
      |FFJF7L7F-JF7|JL---7
      7-L-JL7||F7|L7F-7F7|
      L.L7LFJ|||||FJL7||LJ
      L7JLJL-JLJLJL--JLJ.L
    EOF
  end

  it "solves part1" do
    d = Year2023::Day10.new
    expect(d.part1(sample1, start_pipe: 'F')).to eq(4)
    expect(d.part1(sample2, start_pipe: 'F')).to eq(8)
  end

  it "solves part2" do
    d = Year2023::Day10.new
    expect(d.part2(sample3, start_pipe: 'F')).to eq(4)
    expect(d.part2(sample4, start_pipe: 'F')).to eq(4)
    expect(d.part2(sample5, start_pipe: '7')).to eq(10)
  end
end
