require 'spec_helper'

RSpec.describe Year2022::Day16 do
  let(:sample) do
    <<~EOF
      Valve AA has flow rate=0; tunnels lead to valves DD, II, BB
      Valve BB has flow rate=13; tunnels lead to valves CC, AA
      Valve CC has flow rate=2; tunnels lead to valves DD, BB
      Valve DD has flow rate=20; tunnels lead to valves CC, AA, EE
      Valve EE has flow rate=3; tunnels lead to valves FF, DD
      Valve FF has flow rate=0; tunnels lead to valves EE, GG
      Valve GG has flow rate=0; tunnels lead to valves FF, HH
      Valve HH has flow rate=22; tunnel leads to valve GG
      Valve II has flow rate=0; tunnels lead to valves AA, JJ
      Valve JJ has flow rate=21; tunnel leads to valve II
    EOF
  end

  it "solves part1" do
    d = Year2022::Day16.new
    expect(d.part1(sample)).to eq(1651)
  end

  it "solves part2" do
    d = Year2022::Day16.new
    expect(d.part2(sample)).to eq(1707)
  end
end
