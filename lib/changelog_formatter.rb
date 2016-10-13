require "changelog_formatter/version"

class ChangelogFormatter

  CHANGELOG_ICONS = {
    new: 'plus',
    enh: 'wrench',
    fix: 'bug',
    del: 'minus',
  }

  attr :lines
  attr :name

  def initialize(name)
    @name  = name
    @lines = []
  end

  def self.to_a
    releases = []
    release = ChangelogFormatter.new("Next Release")
    File.open('CHANGELOG') do |f|
      f.each_line do |line|
        if line =~ /^Release/
          releases << release unless release.lines.size == 0
          release = ChangelogFormatter.new(line.strip)
        else
          release.add_line(line) unless line.blank?
        end
      end
    end
    releases << release
  end

  def add_line(line)
    line = line.strip
    line =~ /^\[(.*)\] (.*)/
    if $1
      lines << [$1, $2]
    end
  end

  def date
    if name =~ / (\d{4})-(\d{2})-(\d{2})-(\d{2})(\d{2})/
      zone_total_offset = TZInfo::Timezone.get("Europe/Amsterdam").current_period.offset.utc_total_offset / 3600
      Time.new($1, $2, $3, $4, $5, 0, "+%02d:00" % zone_total_offset)
    end
  end

end
