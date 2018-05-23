module Slugifiable

  def slug
    self.name.gsub(/\s/, "-")
  end

  def find_by_slug
    self.all.find {|s| s.slug == slug}
  end

end
