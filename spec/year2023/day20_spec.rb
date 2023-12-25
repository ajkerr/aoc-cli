require 'spec_helper'

RSpec.describe Year2023::Day20 do
  let(:sample1) do
    <<~'EOF'
      broadcaster -> a, b, c
      %a -> b
      %b -> c
      %c -> inv
      &inv -> a
    EOF
  end

  let(:sample2) do
    <<~'EOF'
      broadcaster -> a
      %a -> inv, con
      &inv -> b
      %b -> con
      &con -> output
    EOF
  end

  it "solves part1" do
    d = Year2023::Day20.new
    expect(d.part1(sample1)).to eq(32000000)
    expect(d.part1(sample2)).to eq(11687500)
  end

  it "solves part2" do
    d = Year2023::Day20.new
    expect(d.part2('some_input')).to eq(nil)
  end
end
