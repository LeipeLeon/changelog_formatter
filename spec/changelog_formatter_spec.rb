require "spec_helper"

describe ChangelogFormatter do
  it "has a version number" do
    expect(ChangelogFormatter::VERSION).not_to be nil
  end

  describe '#to_a' do
    it "Generates an array" do
      expect(
        ChangelogFormatter.to_a('spec/fixtures/CHANGELOG_1').first.lines
      ).to eq(
        [
          ["enh", "Use Google Analytics code from organisation on embed page."],
          ["enh", "remove phone from embed page & change email into support@ticketpunk.com"]
        ]
      )
    end
    it "Ignores lines startign wit a dash" do
      expect(
        ChangelogFormatter.to_a('spec/fixtures/CHANGELOG_2').first.lines
      ).to eq(
        [
          ["enh", "remove phone from embed page & change email into support@ticketpunk.com"]
        ]
      )
    end
  end
end
