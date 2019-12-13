class Sale < ActiveRecord::Base

  validates :name, presence: true
  validates :starts_on, presence: true
  validates :ends_on, presence: true
  validates :percent_off, presence: true

  def self.active
    where("sales.starts_on <= ? AND sales.ends_on >= ?", Date.today, Date.today)
  end

  def finished?
    Date.today > ends_on
  end
  
  def upcoming?
    Date.today < starts_on
  end

  def active?
    !finished? && !upcoming?
  end

end
