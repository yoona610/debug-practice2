class Book < ApplicationRecord
	belongs_to :user
	has_many :book_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy

	def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.this_week
  	Book.joins(:favorites).where(favorites:{created_at: Date.today.beginning_of_week.. Date.today.beginning_of_week(:sunday)}).group(:id).order("count(*) desc")
  end

  is_impressionable counter_cache: true

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
end