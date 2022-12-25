require 'spec_helper'

RSpec.describe Year2022::Day24 do
  let(:sample) do
    <<~EOF
      #.######
      #>>.<^<#
      #.<..<<#
      #>v.><>#
      #<^v^^>#
      ######.#
    EOF
  end

  it "solves part1" do
    d = Year2022::Day24.new
    expect(d.part1(sample)).to eq(18)
  end

  it "solves part2" do
    d = Year2022::Day24.new
    expect(d.part2('some_input')).to eq(nil)
  end
end
