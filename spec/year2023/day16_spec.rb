require 'spec_helper'

RSpec.describe Year2023::Day16 do
  let(:sample) do
    <<~'EOF'
      .|...\....
      |.-.\.....
      .....|-...
      ........|.
      ..........
      .........\
      ..../.\\..
      .-.-/..|..
      .|....-|.\
      ..//.|....
    EOF
  end

  it "solves part1" do
    d = Year2023::Day16.new
    expect(d.part1(sample)).to eq(46)
  end

  it "solves part2" do
    d = Year2023::Day16.new
    expect(d.part2(sample)).to eq(51)
  end
end
