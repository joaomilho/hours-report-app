class Report < ActiveRecord::Base
  has_many :days
  has_many :users, :through => :days

  validates :current, uniqueness: true, if: "current?"
  validates_datetime :start_date
  validates_date :end_date, :after => lambda { |report| report.start_date + 1.month }

  validates :start_date, :end_date,
    :overlap => { :message_title => :overlapping,
                  :message_content => "There is an overalapping report for the given dates" }

end
