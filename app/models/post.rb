class Post < ActiveRecord::Base

  validate :is_title_case 
  before_validation :make_title_case 
  belongs_to :author

  #put new code here
  #def self.filter(author_id, date)
   # if author_id.present? && date.present?
    #  if date == "Today"
     #   where({author_id: author_id, created_at: Time.zone.today.beginning_of_day})
      #else
       # where("author_id=? and created_at < ?",author_id, Time.zone.today.beginning_of_day)
      #end
    #elsif author_id.present?
     # where(author: author_id)
      
    #elsif date.present?
     # if date == "Today"
      #  where("created_at >=?", Time.zone.today.beginning_of_day)
      #else
       # where("created_at <?", Time.zone.today.beginning_of_day)
      #end
      
    #else
      #self.all
    #end
  #end

  def self.by_author(author_id)
    where(author_id: author_id)
  end

  def self.from_today
    where("created_at >=?", Time.zone.today.beginning_of_day)
  end
   
  def self.old_news
    where("created_at <?", Time.zone.today.beginning_of_day)
  end

  private

  def is_title_case
    if title.split.any?{|w|w[0].upcase != w[0]}
      errors.add(:title, "Title must be in title case")
    end
  end

  def make_title_case
    self.title = self.title.titlecase
  end
end
