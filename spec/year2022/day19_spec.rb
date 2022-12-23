require 'spec_helper'

RSpec.describe Year2022::Day19 do
  let(:sample) do
    <<~EOF
      Blueprint 1: Each ore robot costs 4 ore. Each clay robot costs 2 ore. Each obsidian robot costs 3 ore and 14 clay. Each geode robot costs 2 ore and 7 obsidian.
      Blueprint 2: Each ore robot costs 2 ore. Each clay robot costs 3 ore. Each obsidian robot costs 3 ore and 8 clay. Each geode robot costs 3 ore and 12 obsidian.
    EOF
  end

  it "solves part1" do
    d = Year2022::Day19.new
    expect(d.part1(sample)).to eq(33)
  end

  it "solves part2" do
    d = Year2022::Day19.new
    expect(d.part2('some_input')).to eq(nil)
  end
end
