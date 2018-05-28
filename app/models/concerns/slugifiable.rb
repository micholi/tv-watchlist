module Slugifiable

  def slug
    self.name.downcase.gsub("'", "").gsub(" ", "-")
  end

  def find_by_slug(arg)
    self.all.find {|s| s.slug == arg}
  end

end
